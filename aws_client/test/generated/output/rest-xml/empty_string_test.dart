// ignore_for_file: prefer_single_quotes, unused_import

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:aws_client/src/shared/shared.dart' as _s;
import 'package:test/test.dart';
import '../../../utils.dart';
import 'empty_string.dart';

void main() {
  _s.idempotencyGeneratorOverride =
      () => '00000000-0000-4000-8000-000000000000';
  test('Empty string 0', () async {
    final client = MockClient((request) async {
      return Response(
          r'''<OperationNameResponse><Foo/><RequestId>requestid</RequestId></OperationNameResponse>''',
          200,
          headers: {});
    });

    final service = EmptyString(
      client: client,
      region: 'us-east-1',
      credentials: AwsClientCredentials(
        accessKey: '',
        secretKey: '',
      ),
    );

    final output = await service.operationName0();
    expect(output.foo, "");
/*
{
  "Foo": ""
}
*/
  });
}
