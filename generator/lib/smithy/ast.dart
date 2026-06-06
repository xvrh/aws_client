import 'package:json_annotation/json_annotation.dart';

part 'ast.g.dart';

/// Parsed Smithy JSON AST (github.com/aws/api-models-aws). Shapes live in a flat
/// map keyed by absolute id (e.g. `com.amazonaws.sts#AssumeRole`); traits stay
/// raw so the IR adapter reads only the ids it needs and unknown keys parse fine.
@JsonSerializable(createToJson: false)
class SmithyModel {
  final String smithy;
  final Map<String, SmithyShape> shapes;

  SmithyModel(this.smithy, this.shapes);

  factory SmithyModel.fromJson(Map<String, dynamic> json) =>
      _$SmithyModelFromJson(json);

  MapEntry<String, SmithyShape> get service =>
      shapes.entries.firstWhere((e) => e.value.type == 'service',
          orElse: () => throw StateError('Model has no service shape'));
}

@JsonSerializable(createToJson: false)
class SmithyShape {
  final String type;

  // service / resource
  final String? version;
  final List<ShapeRef>? operations;
  final List<ShapeRef>? resources;

  // resource lifecycle bindings
  final ShapeRef? create;
  final ShapeRef? put;
  final ShapeRef? read;
  final ShapeRef? update;
  final ShapeRef? delete;
  final ShapeRef? list;
  final List<ShapeRef>? collectionOperations;

  // operation
  final ShapeRef? input;
  final ShapeRef? output;
  final List<ShapeRef>? errors;

  // structure / union
  final Map<String, ShapeRef>? members;

  // list / set
  final ShapeRef? member;

  // map
  final ShapeRef? key;
  final ShapeRef? value;

  @JsonKey(defaultValue: {})
  final Map<String, Object?> traits;

  SmithyShape(
    this.type,
    this.version,
    this.operations,
    this.resources,
    this.create,
    this.put,
    this.read,
    this.update,
    this.delete,
    this.list,
    this.collectionOperations,
    this.input,
    this.output,
    this.errors,
    this.members,
    this.member,
    this.key,
    this.value,
    this.traits,
  );

  factory SmithyShape.fromJson(Map<String, dynamic> json) =>
      _$SmithyShapeFromJson(json);
}

@JsonSerializable(createToJson: false)
class ShapeRef {
  final String target;

  @JsonKey(defaultValue: {})
  final Map<String, Object?> traits;

  ShapeRef(this.target, this.traits);

  factory ShapeRef.fromJson(Map<String, dynamic> json) =>
      _$ShapeRefFromJson(json);
}
