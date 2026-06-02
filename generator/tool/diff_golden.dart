// Regenerates client packages and diffs the generated Dart against the
// committed golden baseline (generated/<pkg>/lib/*.dart). A faithful change
// yields an empty .dart diff. Run from generator/; see --help for flags.
// Exit: 0 = no .dart diff, 1 = diff found, 2 = setup error.

import 'dart:convert';
import 'dart:io';

/// One or two canary services per AWS wire protocol.
const cohort = <String>[
  'aws_dynamodb_api', // json
  'aws_kinesis_api', // json
  'aws_lambda_api', // rest-json
  'aws_s3_api', // rest-xml
  'aws_route53_api', // rest-xml
  'aws_sqs_api', // query
  'aws_sts_api', // query
  'aws_ec2_api', // ec2
];

late final Directory generatorDir;
late final Directory repoRoot;

void main(List<String> args) {
  generatorDir = File(Platform.script.toFilePath()).parent.parent;
  repoRoot = generatorDir.parent;

  var mode = 'cohort';
  String? protocol;
  var restore = false;
  final packages = <String>[];

  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    switch (arg) {
      case '--cohort':
        mode = 'cohort';
      case '--all':
        mode = 'all';
      case '--protocol':
        mode = 'protocol';
        protocol = args[++i];
      case '--restore':
        restore = true;
      case '-h':
      case '--help':
        _printHelp();
        return;
      default:
        if (arg.startsWith('-')) _fail('Unknown flag: $arg');
        mode = 'explicit';
        packages.add(arg);
    }
  }

  // A pre-existing diff in generated/ would be mistaken for this run's output.
  if (_git(['diff', '--quiet', '--', 'generated/']).exitCode != 0) {
    stderr.writeln('ERROR: generated/ has uncommitted changes.');
    stderr.writeln("Commit, stash, or 'git checkout -- generated/' first.");
    exit(2);
  }

  final genArgs = [
    'run',
    'bin/generate.dart',
    'generate',
    '--no-pub',
    '--no-bump',
    '--no-test-suite',
  ];
  switch (mode) {
    case 'cohort':
      for (final p in cohort) {
        genArgs.addAll(['-p', p]);
      }
    case 'explicit':
      for (final p in packages) {
        genArgs.addAll(['-p', p]);
      }
    case 'protocol':
      genArgs.addAll(['--protocol', protocol!]);
    case 'all':
      break;
  }

  final label = mode == 'protocol'
      ? '$mode $protocol'
      : mode == 'explicit'
          ? '$mode ${packages.join(' ')}'
          : mode;
  stdout.writeln('>> Regenerating ($label)');

  final gen = Process.runSync(
    'dart',
    genArgs,
    workingDirectory: generatorDir.path,
  );
  if (gen.exitCode != 0) {
    stderr.writeln('ERROR: generation failed:');
    stderr.writeln(gen.stdout);
    stderr.writeln(gen.stderr);
    exit(2);
  }

  _report(restore: restore);
}

void _report({required bool restore}) {
  final reportFile = File('${Directory.systemTemp.path}/diff_golden.report.txt')
    ..writeAsStringSync(
        _git(['diff', '--', 'generated/']).stdout as String);

  final numstat = _git(['diff', '--numstat', '--', 'generated/']).stdout as String;
  final dartRe = RegExp(r'/lib/.*\.dart$');

  final dartChanges = <_Change>[];
  final otherFiles = <String>[];
  for (final line in const LineSplitter().convert(numstat)) {
    if (line.trim().isEmpty) continue;
    final parts = line.split('\t');
    if (parts.length < 3) continue;
    final file = parts[2];
    if (dartRe.hasMatch(file)) {
      dartChanges.add(_Change(
        added: int.tryParse(parts[0]) ?? 0,
        deleted: int.tryParse(parts[1]) ?? 0,
        file: file,
      ));
    } else {
      otherFiles.add(file);
    }
  }

  stdout.writeln();
  stdout.writeln('================= .dart diff vs golden =================');
  if (dartChanges.isEmpty) {
    stdout.writeln('  none — generated Dart matches the golden baseline.');
  } else {
    stdout.writeln('  +added   -del     package / file');
    var totalAdd = 0, totalDel = 0;
    for (final c in dartChanges) {
      final pkg = c.file.replaceFirst(RegExp(r'generated/([^/]+)/.*'), r'$1');
      stdout.writeln('  ${_pad(c.added)} ${_pad(c.deleted)} $pkg (${c.file})');
      totalAdd += c.added;
      totalDel += c.deleted;
    }
    stdout.writeln('  ------------------------------------------------------');
    stdout.writeln('  ${_pad(totalAdd)} ${_pad(totalDel)} ${dartChanges.length} files');
  }
  stdout.writeln('========================================================');
  stdout.writeln('Full diff (incl. non-.dart churn): ${reportFile.path}');

  if (otherFiles.isNotEmpty) {
    stdout.writeln();
    stdout.writeln('Other touched files (not measured):');
    for (final f in otherFiles) {
      stdout.writeln('  $f');
    }
  }

  if (restore) {
    stdout.writeln();
    stdout.writeln('>> Restoring generated/ to HEAD (--restore)');
    _git(['checkout', '--', 'generated/']);
  }

  exit(dartChanges.isEmpty ? 0 : 1);
}

ProcessResult _git(List<String> args) =>
    Process.runSync('git', args, workingDirectory: repoRoot.path);

String _pad(int n) => n.toString().padRight(8);

Never _fail(String message) {
  stderr.writeln(message);
  exit(2);
}

void _printHelp() {
  final src = File(Platform.script.toFilePath()).readAsLinesSync();
  for (final line in src) {
    if (line.startsWith('//')) {
      stdout.writeln(line.replaceFirst(RegExp(r'^// ?'), ''));
    } else if (line.trim().isEmpty) {
      continue;
    } else {
      break;
    }
  }
}

class _Change {
  final int added;
  final int deleted;
  final String file;
  _Change({required this.added, required this.deleted, required this.file});
}
