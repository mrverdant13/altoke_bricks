@Tags(['e2e'])
library brick_e2e_test;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:meta/meta.dart';
import 'package:monorepo_elements/monorepo_elements.dart';
import 'package:path/path.dart' as path;
import 'package:shell/shell.dart';
import 'package:test/test.dart';

import 'value_equality.dart';

Future<void> main() async {
  await testGeneration(
    '''

GIVEN the Altoke Common brick
WHEN the generation is run
THEN the generated outputs should be valid and testable
''',
    generationCases: {
      for (final valueEqualityApproach in ValueEqualityApproach.values)
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
=> with `${valueEqualityApproach.varIdentifier}`
''';
    test(
      composedDescription,
      () async {
        final tempDirectory = Directory.systemTemp.createTempSync(
          'altoke-common-e2e-test-${valueEqualityApproach.varIdentifier}-',
        );
        addTearDown(() => tempDirectory.deleteSync(recursive: true));
        final directoryGeneratorTarget =
            DirectoryGeneratorTarget(tempDirectory);
        final altokeCommonVars = <String, dynamic>{
          ValueEqualityApproach.varKey: valueEqualityApproach.varIdentifier,
        };
        await BrickGenerator.common.runFullGeneration(
          target: directoryGeneratorTarget,
          vars: altokeCommonVars,
        );
        final outputPath = path.join(
          directoryGeneratorTarget.dir.path,
          'common',
        );
        final formatResult = await Shell.run(
          'dart format --set-exit-if-changed .',
          workingDir: outputPath,
          throwOnError: false,
        );
        expect(
          formatResult,
          isSuccessfulProcessResult,
          reason: [
            'Project format failed',
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
            'Project analysis failed',
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
        final coverageFilterResult = await Shell.run(
          r'''coverde filter --input ./coverage/lcov.info --output ./coverage/filtered.lcov.info --filters \.freezed\.dart,\.g\.dart,\.mapper\.dart''',
          workingDir: outputPath,
          throwOnError: false,
        );
        expect(
          coverageFilterResult,
          isSuccessfulProcessResult,
          reason: [
            'Coverage filter failed',
            '${coverageFilterResult.stdout}',
            '${coverageFilterResult.stderr}',
          ].join('\n'),
        );
        final coverageCheckResult = await Shell.run(
          'coverde check -i coverage/filtered.lcov.info 100',
          workingDir: outputPath,
          throwOnError: false,
        );
        expect(
          coverageCheckResult,
          isSuccessfulProcessResult,
          reason: 'Coverage check failed',
        );
      },
      timeout: const Timeout(Duration(minutes: 5)),
    );
  }
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
