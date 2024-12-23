@Tags(['e2e'])
library;

import 'dart:async';
import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:local_database_alternative/local_database_alternative.dart';
import 'package:mason/mason.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:monorepo_elements/monorepo_elements.dart';
import 'package:path/path.dart' as path;
import 'package:shell/coverage.dart';
import 'package:shell/dart.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final brickManifestFile = Files.brickManifest;
  final brickManifestContent = brickManifestFile.readAsStringSync();
  final brickManifest = checkedYamlDecode(
    brickManifestContent,
    (m) => BrickYaml.fromJson(m!),
  );
  final vars = brickManifest.vars;
  final rawLocalDatabaseAlternative = vars[LocalDatabaseAlternative.varKey]!;
  final localDatabaseAlternative = rawLocalDatabaseAlternative.values!
      .map(LocalDatabaseAlternative.fromVarIdentifier);
  await testGeneration(
    '''

GIVEN the Altoke Local Database brick
WHEN the generation is run
THEN the generated outputs should be valid and testable
''',
    generationCases: {
      for (final localDatabaseAlternative in localDatabaseAlternative)
        (localDatabaseAlternative: localDatabaseAlternative),
    },
  );
}

typedef GenerationCase = ({
  LocalDatabaseAlternative localDatabaseAlternative,
});

@isTest
Future<void> testGeneration(
  String description, {
  required Set<GenerationCase> generationCases,
}) async {
  for (final generationCase in generationCases) {
    final (:localDatabaseAlternative) = generationCase;
    final composedDescription = '''

${description.trim()}
=> with `${localDatabaseAlternative.varIdentifier}`
''';
    test(
      composedDescription,
      () async {
        registerFallbackValue(systemEncoding);
        final tempDir = Directory.systemTemp.createTempSync(
          '''altoke-local-database-e2e-test-${localDatabaseAlternative.varIdentifier}-''',
        );
        addTearDown(() => tempDir.deleteSync(recursive: true));
        final directoryGeneratorTarget = DirectoryGeneratorTarget(tempDir);
        final altokeCommonVars = <String, dynamic>{
          'value_equality_approach': 'Overrides',
        };
        await BrickGenerator.common.runFullGeneration(
          target: directoryGeneratorTarget,
          vars: altokeCommonVars,
        );
        final altokeLocalDatabaseVars = <String, dynamic>{
          LocalDatabaseAlternative.varKey:
              localDatabaseAlternative.varIdentifier,
        };
        await BrickGenerator.localDatabase.runFullGeneration(
          target: directoryGeneratorTarget,
          vars: altokeLocalDatabaseVars,
        );
        final umbrellaPath = path.join(
          directoryGeneratorTarget.dir.path,
          'local_database',
        );
        final interfaceProjectPath = path.join(
          umbrellaPath,
          'local_database',
        );
        final implementationProjectPath = path.join(
          umbrellaPath,
          '${localDatabaseAlternative.varIdentifier}_local_database',
        );

        Future<void> runCommands({
          required String workingDir,
        }) async {
          final outputDir = Directory(workingDir);
          final coverageDir = Directory(path.join(workingDir, 'coverage'));
          final baseLcovFile = File(path.join(coverageDir.path, 'lcov.info'));
          final filteredLcovFile =
              File(path.join(coverageDir.path, 'filtered.lcov.info'));
          await expectLater(
            Dart.format(
              outputDir,
              failIfChanged: true,
            ),
            completes,
          );
          await expectLater(
            Dart.analyze(
              outputDir,
              fatalInfos: true,
              fatalWarnings: true,
            ),
            completes,
          );
          await expectLater(
            Dart.test(
              outputDir,
              coverageDirectory: coverageDir,
            ),
            completes,
          );
          await expectLater(
            Coverage.formatAsLcov(
              input: coverageDir,
              output: baseLcovFile,
              reportOn: Directory(path.join(workingDir, 'lib')),
            ),
            completes,
          );
          await expectLater(
            Coverage.filter(
              inputLcov: baseLcovFile,
              outputLcov: filteredLcovFile,
              filters: [
                r'\.freezed\.dart',
                r'\.g\.dart',
                r'\.mapper\.dart',
              ],
            ),
            completes,
          );
          await expectLater(
            Coverage.check(
              inputLcov: filteredLcovFile,
              threshold: 100,
            ),
            completes,
          );
        }

        await runCommands(workingDir: interfaceProjectPath);
        await runCommands(workingDir: implementationProjectPath);
      },
      timeout: const Timeout(Duration(minutes: 5)),
    );
  }
}
