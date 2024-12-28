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

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync(
      'altoke-reactive-caches-e2e-test-',
    );
    target = DirectoryGeneratorTarget(tempDir);
    outputDir = target.dir.descendantDir('reactive_caches');
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  test(
    '''

GIVEN the Altoke Reactive Caches brick
AND an existing "common" package
WHEN the generation is run
THEN the generated outputs should be valid and testable
''',
    () async {
      final altokeCommonVars = <String, dynamic>{
        'value_equality_approach': 'Overrides',
      };
      await BrickGenerator.common.runFullGeneration(
        target: target,
        vars: altokeCommonVars,
      );
      final altokeReactiveCachesVars = <String, dynamic>{};
      await BrickGenerator.reactiveCaches.runFullGeneration(
        target: target,
        vars: altokeReactiveCachesVars,
      );
      final coverageDir = outputDir.descendantDir('coverage');
      final baseLcovFile = coverageDir.descendantFile('lcov.info');
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
          reportOn: outputDir.descendantDir('lib'),
        ),
        completes,
      );
      await expectLater(
        Coverage.check(
          inputLcov: baseLcovFile,
          threshold: 100,
        ),
        completes,
      );
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );

  test(
    '''

GIVEN the Altoke Reactive Caches brick
AND no existing "common" package
WHEN the generation is run
THEN not output should be generated
''',
    () async {
      final altokeReactiveCachesVars = <String, dynamic>{};
      await BrickGenerator.reactiveCaches.runFullGeneration(
        target: target,
        vars: altokeReactiveCachesVars,
      );
      expect(outputDir.existsSync(), isFalse);
    },
  );
}
