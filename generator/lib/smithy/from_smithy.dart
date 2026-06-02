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
  // (legacy protocol name, jsonVersion, uses X-Amz-Target prefix)
  final (protocol, jsonVersion, usesTarget) = switch (service.protocolTraitId) {
    TraitIds.awsJson1_0 => ('json', '1.0', true),
    TraitIds.awsJson1_1 => ('json', '1.1', true),
    TraitIds.restJson1 => ('rest-json', null, false),
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
    protocol: protocol,
    protocols: [protocol],
    jsonVersion: jsonVersion,
    serviceFullName: service.traits.string(TraitIds.title) ?? sdkId ?? endpointPrefix,
    serviceAbbreviation: sdkId,
    serviceId: sdkId,
    signatureVersion: 'v4',
    signingName:
        (signingName != null && signingName != endpointPrefix) ? signingName : null,
    targetPrefix: usesTarget ? _local(serviceEntry.key) : null,
    uid: uid,
    auth: sigv4 != null ? [TraitIds.sigv4] : null,
  );

  // Only REST protocols use HTTP bindings (httpLabel/Header/Query/Payload...);
  // awsJson/query/ec2 carry those traits in the model but ignore them on the
  // wire — everything goes in the body.
  final rest = protocol == 'rest-json' || protocol == 'rest-xml';

  final operations = <String, Operation>{};
  for (final ref in _collectOperations(model, service)) {
    final name = _local(ref.target);
    operations[name] = _operation(name, model.shapes[ref.target]!, rest);
  }

  final shapes = <String, Shape>{};
  model.shapes.forEach((id, shape) {
    if (const {'service', 'operation', 'resource'}.contains(shape.type)) return;
    final name = _local(id);
    if (shapes.containsKey(name)) {
      throw StateError('Shape name collision after namespace strip: $name');
    }
    shapes[name] = _shape(shape, rest);
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

/// Operations bound to a service include those reachable through its resource
/// closure (lifecycle bindings create/put/read/update/delete/list plus
/// operations/collectionOperations), recursively through nested resources.
List<ShapeRef> _collectOperations(SmithyModel model, SmithyShape service) {
  final refs = <ShapeRef>[];
  final seen = <String>{};

  void add(ShapeRef? r) {
    if (r != null && seen.add(r.target)) refs.add(r);
  }

  void walkResource(ShapeRef resourceRef) {
    final r = model.shapes[resourceRef.target];
    if (r == null) return;
    [r.create, r.put, r.read, r.update, r.delete, r.list].forEach(add);
    r.operations?.forEach(add);
    r.collectionOperations?.forEach(add);
    r.resources?.forEach(walkResource);
  }

  service.operations?.forEach(add);
  service.resources?.forEach(walkResource);
  return refs;
}

Operation _operation(String name, SmithyShape op, bool rest) => Operation(
      name: name,
      http: rest
          ? _http(op.traits.object(TraitIds.http))
          : const Http(method: 'POST', requestUri: '/'),
      authtype: switch (op.traits) {
        final t when t.has(TraitIds.optionalAuth) => 'none',
        final t when t.has(TraitIds.unsignedPayload) => 'v4-unsigned-body',
        _ => '',
      },
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

/// awsJson has no @http trait and defaults to POST "/"; rest protocols carry
/// method/uri/code on smithy.api#http.
Http _http(Map<String, Object?>? trait) {
  if (trait == null) return const Http(method: 'POST', requestUri: '/');
  return Http(
    method: trait['method'] as String? ?? 'POST',
    requestUri: trait['uri'] as String? ?? '/',
    responseCode: (trait['code'] as num?)?.toInt(),
  );
}

Shape _shape(SmithyShape shape, bool rest) {
  switch (shape.type) {
    case 'structure':
    case 'union':
      return _structure(shape, rest);
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

Shape _structure(SmithyShape shape, bool rest) {
  final members = <String, Member>{};
  final required = <String>[];
  String? payload;
  shape.members?.forEach((name, ref) {
    if (rest && ref.traits.has(TraitIds.httpPayload)) payload = name;
    members[name] = _member(name, ref, rest);
    if (ref.isRequired) required.add(name);
  });
  return Shape(
    type: 'structure',
    membersMap: members,
    required: required.isEmpty ? null : required,
    exception: shape.traits.has(TraitIds.error),
    payload: payload,
    documentation: _doc(shape.documentation),
  );
}

Member _member(String name, ShapeRef ref, bool rest) {
  final t = ref.traits;
  String? location;
  String? locationName = t.string(TraitIds.jsonName);
  if (rest) {
    if (t.has(TraitIds.httpLabel)) {
      location = 'uri';
      locationName = name;
    } else if (t.string(TraitIds.httpHeader) != null) {
      location = 'header';
      locationName = t.string(TraitIds.httpHeader);
    } else if (t.string(TraitIds.httpPrefixHeaders) != null) {
      location = 'headers';
      locationName = t.string(TraitIds.httpPrefixHeaders);
    } else if (t.string(TraitIds.httpQuery) != null) {
      location = 'querystring';
      locationName = t.string(TraitIds.httpQuery);
    } else if (t.has(TraitIds.httpResponseCode)) {
      location = 'statusCode';
    }
  }
  return Member(
    shape: _local(ref.target),
    documentation: _doc(ref.documentation),
    idempotencyToken: t.has(TraitIds.idempotencyToken),
    location: location,
    locationName: locationName,
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
