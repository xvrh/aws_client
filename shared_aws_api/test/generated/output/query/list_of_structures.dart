// ignore_for_file: deprecated_member_use_from_same_package
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
        rfc822ToJson,
        iso8601ToJson,
        unixTimestampToJson,
        nonNullableTimeStampFromJson,
        timeStampFromJson;

import 'list_of_structures.meta.dart';
export 'package:shared_aws_api/shared.dart' show AwsClientCredentials;

/// List of structures
class ListOfStructures {
  final _s.QueryProtocol _protocol;
  final Map<String, _s.Shape> shapes;

  ListOfStructures({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.AwsClientCredentialsProvider? credentialsProvider,
    _s.Client? client,
    String? endpointUrl,
  })  : _protocol = _s.QueryProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'ListOfStructures',
          ),
          region: region,
          credentials: credentials,
          credentialsProvider: credentialsProvider,
          endpointUrl: endpointUrl,
        ),
        shapes = shapesJson
            .map((key, value) => MapEntry(key, _s.Shape.fromJson(value)));

  /// Closes the internal HTTP client if none was provided at creation.
  /// If a client was passed as a constructor argument, this becomes a noop.
  ///
  /// It's important to close all clients when it's done being used; failing to
  /// do so can cause the Dart process to hang.
  void close() {
    _protocol.close();
  }

  Future<OutputShape> operationName0() async {
    final $request = <String, String>{};
    final $result = await _protocol.send(
      $request,
      action: 'OperationName',
      version: '2020-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      resultWrapper: 'OperationNameResult',
    );
    return OutputShape.fromXml($result);
  }
}

class OutputShape {
  final List<StructureShape>? list;

  OutputShape({
    this.list,
  });
  factory OutputShape.fromXml(_s.XmlElement elem) {
    return OutputShape(
      list: _s.extractXmlChild(elem, 'List')?.let((elem) =>
          elem.findElements('member').map(StructureShape.fromXml).toList()),
    );
  }

  Map<String, String> toQueryMap() {
    final list = this.list;
    return {
      if (list != null)
        if (list.isEmpty)
          'List': ''
        else
          for (var i1 = 0; i1 < list.length; i1++)
            for (var e3 in list[i1].toQueryMap().entries)
              'List.member.${i1 + 1}.${e3.key}': e3.value,
    };
  }
}

class StructureShape {
  final String? bar;
  final String? baz;
  final String? foo;

  StructureShape({
    this.bar,
    this.baz,
    this.foo,
  });
  factory StructureShape.fromXml(_s.XmlElement elem) {
    return StructureShape(
      bar: _s.extractXmlStringValue(elem, 'Bar'),
      baz: _s.extractXmlStringValue(elem, 'Baz'),
      foo: _s.extractXmlStringValue(elem, 'Foo'),
    );
  }

  Map<String, String> toQueryMap() {
    final bar = this.bar;
    final baz = this.baz;
    final foo = this.foo;
    return {
      if (bar != null) 'Bar': bar,
      if (baz != null) 'Baz': baz,
      if (foo != null) 'Foo': foo,
    };
  }
}

final _exceptionFns = <String, _s.AwsExceptionFn>{};
