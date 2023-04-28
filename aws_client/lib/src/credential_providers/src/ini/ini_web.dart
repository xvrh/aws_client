import 'package:aws_client/src/shared/shared.dart';

Future<AwsClientCredentials?> fromIni({
  bool preferStaticCredentials = false,
  Client? client,
  String? preferredProfile,
}) async {
  throw Exception('"fromIni" is not supported on web');
}
