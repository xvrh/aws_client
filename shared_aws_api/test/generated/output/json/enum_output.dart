// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name

import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_aws_api/shared.dart' as _s;
import 'package:shared_aws_api/shared.dart'
    show
        Uint8ListConverter,
        Uint8ListListConverter,
        rfc822ToJson,
        iso8601ToJson,
        unixTimestampToJson,
        timeStampFromJson;

export 'package:shared_aws_api/shared.dart' show AwsClientCredentials;

/// Enum output
class EnumOutput {
  final _s.JsonProtocol _protocol;
  EnumOutput({
    @_s.required String region,
    _s.AwsClientCredentials credentials,
    _s.Client client,
    String endpointUrl,
  }) : _protocol = _s.JsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'EnumOutput',
          ),
          region: region,
          credentials: credentials,
          endpointUrl: endpointUrl,
        );

  Future<OutputShape> operationName0() async {
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.0',
      'X-Amz-Target': 'EnumOutput.OperationName'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
    );

    return OutputShape.fromJson(jsonResponse.body);
  }
}

@_s.JsonSerializable(
    includeIfNull: false,
    explicitToJson: true,
    createFactory: true,
    createToJson: false)
class OutputShape {
  @_s.JsonKey(name: 'FooEnum')
  final JSONEnumType fooEnum;
  @_s.JsonKey(name: 'ListEnums')
  final List<JSONEnumType> listEnums;

  OutputShape({
    this.fooEnum,
    this.listEnums,
  });
  factory OutputShape.fromJson(Map<String, dynamic> json) {
    return OutputShape(
      fooEnum: (json['FooEnum'] as String)?.toJSONEnumType(),
      listEnums: (json['ListEnums'] as List)
          ?.map((e) => (e as String)?.toJSONEnumType())
          ?.toList(),
    );
  }
}

enum JSONEnumType {
  @_s.JsonValue('foo')
  foo,
  @_s.JsonValue('bar')
  bar,
}

extension on String {
  JSONEnumType toJSONEnumType() {
    switch (this) {
      case 'foo':
        return JSONEnumType.foo;
      case 'bar':
        return JSONEnumType.bar;
    }
    throw Exception('Unknown enum value: $this');
  }
}

final _exceptionFns = <String, _s.AwsExceptionFn>{};
