// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name

import 'dart:convert';
import 'dart:typed_data';

import 'package:aws_client/src/shared/shared.dart' as _s;
import 'package:aws_client/src/shared/shared.dart'
    show Uint8ListConverter, Uint8ListListConverter;

export 'package:aws_client/src/shared/shared.dart' show AwsClientCredentials;

/// Querystring list of strings
class QuerystringListOfStrings {
  final _s.RestXmlProtocol _protocol;
  QuerystringListOfStrings({
    @_s.required String region,
    _s.AwsClientCredentials credentials,
    _s.Client client,
    String endpointUrl,
  }) : _protocol = _s.RestXmlProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'QuerystringListOfStrings',
          ),
          region: region,
          credentials: credentials,
          endpointUrl: endpointUrl,
        );

  Future<void> operationName0({
    List<String> items,
  }) async {
    final $query = <String, List<String>>{
      if (items != null) 'item': items,
    };
    await _protocol.send(
      method: 'GET',
      requestUri: '/path',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
  }
}

final _exceptionFns = <String, _s.AwsExceptionFn>{};
