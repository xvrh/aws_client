import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:aws_client.generator/builders/endpoint_config_builder.dart';
import 'package:aws_client.generator/model/api.dart';
import 'package:aws_client.generator/model_thin/api.dart' as thin;
import 'package:dart_style/dart_style.dart';
import 'package:json_annotation/json_annotation.dart';

import 'builders/library_builder.dart';
import 'generate_command.dart';
import 'model/region_config.dart';

class GenerateSinglePackageCommand extends Command {
  final _formatter = DartFormatter(fixes: StyleFix.all);

  @override
  String get name => 'generate-single-package';

  @override
  String get description =>
      '''Generate a single package containing all the AWS APIs.''';

  GenerateSinglePackageCommand();

  @override
  Future<void> run() async {
    final stopwatch = Stopwatch()..start();

    await _generateClasses();
    await _generateConfigFiles();

    print('Generator finished in ${stopwatch.elapsed}');
  }

  Future _generateClasses() async {
    print('Generating Dart classes...');

    final dir = Directory('./apis');
    final files = dir.listSync().whereType<File>().toList();
    files.sort((a, b) => a.path.compareTo(b.path));
    final services = <String>{};

    files.forEach((ent) {
      final parts = ent.uri.pathSegments.last.split('.')
        ..removeLast()
        ..removeLast();
      services.add(parts.join('.'));
    });

    final generatedApis = <String, String>{};

    final libDir = '../aws_client/lib';
    final apisDir = '$libDir/apis';
    final generatedDir = '$libDir/src/generated';

    _clearDir(apisDir);
    _clearDir(generatedDir);

    for (var i = 0; i < services.length; i++) {
      final service = services.elementAt(i);
      final def = File('./apis/$service.normal.json');

      final defJson =
          jsonDecode(def.readAsStringSync()) as Map<String, dynamic>;

      try {
        final api = Api.fromJson(defJson);
        final thinApi = thin.Api.fromJson(defJson);

        final percentage = i * 100 ~/ services.length;

        printPercentageInPlace(
            percentage, 'Generating API ${api.metadata.serviceFullName}');

        // create directories
        final baseDir = '$generatedDir/${api.directoryName}';
        final serviceFile = File('$baseDir/${api.fileBasename}.dart');
        final entryFile =
            File('$apisDir/${api.directoryName}/${api.fileBasename}.dart');

        serviceFile.parent.createSync(recursive: true);
        entryFile.parent.createSync(recursive: true);

        var metaContents = '''
// ignore_for_file: prefer_single_quotes
const Map<String, Map<String, dynamic>> shapesJson = ${jsonEncode(thinApi.toJson()['shapes'])};''';

        var entryContent = '''
export '../../src/generated/${api.directoryName}/${api.fileBasename}.dart';
''';

        var serviceText = buildService(api, sharedLibraryPath: '../../shared');
        serviceText = _formatter.format(serviceText, uri: serviceFile.uri);
        metaContents = _formatter.format(metaContents);
        entryContent = _formatter.format(entryContent);

        if (api.usesQueryProtocol) {
          File('$baseDir/${api.fileBasename}.meta.dart')
              .writeAsStringSync(metaContents);
        }

        serviceFile.writeAsStringSync(serviceText);
        entryFile.writeAsStringSync(entryContent);

        generatedApis[api.directoryName] = api.metadata.serviceFullName;
      } on UnrecognizedKeysException catch (e) {
        print('Error deserializing $service');
        print(e.message);
        rethrow;
      } catch (e) {
        print('Error "${e.runtimeType}" deserializing $service');
        rethrow;
      }
    }

    printPercentageInPlace(100, 'Done');
    print('\n');

    print('\nGenerated APIs:');

    (generatedApis.entries.toList()..sort((a, b) => a.value.compareTo(b.value)))
        .forEach((e) => print('- ${e.value}'));
  }

  void _clearDir(String path) {
    final directory = Directory(path);
    if (directory.existsSync()) {
      directory.deleteSync(recursive: true);
    }
  }

  final _configDataFile = File('./apis/config/region_config_data.json');
  Future<void> _generateConfigFiles() async {
    final jsonContent = jsonDecode(await _configDataFile.readAsString())
        as Map<String, dynamic>;
    final configData = RegionConfigData.fromJson(jsonContent);
    final endpointConfigCode =
        _formatter.format(buildEndpointConfig(configData));

    File('../aws_client/lib/src/shared/protocol/endpoint_config_data.dart')
      ..createSync(recursive: true)
      ..writeAsStringSync(endpointConfigCode);

    print('Generated endpoint_config_data file');
  }
}
