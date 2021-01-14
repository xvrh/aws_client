import 'package:aws_client/apis/s3/2006-03-01.dart';

void main() async {
  final s3 = S3(region: '');
  await s3.getObject(bucket: null, key: null);
}
