import '../model/api.dart';
import '../model/descriptor.dart';
import '../model/operation.dart';
import '../model/shape.dart';
import 'ast.dart';
import 'traits.dart';

/// Builds the generator's typed [Api] model directly from a parsed Smithy
/// model. This is the typed replacement for the legacy JSON ingestion: the
/// builders consume the same [Api]/[Shape]/[Operation] objects, but they now
/// originate from Smithy rather than `.normal.json`. Scope so far: the awsJson
/// family (awsJson1_0 / awsJson1_1).
///
/// [uid] is the legacy unique id (the model file basename); the AST omits it.
Api apiFromSmithy(SmithyModel model, {required String uid}) {
  final serviceEntry = model.service;
  final service = serviceEntry.value;
  final jsonVersion = switch (service.protocolTraitId) {
    TraitIds.awsJson1_0 => '1.0',
    TraitIds.awsJson1_1 => '1.1',
    final p => throw UnsupportedError('from_smithy: unsupported protocol $p'),
  };

  final svcTrait = service.traits.object(TraitIds.awsApiService) ?? const {};
  final sigv4 = service.traits.object(TraitIds.sigv4);
  final sdkId = svcTrait['sdkId'] as String?;
  final signingName = sigv4?['name'] as String?;
  // endpointPrefix is optional in Smithy; it defaults to arnNamespace.
  final endpointPrefix = (svcTrait['endpointPrefix'] ??
      svcTrait['arnNamespace'] ??
      signingName) as String?;

  final metadata = Metadata(
    apiVersion: service.version!,
    endpointPrefix: endpointPrefix!,
    protocol: 'json',
    protocols: const ['json'],
    jsonVersion: jsonVersion,
    serviceFullName: service.traits.string(TraitIds.title) ?? sdkId ?? endpointPrefix,
    serviceAbbreviation: sdkId,
    serviceId: sdkId,
    signatureVersion: 'v4',
    signingName:
        (signingName != null && signingName != endpointPrefix) ? signingName : null,
    targetPrefix: _local(serviceEntry.key),
    uid: uid,
    auth: sigv4 != null ? [TraitIds.sigv4] : null,
  );

  final operations = <String, Operation>{};
  for (final ref in service.operations ?? const <ShapeRef>[]) {
    final name = _local(ref.target);
    operations[name] = _operation(name, model.shapes[ref.target]!);
  }

  final shapes = <String, Shape>{};
  model.shapes.forEach((id, shape) {
    if (const {'service', 'operation', 'resource'}.contains(shape.type)) return;
    final name = _local(id);
    if (shapes.containsKey(name)) {
      throw StateError('Shape name collision after namespace strip: $name');
    }
    shapes[name] = _shape(shape);
  });
  _injectPreludeShapes(model, shapes);

  return Api(
    metadata: metadata,
    operations: operations,
    shapes: shapes,
    version: service.version,
    documentation: _doc(service.documentation),
  );
}

Operation _operation(String name, SmithyShape op) => Operation(
      name: name,
      http: const Http(method: 'POST', requestUri: '/'),
      authtype: op.traits.has(TraitIds.optionalAuth) ? 'none' : '',
      input: _descriptor(op.input),
      output: _descriptor(op.output),
      errors: op.errors == null || op.errors!.isEmpty
          ? null
          : [for (final e in op.errors!) Descriptor(shape: _local(e.target))],
      documentation: _doc(op.documentation),
    );

Descriptor? _descriptor(ShapeRef? ref) {
  if (ref == null || ref.target == 'smithy.api#Unit') return null;
  return Descriptor(shape: _local(ref.target));
}

