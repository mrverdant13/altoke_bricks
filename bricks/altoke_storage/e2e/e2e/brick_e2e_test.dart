@Tags(['e2e'])
library brick_e2e_test;

import 'dart:async';
import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:data_persistence_approach/data_persistence_approach.dart';
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
  final rawDataPersistenceApproach = vars[DataPersistenceApproach.varKey]!;
  final dataPersistenceApproaches = rawDataPersistenceApproach.values!
      .map(DataPersistenceApproach.fromVarIdentifier);
  // FIXME: Test Realm approach once it is testable.
  // Ref: https://github.com/realm/realm-dart/issues/1619
  final testableApproaches = dataPersistenceApproaches.where(
    (approach) => approach != DataPersistenceApproach.realm,
  );
  await testGeneration(
    '''

GIVEN the Altoke Storage brick
WHEN the generation is run
THEN the generated outputs should be valid and testable
''',
    generationCases: {
      for (final dataPersistenceApproach in testableApproaches)
        (dataPersistenceApproach: dataPersistenceApproach),
    },
  );
}

typedef GenerationCase = ({
  DataPersistenceApproach dataPersistenceApproach,
});

@isTest
Future<void> testGeneration(
  String description, {
  required Set<GenerationCase> generationCases,
}) async {
  for (final generationCase in generationCases) {
    final (:dataPersistenceApproach) = generationCase;
    final composedDescription = '''

${description.trim()}
=> with `${dataPersistenceApproach.varIdentifier}`
''';
    test(
      composedDescription,
      () async {
        registerFallbackValue(systemEncoding);
        final tempDir = Directory.systemTemp.createTempSync(
          'altoke-storage-e2e-test-${dataPersistenceApproach.varIdentifier}-',
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
        final altokeEntityVars = <String, dynamic>{
          'entity_singular': 'altoke entity',
          'package_description': 'Altoke entity.',
          'value_equality_approach': 'Overrides',
        };
        await BrickGenerator.entity.runFullGeneration(
          target: directoryGeneratorTarget,
          vars: altokeEntityVars,
        );
        final altokeStorageVars = <String, dynamic>{
          'object': 'altoke entity',
          'objects': 'altoke entities',
          DataPersistenceApproach.varKey: dataPersistenceApproach.varIdentifier,
        };
        await BrickGenerator.storage.runFullGeneration(
          target: directoryGeneratorTarget,
          vars: altokeStorageVars,
        );
        final umbrellaPath = path.join(
          directoryGeneratorTarget.dir.path,
          'altoke_entities_storage',
        );
        final interfaceProjectPath = path.join(
          umbrellaPath,
          'altoke_entities_storage',
        );
        final implementationProjectPath = path.join(
          umbrellaPath,
          'altoke_entities_${dataPersistenceApproach.varIdentifier}_storage',
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
