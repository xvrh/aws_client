// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name
// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:typed_data';

import 'package:aws_client/src/shared/shared.dart' as _s;
import 'package:aws_client/src/shared/shared.dart'
    show
        rfc822ToJson,
        iso8601ToJson,
        unixTimestampToJson,
        nonNullableTimeStampFromJson,
        timeStampFromJson;

export 'package:aws_client/src/shared/shared.dart' show AwsClientCredentials;

/// Flattened lists
class FlattenedLists {
  final _s.RestXmlProtocol _protocol;
  FlattenedLists({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.RestXmlProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'FlattenedLists',
          ),
          region: region,
          credentials: credentials,
          endpointUrl: endpointUrl,
        );

  Future<void> operationName0({
    List<String>? listParam,
  }) async {
    await _protocol.send(
      method: 'POST',
      requestUri: '/2014-01-01/hostedzone',
      payload: InputShape(listParam: listParam).toXml(
        'OperationRequest',
        attributes: [
          _s.XmlAttribute(_s.XmlName('xmlns'), 'https://foo/'),
        ],
      ),
      exceptionFnMap: _exceptionFns,
    );
  }
}

class InputShape {
  final List<String>? listParam;

  InputShape({
    this.listParam,
  });

  factory InputShape.fromJson(Map<String, dynamic> json) {
    return InputShape(
      listParam: (json['ListParam'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final listParam = this.listParam;
    return {
      if (listParam != null) 'ListParam': listParam,
    };
  }

  _s.XmlElement toXml(String elemName, {List<_s.XmlAttribute>? attributes}) {
    final listParam = this.listParam;
    final $children = <_s.XmlNode>[
      if (listParam != null)
        ...listParam.map((e) => _s.encodeXmlStringValue('ListParam', e)),
    ];
    final $attributes = <_s.XmlAttribute>[
      ...?attributes,
    ];
    return _s.XmlElement(
      _s.XmlName(elemName),
      $attributes,
      $children,
    );
  }
}

final _exceptionFns = <String, _s.AwsExceptionFn>{};
