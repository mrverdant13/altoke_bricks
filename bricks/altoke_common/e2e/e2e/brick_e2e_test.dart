@Tags(['e2e'])
library;

import 'dart:async';
import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:mason/mason.dart';
import 'package:meta/meta.dart';
import 'package:monorepo_elements/monorepo_elements.dart';
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
  final valueEqualityApproaches = rawValueEqualityApproaches.values!.map(
    ValueEqualityApproach.fromReadableName,
  );
  await testGeneration(
    cases: {
      for (final valueEqualityApproach in valueEqualityApproaches)
        (valueEqualityApproach: valueEqualityApproach),
    },
  );

  await testGenerationWithoutHooks(
    cases: {
      for (final valueEqualityApproach in valueEqualityApproaches)
        (valueEqualityApproach: valueEqualityApproach),
    },
  );
}

typedef GenerationCase = ({ValueEqualityApproach valueEqualityApproach});

@isTest
Future<void> testGeneration({required Set<GenerationCase> cases}) async {
  for (final generationCase in cases) {
    final (:valueEqualityApproach) = generationCase;
    final composedDescription = '''

GIVEN the Altoke Common brick
AND hooks enabled
WHEN the generation is run
THEN the generated outputs should be valid and testable
=> with ${valueEqualityApproach.readableName}
''';
    test(composedDescription, () async {
      final tempDirectory = Directory.systemTemp.createTempSync(
        'altoke-common-e2e-test-${valueEqualityApproach.varIdentifier}-',
      );
      addTearDown(() => tempDirectory.deleteSync(recursive: true));
      final directoryGeneratorTarget = DirectoryGeneratorTarget(tempDirectory);
      final altokeCommonVars = <String, dynamic>{
        ValueEqualityApproach.varKey: valueEqualityApproach.readableName,
      };
      await BrickGenerator.common.runGeneration(
        target: directoryGeneratorTarget,
        vars: altokeCommonVars,
        runHooks: true,
      );

      final outputDir = directoryGeneratorTarget.outputDir;
      final coverageDir = directoryGeneratorTarget.coverageDir;
      final baseLcovFile = directoryGeneratorTarget.baseLcovFile;
      final filteredLcovFile = directoryGeneratorTarget.filteredLcovFile;
      await expectLater(Dart.format(outputDir, failIfChanged: true), completes);
      await expectLater(
        Dart.analyze(outputDir, fatalInfos: true, fatalWarnings: true),
        completes,
      );
      await expectLater(
        Dart.test(outputDir, coverageDirectory: coverageDir),
        completes,
      );
      await expectLater(
        Coverage.formatAsLcov(
          input: coverageDir,
          output: baseLcovFile,
          reportOn: outputDir.descendantDir('lib'),
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
    }, timeout: const Timeout(Duration(minutes: 5)));
  }
}

@isTest
Future<void> testGenerationWithoutHooks({
  required Set<GenerationCase> cases,
}) async {
  for (final generationCase in cases) {
    final (:valueEqualityApproach) = generationCase;
    final composedDescription = '''

GIVEN the Altoke Common brick
AND hooks disabled
WHEN the generation is run
THEN the generated outputs should be valid and testable
=> with ${valueEqualityApproach.readableName}
''';
    test(composedDescription, () async {
      final tempDirectory = Directory.systemTemp.createTempSync(
        'altoke-common-e2e-test-${valueEqualityApproach.varIdentifier}-',
      );
      addTearDown(() => tempDirectory.deleteSync(recursive: true));
      final directoryGeneratorTarget = DirectoryGeneratorTarget(tempDirectory);
      final altokeCommonVars = <String, dynamic>{
        ValueEqualityApproach.varKey: valueEqualityApproach.readableName,
      };
      Future<void> action() async => BrickGenerator.common.runGeneration(
        target: directoryGeneratorTarget,
        vars: altokeCommonVars,
        runHooks: false,
      );
      expect(action(), throwsA(isNotNull));
      final outputDir = directoryGeneratorTarget.outputDir;
      expect(outputDir.existsSync(), isFalse);
      final requirementsFile = directoryGeneratorTarget.requirementsFile;
      expect(requirementsFile.existsSync(), isFalse);
    });
  }
}

extension on DirectoryGeneratorTarget {
  Directory get outputDir => dir.descendantDir('common');
  File get requirementsFile => dir.descendantFile('REQUIREMENTS.md');
  Directory get coverageDir => outputDir.descendantDir('coverage');
  File get baseLcovFile => coverageDir.descendantFile('lcov.info');
  File get filteredLcovFile => coverageDir.descendantFile('filtered.lcov.info');
}
