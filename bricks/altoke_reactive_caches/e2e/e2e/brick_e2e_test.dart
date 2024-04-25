@Tags(['e2e'])
library brick_e2e_test;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:monorepo_elements/monorepo_elements.dart';
import 'package:path/path.dart' as path;
import 'package:shell/shell.dart';
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
        'value_equality_approach': 'overrides',
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
      final outputPath = path.join(tempDir.path, 'reactive_caches');
      final formatResult = await Shell.run(
        'dart format --set-exit-if-changed .',
        workingDir: outputPath,
        throwOnError: false,
      );
      expect(
        formatResult,
        isSuccessfulProcessResult,
        reason: [
          'Project format check failed',
          '${formatResult.stdout}',
          '${formatResult.stderr}',
        ].join('\n'),
      );
      final analyzeResult = await Shell.run(
        'dart analyze --fatal-infos --fatal-warnings .',
        workingDir: outputPath,
        throwOnError: false,
      );
      expect(
        analyzeResult,
        isSuccessfulProcessResult,
        reason: [
          'Project analysis check failed',
          '${analyzeResult.stdout}',
          '${analyzeResult.stderr}',
        ].join('\n'),
      );
      final testResult = await Shell.run(
        '''dart test --coverage=coverage -r expanded --test-randomize-ordering-seed random''',
        workingDir: outputPath,
        throwOnError: false,
      );
      expect(
        testResult,
        isSuccessfulProcessResult,
        reason: [
          'Tests failed',
          '${testResult.stdout}',
          '${testResult.stderr}',
        ].join('\n'),
      );
      final formatCoverageResult = await Shell.run(
        '''format_coverage --lcov --in=coverage --out=coverage/lcov.info --report-on=lib''',
        workingDir: outputPath,
        throwOnError: false,
      );
      expect(
        formatCoverageResult,
        isSuccessfulProcessResult,
        reason: [
          'Coverage format failed',
          '${formatCoverageResult.stdout}',
          '${formatCoverageResult.stderr}',
        ].join('\n'),
      );
      final coverageCheckResult = await Shell.run(
        'coverde check -i coverage/lcov.info 100',
        workingDir: outputPath,
        throwOnError: false,
      );
      expect(
        coverageCheckResult,
        isSuccessfulProcessResult,
        reason: 'Coverage check failed',
      );
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}

final isSuccessfulProcessResult = isA<ProcessResult>().having(
  (processResult) {
    final rawLines = LineSplitter.split(processResult.stderr.toString());
    final sanitizedLines = rawLines.where(
      (rawLine) {
        final line = rawLine.trim().lowerCase;
        if (line.isEmpty) return false;
        final kernelLoadErrorFragment = 'load Kernel binary'.lowerCase;
        return !line.contains(kernelLoadErrorFragment);
      },
    );
    final buf = StringBuffer();
    for (final line in sanitizedLines) {
      buf.writeln(line);
    }
    final sanitizedStderr = buf.toString().trim();
    return sanitizedStderr;
  },
  'stderr',
  isEmpty,
).having(
  (processResult) => processResult.exitCode,
  'exitCode',
  isZero,
);
