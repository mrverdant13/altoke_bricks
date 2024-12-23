@Tags(['e2e'])
library;

import 'dart:async';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:monorepo_elements/monorepo_elements.dart';
import 'package:path/path.dart' as path;
import 'package:shell/coverage.dart';
import 'package:shell/dart.dart';
import 'package:test/test.dart';

Future<void> main() async {
  test(
    '''

GIVEN the Altoke Reactive Caches brick
WHEN the generation is run
THEN the generated outputs should be valid and testable
''',
    () async {
      final tempDir = Directory.systemTemp.createTempSync(
        'altoke-reactive-caches-e2e-test-',
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
      final altokeReactiveCachesVars = <String, dynamic>{};
      await BrickGenerator.reactiveCaches.runFullGeneration(
        target: directoryGeneratorTarget,
        vars: altokeReactiveCachesVars,
      );
      final outputPath = path.join(
        directoryGeneratorTarget.dir.path,
        'reactive_caches',
      );
      final outputDir = Directory(outputPath);
      final coverageDir = Directory(path.join(outputPath, 'coverage'));
      final baseLcovFile = File(path.join(coverageDir.path, 'lcov.info'));
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
        Coverage.check(
          inputLcov: baseLcovFile,
          threshold: 100,
        ),
        completes,
      );
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