Shape _shape(SmithyShape shape) {
  switch (shape.type) {
    case 'structure':
    case 'union':
      return _structure(shape);
    case 'enum':
      return _enum(shape);
    case 'list':
    case 'set':
      return Shape(
        type: 'list',
        member: Descriptor(shape: _local(shape.member!.target)),
        min: _bound(shape, 'min'),
        max: _bound(shape, 'max'),
        documentation: _doc(shape.documentation),
      );
    case 'map':
      return Shape(
        type: 'map',
        key: Descriptor(shape: _local(shape.key!.target)),
        value: Descriptor(shape: _local(shape.value!.target)),
        documentation: _doc(shape.documentation),
      );
    default:
      return Shape(
        type: shape.type,
        enumeration: _legacyEnumTrait(shape),
        pattern: shape.traits.string(TraitIds.pattern),
        min: _bound(shape, 'min'),
        max: _bound(shape, 'max'),
        documentation: _doc(shape.documentation),
      );
  }
}

Shape _structure(SmithyShape shape) {
  final members = <String, Member>{};
  final required = <String>[];
  shape.members?.forEach((name, ref) {
    members[name] = Member(
      shape: _local(ref.target),
      documentation: _doc(ref.documentation),
      idempotencyToken: ref.traits.has(TraitIds.idempotencyToken),
    );
    if (ref.isRequired) required.add(name);
  });
  return Shape(
    type: 'structure',
    membersMap: members,
    required: required.isEmpty ? null : required,
    exception: shape.traits.has(TraitIds.error),
    documentation: _doc(shape.documentation),
  );
}

Shape _enum(SmithyShape shape) {
  final values = <String>[];
  shape.members?.forEach((name, ref) {
    values.add(ref.traits.string('smithy.api#enumValue') ?? name);
  });
  return Shape(
    type: 'string',
    enumeration: values,
    documentation: _doc(shape.documentation),
  );
}

/// Older form: a string shape carrying the `smithy.api#enum` trait (a list of
/// `{value, name}` entries) instead of a dedicated enum shape.
List<String>? _legacyEnumTrait(SmithyShape shape) {
  final raw = shape.traits[TraitIds.enumTrait];
  if (raw is! List) return null;
  return [for (final e in raw.cast<Map>()) e['value'] as String];
}

num? _bound(SmithyShape shape, String key) {
  final c = shape.traits.object(TraitIds.length) ??
      shape.traits.object(TraitIds.range);
  return c?[key] as num?;
}

String _local(String shapeId) => shapeId.split('#').last;

/// Smithy prelude primitives have no shape definition in the model. Inject a
/// synthetic shape under the local name of any referenced prelude type so the
/// generator can resolve the member's type (the legacy JSON always had one).
const _preludePrimitives = {
  'smithy.api#String': 'string',
  'smithy.api#Boolean': 'boolean',
  'smithy.api#PrimitiveBoolean': 'boolean',
  'smithy.api#Byte': 'byte',
  'smithy.api#Short': 'short',
  'smithy.api#Integer': 'integer',
  'smithy.api#PrimitiveInteger': 'integer',
  'smithy.api#Long': 'long',
  'smithy.api#PrimitiveLong': 'long',
  'smithy.api#Float': 'float',
  'smithy.api#PrimitiveFloat': 'float',
  'smithy.api#Double': 'double',
  'smithy.api#PrimitiveDouble': 'double',
  'smithy.api#BigInteger': 'bigInteger',
  'smithy.api#BigDecimal': 'bigDecimal',
  'smithy.api#Timestamp': 'timestamp',
  'smithy.api#Blob': 'blob',
  'smithy.api#Document': 'document',
};

void _injectPreludeShapes(SmithyModel model, Map<String, Shape> shapes) {
  void visit(ShapeRef? ref) {
    final type = ref == null ? null : _preludePrimitives[ref.target];
    if (type != null) {
      shapes.putIfAbsent(_local(ref!.target), () => Shape(type: type));
    }
  }

  for (final shape in model.shapes.values) {
    shape.members?.values.forEach(visit);
    visit(shape.member);
    visit(shape.key);
    visit(shape.value);
  }
}

String? _doc(String? text) => text?.replaceAll(RegExp(r'\s+'), ' ').trim();
