@Tags(['e2e'])
library;

import 'dart:async';
import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:mason/mason.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:monorepo_elements/monorepo_elements.dart';
import 'package:path/path.dart' as path;
import 'package:shell/coverage.dart';
import 'package:shell/dart.dart';
import 'package:test/test.dart';
import 'package:value_equality_approach/value_equality_approach.dart';

Future<void> main() async {
  final brickManifestFile = Files.brickManifest;
  final brickManifestContent = brickManifestFile.readAsStringSync();
  final brickManifest = checkedYamlDecode(
    brickManifestContent,
    (m) => BrickYaml.fromJson(m!),
  );
  final vars = brickManifest.vars;
  final rawValueEqualityApproaches = vars[ValueEqualityApproach.varKey]!;
  final valueEqualityApproaches = rawValueEqualityApproaches.values!
      .map(ValueEqualityApproach.fromReadableName);

  await testGeneration(
    '''

GIVEN the Altoke Entity brick
AND an existing "common" package
WHEN the generation is run
THEN the generated outputs should be valid and testable
''',
    generationCases: {
      for (final valueEqualityApproach in valueEqualityApproaches)
        (valueEqualityApproach: valueEqualityApproach),
    },
  );

  await testErroredGeneration(
    '''

GIVEN the Altoke Entity brick
AND no existing "common" package
WHEN the generation is run
THEN the generated outputs should be valid and testable
''',
    generationCases: {
      for (final valueEqualityApproach in valueEqualityApproaches)
        (valueEqualityApproach: valueEqualityApproach),
    },
  );
}

typedef GenerationCase = ({
  ValueEqualityApproach valueEqualityApproach,
});

@isTest
Future<void> testGeneration(
  String description, {
  required Set<GenerationCase> generationCases,
}) async {
  for (final generationCase in generationCases) {
    final (:valueEqualityApproach) = generationCase;
    final composedDescription = '''

${description.trim()}
=> with ${valueEqualityApproach.readableName}
''';
    test(
      composedDescription,
      () async {
        registerFallbackValue(systemEncoding);
        final tempDir = Directory.systemTemp.createTempSync(
          'altoke-entity-e2e-test-${valueEqualityApproach.varIdentifier}-',
        );
        addTearDown(() => tempDir.deleteSync(recursive: true));
        final directoryGeneratorTarget = DirectoryGeneratorTarget(tempDir);
        final altokeCommonVars = <String, dynamic>{
          ValueEqualityApproach.varKey: valueEqualityApproach.readableName,
        };
        await BrickGenerator.common.runFullGeneration(
          target: directoryGeneratorTarget,
          vars: altokeCommonVars,
        );
        final altokeEntityVars = <String, dynamic>{
          ValueEqualityApproach.varKey: valueEqualityApproach.readableName,
          'entity_singular': 'test entity',
          'package_description': 'Test entity.',
        };
        await BrickGenerator.entity.runFullGeneration(
          target: directoryGeneratorTarget,
          vars: altokeEntityVars,
        );
        final outputPath = path.join(
          directoryGeneratorTarget.dir.path,
          'test_entity',
        );
        final outputDir = Directory(outputPath);
        final coverageDir = Directory(path.join(outputPath, 'coverage'));
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
            reportOn: Directory(path.join(outputPath, 'lib')),
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
    final (:valueEqualityApproach) = generationCase;
    final composedDescription = '''

${description.trim()}
=> with ${valueEqualityApproach.readableName}
''';
    test(
      composedDescription,
      () async {
        registerFallbackValue(systemEncoding);
        final tempDir = Directory.systemTemp.createTempSync(
          'altoke-entity-e2e-test-${valueEqualityApproach.varIdentifier}-',
        );
        addTearDown(() => tempDir.deleteSync(recursive: true));
        final directoryGeneratorTarget = DirectoryGeneratorTarget(tempDir);
        final outputDir =
            directoryGeneratorTarget.dir.descendantDir('test_entity');
        final altokeEntityVars = <String, dynamic>{
          ValueEqualityApproach.varKey: valueEqualityApproach.readableName,
          'entity_singular': 'test entity',
          'package_description': 'Test entity.',
        };
        await BrickGenerator.entity.runFullGeneration(
          target: directoryGeneratorTarget,
          vars: altokeEntityVars,
        );
        expect(outputDir.existsSync(), isFalse);
      },
      timeout: const Timeout(Duration(minutes: 5)),
    );
  }
}
