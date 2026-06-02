// Reports how Smithy-sourced file names differ from the published (legacy) ones,
// so the renames can be eyeballed before cutover. Run from generator/.
// The Smithy name is the api-models-aws basename (sdkId-derived); the legacy
// name is the committed file in generated/<package>/lib/.

import 'dart:convert';
import 'dart:io';

import 'package:aws_client_generator/model/api.dart';
import 'package:aws_client_generator/smithy/ast.dart';
import 'package:aws_client_generator/smithy/from_smithy.dart';

void main() {
  final renamed = <List<String>>[]; // [package, legacy, new]
  final newer = <List<String>>[]; // new version of an existing package
  var unchanged = 0;
  var newService = 0;

  final files = Directory('smithy_apis')
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.json'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  for (final f in files) {
    final uid = f.uri.pathSegments.last.replaceFirst('.json', '');
    final Api api;
    try {
      api = apiFromSmithy(
          SmithyModel.fromJson(
              jsonDecode(f.readAsStringSync()) as Map<String, dynamic>),
          uid: uid);
    } on UnsupportedError {
      continue; // unsupported protocol (ec2)
    }
    if (!api.isRecognized) {
      newService++;
      continue;
    }

    final libDir = Directory('../generated/${api.packageName}/lib');
    if (!libDir.existsSync()) {
      newService++;
      continue;
    }
    final legacy = libDir
        .listSync()
        .whereType<File>()
        .map((e) => e.uri.pathSegments.last)
        .where((n) => n.endsWith('.dart') && !n.endsWith('.meta.dart'))
        .map((n) => n.substring(0, n.length - '.dart'.length))
        .toList();

    if (legacy.contains(uid)) {
      unchanged++;
    } else if (legacy.any((l) => l.endsWith('-${api.metadata.apiVersion}'))) {
      // same version exists under a different name -> a rename
      final l = legacy.firstWhere((l) => l.endsWith('-${api.metadata.apiVersion}'));
      renamed.add([api.packageName, l, uid]);
    } else {
      // no legacy file at this version -> newer API version
      newer.add([api.packageName, legacy.join(','), uid]);
    }
  }

  renamed.sort((a, b) => a[1].compareTo(b[1]));
  stdout.writeln('RENAMES (${renamed.length}):  legacy  ->  smithy');
  for (final r in renamed) {
    stdout.writeln('  ${r[1].padRight(40)} -> ${r[2]}   [${r[0]}]');
  }
  if (newer.isNotEmpty) {
    stdout.writeln('\nNEWER API VERSION (${newer.length}):');
    for (final r in newer) {
      stdout.writeln('  ${r[1].padRight(40)} -> ${r[2]}   [${r[0]}]');
    }
  }
  stdout.writeln('\nunchanged: $unchanged, renamed: ${renamed.length}, '
      'newer-version: ${newer.length}, new-service: $newService');
}
