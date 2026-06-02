// Generates Smithy-sourced clients into generated_smithy_preview/ so the output
// can be reviewed and diffed against generated/ directly in git. Run from
// generator/. Defaults to a representative awsJson set.

import 'dart:convert';
import 'dart:io';

import 'package:aws_client_generator/builders/library_builder.dart';
import 'package:aws_client_generator/smithy/ast.dart';
import 'package:aws_client_generator/smithy/from_smithy.dart';
import 'package:dart_style/dart_style.dart';

const defaults = [
  'cognito-identity-2014-06-30',
  'dynamodb-2012-08-10',
  'kinesis-2013-12-02',
  'kms-2014-11-01',
  'sqs-2012-11-05',
  'lambda-2015-03-31', // rest-json
  's3-2006-03-01', // rest-xml
  'route-53-2013-04-01', // rest-xml
  'sts-2011-06-15', // query
];

void main(List<String> args) {
  final uids = args.isEmpty ? defaults : args;
  final formatter = DartFormatter(fixes: StyleFix.all);

  for (final uid in uids) {
    final model = SmithyModel.fromJson(
        jsonDecode(File('smithy_apis/$uid.json').readAsStringSync())
            as Map<String, dynamic>);
    final api = apiFromSmithy(model, uid: uid);
    final out = File('../generated_smithy_preview/${api.packageName}/'
        '${api.fileBasename}.dart')
      ..createSync(recursive: true)
      ..writeAsStringSync(formatter.format(buildService(api)));
    stdout.writeln('wrote ${out.path}');
  }
}
