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
  final localDatabaseAlternatives = rawLocalDatabaseAlternative.values!.map(
    LocalDatabaseAlternative.fromVarIdentifier,
  );

  await testSuccessfulGeneration(
    cases: {
      for (final localDatabaseAlternative in localDatabaseAlternatives)
        (localDatabaseAlternative: localDatabaseAlternative),
    },
  );

  await testGenerationWithoutCommonPackage(
    cases: {
      for (final localDatabaseAlternative in localDatabaseAlternatives)
        (localDatabaseAlternative: localDatabaseAlternative),
    },
  );

  await testGenerationWithoutHooks(
    cases: {
      for (final localDatabaseAlternative in localDatabaseAlternatives)
        (localDatabaseAlternative: localDatabaseAlternative),
    },
  );
}

typedef GenerationCase = ({LocalDatabaseAlternative localDatabaseAlternative});

@isTest
Future<void> testSuccessfulGeneration({
  required Set<GenerationCase> cases,
}) async {
  for (final generationCase in cases) {
    final (:localDatabaseAlternative) = generationCase;

    test(
      '''

GIVEN the Altoke Local Database brick
AND hooks enabled
AND an existing "common" package
WHEN the generation is run
THEN the generated outputs should be valid and testable
=> with `${localDatabaseAlternative.varIdentifier}`
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
        await BrickGenerator.common.runGeneration(
          target: directoryGeneratorTarget,
          vars: altokeCommonVars,
          runHooks: true,
        );
        final altokeLocalDatabaseVars = <String, dynamic>{
          LocalDatabaseAlternative.varKey:
              localDatabaseAlternative.varIdentifier,
        };
        await BrickGenerator.localDatabase.runGeneration(
          target: directoryGeneratorTarget,
          vars: altokeLocalDatabaseVars,
          runHooks: true,
        );
        final outputDir = directoryGeneratorTarget.outputDir;
        expect(outputDir.existsSync(), isTrue);
        final requirementsFile = directoryGeneratorTarget.requirementsFile;
        expect(requirementsFile.existsSync(), isFalse);
        final interfaceProjectDir =
            directoryGeneratorTarget.interfaceProjectDir;
        final implementationProjectDir = directoryGeneratorTarget
            .implementationProjectDir(localDatabaseAlternative);

        Future<void> runCommands({required Directory projectDir}) async {
          final coverageDir = projectDir.descendantDir('coverage');
          final baseLcovFile = coverageDir.descendantFile('lcov.info');
          final filteredLcovFile = coverageDir.descendantFile(
            'filtered.lcov.info',
          );
          await expectLater(
            Dart.format(projectDir, failIfChanged: true),
            completes,
          );
          await expectLater(
            Dart.analyze(projectDir, fatalInfos: true, fatalWarnings: true),
            completes,
          );
          await expectLater(
            Dart.test(projectDir, coverageDirectory: coverageDir),
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
              filters: [r'\.freezed\.dart', r'\.g\.dart', r'\.mapper\.dart'],
            ),
            completes,
          );
          await expectLater(
            Coverage.check(inputLcov: filteredLcovFile, threshold: 100),
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
Future<void> testGenerationWithoutCommonPackage({
  required Set<GenerationCase> cases,
}) async {
  for (final generationCase in cases) {
    final (:localDatabaseAlternative) = generationCase;
    test(
      '''

GIVEN the Altoke Local Database brick
AND hooks enabled
AND no existing "common" package
WHEN the generation is run
THEN the generated outputs should be valid and testable
=> with `${localDatabaseAlternative.varIdentifier}`
''',
      () async {
        registerFallbackValue(systemEncoding);
        final tempDir = Directory.systemTemp.createTempSync(
          '''altoke-local-database-e2e-test-${localDatabaseAlternative.varIdentifier}-''',
        );
        addTearDown(() => tempDir.deleteSync(recursive: true));
        final directoryGeneratorTarget = DirectoryGeneratorTarget(tempDir);
        final altokeLocalDatabaseVars = <String, dynamic>{
          LocalDatabaseAlternative.varKey:
              localDatabaseAlternative.varIdentifier,
        };
        await BrickGenerator.localDatabase.runGeneration(
          target: directoryGeneratorTarget,
          vars: altokeLocalDatabaseVars,
          runHooks: true,
        );
        final outputDir = directoryGeneratorTarget.outputDir;
        expect(outputDir.existsSync(), isFalse);
        final requirementsFile = directoryGeneratorTarget.requirementsFile;
        expect(requirementsFile.existsSync(), isTrue);
      },
    );
  }
}

@isTest
Future<void> testGenerationWithoutHooks({
  required Set<GenerationCase> cases,
}) async {
  for (final generationCase in cases) {
    final (:localDatabaseAlternative) = generationCase;
    test(
      '''

GIVEN the Altoke Local Database brick
AND hooks disabled
AND an existing "common" package
WHEN the generation is run
THEN the generated outputs should be valid and testable
=> with `${localDatabaseAlternative.varIdentifier}`
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
        await BrickGenerator.common.runGeneration(
          target: directoryGeneratorTarget,
          vars: altokeCommonVars,
          runHooks: true,
        );
        final altokeLocalDatabaseVars = <String, dynamic>{
          LocalDatabaseAlternative.varKey:
              localDatabaseAlternative.varIdentifier,
        };
        Future<void> action() async =>
            BrickGenerator.localDatabase.runGeneration(
              target: directoryGeneratorTarget,
              vars: altokeLocalDatabaseVars,
              runHooks: false,
            );
        expect(action(), throwsA(isNotNull));
        final outputDir = directoryGeneratorTarget.outputDir;
        expect(outputDir.existsSync(), isFalse);
        final requirementsFile = directoryGeneratorTarget.requirementsFile;
        expect(requirementsFile.existsSync(), isFalse);
      },
    );
  }
}

extension on DirectoryGeneratorTarget {
  Directory get outputDir => dir.descendantDir('local_database');
  File get requirementsFile => dir.descendantFile('REQUIREMENTS.md');

  Directory get interfaceProjectDir =>
      outputDir.descendantDir('local_database');
  Directory implementationProjectDir(LocalDatabaseAlternative alternative) =>
      outputDir.descendantDir('${alternative.varIdentifier}_local_database');
}
