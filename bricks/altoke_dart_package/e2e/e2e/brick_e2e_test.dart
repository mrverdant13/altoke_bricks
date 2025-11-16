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
      'altoke-dart-package-e2e-test-',
    );
    target = DirectoryGeneratorTarget(tempDir);
    outputDir = target.dir.descendantDir('test_altoke_dart_package');
    requirementsFile = target.dir.descendantFile('REQUIREMENTS.md');
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  test(
    '''

GIVEN the Altoke Dart Package brick
AND hooks enabled
WHEN the generation is run
THEN the generated outputs should be valid and testable
''',
    () async {
      final altokeDartPackageVars = <String, dynamic>{
        'package_name': 'test_altoke_dart_package',
        'package_description': 'A test Altoke Dart package.',
        'use_code_generation': true,
      };
      await BrickGenerator.dartPackage.runGeneration(
        target: target,
        vars: altokeDartPackageVars,
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
          reportOn: outputDir,
        ),
        completes,
      );
      await expectLater(
        Coverage.check(inputLcov: baseLcovFile, threshold: 100),
        completes,
      );
    },
    timeout: const Timeout(Duration(minutes: 5)),
  );

  test(
    '''

GIVEN the Altoke Dart Package brick
AND hooks disabled
WHEN the generation is run
THEN only the requirements file should be generated
''',
    () async {
      final altokeDartPackageVars = <String, dynamic>{
        'package_name': 'test_altoke_dart_package',
        'package_description': 'A test Altoke Dart package.',
        'use_code_generation': true,
      };
      await BrickGenerator.dartPackage.runGeneration(
        target: target,
        vars: altokeDartPackageVars,
        runHooks: false,
      );
      expect(outputDir.existsSync(), isFalse);
      expect(requirementsFile.existsSync(), isTrue);
    },
  );
}
