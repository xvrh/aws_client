// Parses every model under smithy_apis/ through the AST and reports failures
// plus the protocol detected per service. Run from generator/.
// Exit: 0 = all parsed, 1 = failures, 2 = no inputs.

import 'dart:convert';
import 'dart:io';

import 'package:aws_client_generator/smithy/ast.dart';
import 'package:aws_client_generator/smithy/traits.dart';

void main() {
  final dir = Directory('smithy_apis');
  if (!dir.existsSync()) {
    stderr.writeln('No smithy_apis/ directory. Download models first.');
    exit(2);
  }

  final files = dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.json'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  if (files.isEmpty) {
    stderr.writeln('No *.json models under smithy_apis/.');
    exit(2);
  }

  var ok = 0;
  final failures = <String, Object>{};
  final protocols = <String, int>{};

  for (final file in files) {
    final name = file.uri.pathSegments.last;
    try {
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final model = SmithyModel.fromJson(json);
      final service = model.service.value;
      final protocol = service.protocolTraitId ?? '(none)';
      protocols.update(protocol, (n) => n + 1, ifAbsent: () => 1);
      stdout.writeln(
          '  ok  $name  ${model.shapes.length} shapes  $protocol');
      ok++;
    } catch (e) {
      failures[name] = e;
      stdout.writeln('  FAIL  $name  $e');
    }
  }

  stdout.writeln();
  stdout.writeln('Parsed $ok/${files.length} models.');
  stdout.writeln('Protocols seen:');
  for (final e in (protocols.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value)))) {
    stdout.writeln('  ${e.value.toString().padLeft(4)}  ${e.key}');
  }

  if (failures.isNotEmpty) {
    stdout.writeln();
    stdout.writeln('${failures.length} FAILURES:');
    failures.forEach((name, err) => stdout.writeln('  $name: $err'));
    exit(1);
  }
}
