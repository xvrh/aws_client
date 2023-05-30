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

import 'timestamp_members.meta.dart';
export 'package:shared_aws_api/shared.dart' show AwsClientCredentials;

/// Timestamp members
class TimestampMembers {
  final _s.QueryProtocol _protocol;
  final Map<String, _s.Shape> shapes;

  TimestampMembers({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.AwsClientCredentialsProvider? credentialsProvider,
    _s.Client? client,
    String? endpointUrl,
  })  : _protocol = _s.QueryProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'TimestampMembers',
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
    );
    return OutputShape.fromXml($result);
  }
}

class OutputShape {
  final TimeContainer? structMember;
  final DateTime? timeArg;
  final DateTime? timeCustom;
  final DateTime? timeFormat;

  OutputShape({
    this.structMember,
    this.timeArg,
    this.timeCustom,
    this.timeFormat,
  });
  factory OutputShape.fromXml(_s.XmlElement elem) {
    return OutputShape(
      structMember:
          _s.extractXmlChild(elem, 'StructMember')?.let(TimeContainer.fromXml),
      timeArg: _s.extractXmlDateTimeValue(elem, 'TimeArg'),
      timeCustom: _s.extractXmlDateTimeValue(elem, 'TimeCustom',
          parser: _s.timeStampFromJson),
      timeFormat: _s.extractXmlDateTimeValue(elem, 'TimeFormat',
          parser: _s.timeStampFromJson),
    );
  }

  Map<String, String> toQueryMap() {
    final structMember = this.structMember;
    final timeArg = this.timeArg;
    final timeCustom = this.timeCustom;
    final timeFormat = this.timeFormat;
    return {
      if (structMember != null)
        for (var e1 in structMember.toQueryMap().entries)
          'StructMember.${e1.key}': e1.value,
      if (timeArg != null) 'TimeArg': _s.iso8601ToJson(timeArg),
      if (timeCustom != null) 'TimeCustom': _s.rfc822ToJson(timeCustom),
      if (timeFormat != null)
        'TimeFormat': _s.unixTimestampToJson(timeFormat).toString(),
    };
  }
}

class TimeContainer {
  final DateTime? bar;
  final DateTime? foo;

  TimeContainer({
    this.bar,
    this.foo,
  });
  factory TimeContainer.fromXml(_s.XmlElement elem) {
    return TimeContainer(
      bar:
          _s.extractXmlDateTimeValue(elem, 'bar', parser: _s.timeStampFromJson),
      foo: _s.extractXmlDateTimeValue(elem, 'foo'),
    );
  }

  Map<String, String> toQueryMap() {
    final bar = this.bar;
    final foo = this.foo;
    return {
      if (bar != null) 'bar': _s.unixTimestampToJson(bar).toString(),
      if (foo != null) 'foo': _s.iso8601ToJson(foo),
    };
  }
}

final _exceptionFns = <String, _s.AwsExceptionFn>{};
