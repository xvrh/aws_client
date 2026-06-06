import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable(createToJson: false, disallowUnrecognizedKeys: true)
class Config {
  final String awsSdkJsReference;

  /// Git reference of `aws-sdk-js-v3` to source the Smithy models from.
  /// Optional: only needed for the experimental Smithy generation path.
  final String? awsSdkJsV3Reference;

  Config(this.awsSdkJsReference, {this.awsSdkJsV3Reference});

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}
