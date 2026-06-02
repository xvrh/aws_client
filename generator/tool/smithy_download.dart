// Downloads Smithy AST models from aws/api-models-aws into smithy_apis/
// (gitignored), pinned to [pinnedRef]. The repo regenerates daily, so the pin
// keeps the diff harness from confusing model drift with adapter changes.
// Run from generator/.

import 'dart:io';

import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

/// Pinned commit of aws/api-models-aws.
const pinnedRef = '533905230ad04239ac03ab0a4c4f418ef5446530';

Future<void> main() async {
  final outDir = Directory('smithy_apis')..createSync(recursive: true);

  stdout.writeln('Downloading api-models-aws @ $pinnedRef ...');
  final res = await http.get(Uri.https(
      'api.github.com', '/repos/aws/api-models-aws/zipball/$pinnedRef'));
  if (res.statusCode != 200) {
    stderr.writeln('Download failed: HTTP ${res.statusCode}');
    exit(1);
  }

  final archive = ZipDecoder().decodeBytes(res.bodyBytes);
  var count = 0;
  for (final entry in archive) {
    if (!entry.isFile) continue;
    // Strip the top-level "<owner>-<repo>-<sha>/" segment.
    final path = entry.name.split('/').skip(1).join('/');
    if (!path.startsWith('models/') ||
        !path.contains('/service/') ||
        !path.endsWith('.json')) {
      continue;
    }
    File(p.join(outDir.path, p.basename(path)))
        .writeAsBytesSync(entry.content as List<int>);
    count++;
  }

  stdout.writeln('Wrote $count model files to ${outDir.path}/');
}
