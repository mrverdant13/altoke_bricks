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
  final localDatabaseAlternatives = rawLocalDatabaseAlternative.values!
      .map(LocalDatabaseAlternative.fromVarIdentifier);

  await testGeneration(
    '''

GIVEN the Altoke Local Database brick
AND an existing "common" package
WHEN the generation is run
THEN the generated outputs should be valid and testable
''',
    generationCases: {
      for (final localDatabaseAlternative in localDatabaseAlternatives)
        (localDatabaseAlternative: localDatabaseAlternative),
    },
  );

  await testErroredGeneration(
    '''

GIVEN the Altoke Local Database brick
AND no existing "common" package
WHEN the generation is run
THEN the generated outputs should be valid and testable
''',
    generationCases: {
      for (final localDatabaseAlternative in localDatabaseAlternatives)
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

    test(
      '''
$description=> with `${localDatabaseAlternative.varIdentifier}`
''',
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
        final umbrellaDir =
            directoryGeneratorTarget.dir.descendantDir('local_database');
        final interfaceProjectDir = umbrellaDir.descendantDir('local_database');
        final implementationProjectDir = umbrellaDir.descendantDir(
          '${localDatabaseAlternative.varIdentifier}_local_database',
        );

        Future<void> runCommands({
          required Directory projectDir,
        }) async {
          final coverageDir = projectDir.descendantDir('coverage');
          final baseLcovFile = coverageDir.descendantFile('lcov.info');
          final filteredLcovFile =
              coverageDir.descendantFile('filtered.lcov.info');
          await expectLater(
            Dart.format(
              projectDir,
              failIfChanged: true,
            ),
            completes,
          );
          await expectLater(
            Dart.analyze(
              projectDir,
              fatalInfos: true,
              fatalWarnings: true,
            ),
            completes,
          );
          await expectLater(
            Dart.test(
              projectDir,
              coverageDirectory: coverageDir,
            ),
            completes,
          );
          await expectLater(
            Coverage.formatAsLcov(
              input: coverageDir,
              output: baseLcovFile,
              reportOn: projectDir.descendantDir('lib'),
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

        await runCommands(projectDir: interfaceProjectDir);
        await runCommands(projectDir: implementationProjectDir);
      },
      timeout: const Timeout(Duration(minutes: 5)),
    );
  }
}

@isTest
Future<void> testErroredGeneration(
  String description, {
  required Set<GenerationCase> generationCases,
}) async {
  for (final generationCase in generationCases) {
    final (:localDatabaseAlternative) = generationCase;
    test(
      '''

${description.trim()}
=> with `${localDatabaseAlternative.varIdentifier}`
''',
      () async {
        registerFallbackValue(systemEncoding);
        final tempDir = Directory.systemTemp.createTempSync(
          '''altoke-local-database-e2e-test-${localDatabaseAlternative.varIdentifier}-''',
        );
        addTearDown(() => tempDir.deleteSync(recursive: true));
        final directoryGeneratorTarget = DirectoryGeneratorTarget(tempDir);
        final outputDir =
            directoryGeneratorTarget.dir.descendantDir('local_database');
        final altokeLocalDatabaseVars = <String, dynamic>{
          LocalDatabaseAlternative.varKey:
              localDatabaseAlternative.varIdentifier,
        };
        await BrickGenerator.localDatabase.runFullGeneration(
          target: directoryGeneratorTarget,
          vars: altokeLocalDatabaseVars,
        );
        expect(outputDir.existsSync(), isFalse);
      },
    );
  }
}
