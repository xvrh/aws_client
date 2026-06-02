// Generates a package's service Dart from the Smithy-sourced Api (adapter +
// Api.fromJson + buildService) and diffs it against the committed golden.
// Run from generator/. Defaults to the awsJson cohort.
// Exit: 0 = identical to golden, 1 = differs, 2 = setup error.

import 'dart:convert';
import 'dart:io';

import 'package:aws_client_generator/builders/library_builder.dart';
import 'package:aws_client_generator/smithy/ast.dart';
import 'package:aws_client_generator/smithy/from_smithy.dart';
import 'package:dart_style/dart_style.dart';

const cohort = ['dynamodb-2012-08-10', 'kinesis-2013-12-02'];

void main(List<String> args) {
  final uids = args.isEmpty ? cohort : args;
  final formatter = DartFormatter(fixes: StyleFix.all);
  var anyDiff = false;

  for (final uid in uids) {
    final modelFile = File('smithy_apis/$uid.json');
    if (!modelFile.existsSync()) {
      stderr.writeln('Missing smithy_apis/$uid.json (run smithy_download).');
      exit(2);
    }

    final model = SmithyModel.fromJson(
        jsonDecode(modelFile.readAsStringSync()) as Map<String, dynamic>);
    final api = apiFromSmithy(model, uid: uid);

    final golden =
        File('../generated/${api.packageName}/lib/${api.fileBasename}.dart');
    if (!golden.existsSync()) {
      stderr.writeln('No golden for ${api.packageName}/${api.fileBasename}');
      exit(2);
    }

    final generated = formatter.format(buildService(api));
    final tmp = File('${Directory.systemTemp.path}/$uid.smithy.dart')
      ..writeAsStringSync(generated);

    final diff = Process.runSync(
        'git', ['diff', '--no-index', '--stat', golden.path, tmp.path]);
    final stat = (diff.stdout as String).trim();

    stdout.writeln('=== ${api.packageName} (${api.metadata.protocol}) ===');
    if (stat.isEmpty) {
      stdout.writeln('  identical to golden.');
    } else {
      anyDiff = true;
      stdout.writeln('  $stat');
      stdout.writeln('  full diff: git diff --no-index ${golden.path} ${tmp.path}');
    }
  }

  exit(anyDiff ? 1 : 0);
}
