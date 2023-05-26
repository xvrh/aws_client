# High-level APIs for Amazon Web Services (AWS) in Dart

## Usage

A simple usage example:

##### S3
```dart
import 'dart:io';
import 'package:aws_client/s3_2006_03_01.dart';

void main() async {
  final api = S3(region: 'eu-west-1');
  await api.createBucket(bucket: 'my_bucket');
  await api.putObject(
      bucket: 'my_bucket',
      key: 'my_file.png',
      body: File('my_file.png').readAsBytesSync());
  api.close();
}
```

##### DynamoDB
```dart
import 'dart:convert';
import 'package:aws_client/dynamo_document.dart';

void main() async {
  final db = DocumentClient(region: 'eu-west-1');

  final getResponse = await db.get(
    tableName: 'MyTable',
    key: {'Car': 'DudeWheresMyCar'},
  );

  print(jsonEncode(getResponse.item));
}
```

##### SQS
```dart
import 'package:aws_client/sqs_2012_11_05.dart';

void main() async {
  final sqs = Sqs(region: 'us-east-1');
  final queue = await sqs.createQueue(queueName: 'queue');
  await sqs.sendMessage(
          messageBody: 'Hello from Dart client!', queueUrl: queue.queueUrl!);
  sqs.close();
}
```

##### Lambda
```dart
import 'package:aws_client/lambda_2015_03_31.dart';

void main(List<String> args) async {
  final lambda = Lambda(region: 'us-west-1');
  final response = await lambda.invoke(
    functionName: 'my-function',
    invocationType: InvocationType.requestResponse,
  );

  print('StatusCode: ${response.statusCode}');
  lambda.close();
}
```

## How to contribute

This library is not an official library from Amazon or Google.
It is developed by best effort, in the motto of _"Scratch your own itch!"_,
meaning we have APIs here that we care about. Looking for contributions:

- tests:

  - never put AWS credentials inside the code
  - read AWS credentials from environment variables in the beginning
  - provide description what setup it needs upfront

- API documentation

- New API contribution:

  - please open an issue ticket first about what you are planning to implement
  - take a look at the implementation of the others, most of the API calls will be similar
  - always include a link to AWS API docs

## Links

- [source code][source]
- contributors: [Agilord][agilord]

[source]: https://github.com/agilord/aws_client
[agilord]: https://www.agilord.com/

## Available AWS APIs

The following is a list of APIs that are currently available inside this package.

<!-- INSERT API LIST -->