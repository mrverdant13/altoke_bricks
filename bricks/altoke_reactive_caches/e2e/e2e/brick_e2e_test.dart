@Tags(['e2e'])
library;

import 'dart:async';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:monorepo_elements/monorepo_elements.dart';
import 'package:shell/coverage.dart';
import 'package:shell/dart.dart';
import 'package:test/test.dart';

Future<void> main() async {
  late Directory tempDir;
  late DirectoryGeneratorTarget target;
  late Directory outputDir;
  late File requirementsFile;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync(
      'altoke-reactive-caches-e2e-test-',
    );
    target = DirectoryGeneratorTarget(tempDir);
    outputDir = target.dir.descendantDir('reactive_caches');
    requirementsFile = target.dir.descendantFile('REQUIREMENTS.md');
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  test(
    '''

GIVEN the Altoke Reactive Caches brick
AND hooks enabled
AND an existing "common" package
WHEN the generation is run
THEN the generated outputs should be valid and testable
''',
    () async {
      final altokeCommonVars = <String, dynamic>{
        'value_equality_approach': 'Overrides',
      };
      await BrickGenerator.common.runGeneration(
        target: target,
        vars: altokeCommonVars,
        runHooks: true,
      );
      final altokeReactiveCachesVars = <String, dynamic>{};
      await BrickGenerator.reactiveCaches.runGeneration(
        target: target,
        vars: altokeReactiveCachesVars,
        runHooks: true,
      );
      expect(outputDir.existsSync(), isTrue);
      expect(requirementsFile.existsSync(), isFalse);
      final coverageDir = outputDir.descendantDir('coverage');
      final baseLcovFile = coverageDir.descendantFile('lcov.info');
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
        Coverage.check(inputLcov: baseLcovFile, threshold: 100),
        completes,
      );
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );

  test(
    '''

GIVEN the Altoke Reactive Caches brick
AND hooks enabled
AND no existing "common" package
WHEN the generation is run
THEN the errors file should be generated
''',
    () async {
      final altokeReactiveCachesVars = <String, dynamic>{};
      await BrickGenerator.reactiveCaches.runGeneration(
        target: target,
        vars: altokeReactiveCachesVars,
        runHooks: true,
      );
      expect(outputDir.existsSync(), isFalse);
      expect(requirementsFile.existsSync(), isTrue);
    },
  );

  test(
    '''

GIVEN the Altoke Reactive Caches brick
AND hooks disabled
AND an existing "common" package
WHEN the generation is run
THEN no output should be generated
''',
    () async {
      final altokeCommonVars = <String, dynamic>{
        'value_equality_approach': 'Overrides',
      };
      await BrickGenerator.common.runGeneration(
        target: target,
        vars: altokeCommonVars,
        runHooks: true,
      );
      final altokeReactiveCachesVars = <String, dynamic>{};
      Future<void> action() async =>
          BrickGenerator.reactiveCaches.runGeneration(
            target: target,
            vars: altokeReactiveCachesVars,
            runHooks: false,
          );
      expect(action(), throwsA(isNotNull));
      expect(outputDir.existsSync(), isFalse);
      expect(requirementsFile.existsSync(), isFalse);
    },
  );
}
