@Tags(['e2e'])
library brick_e2e_test;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import 'value_equality.dart';

Future<MasonGenerator> asyncGenerator = Future(() async {
  final e2eTestsPath = Platform.environment['MELOS_PACKAGE_PATH'] ?? '';
  if (e2eTestsPath.isEmpty) {
    throw StateError(
      'This test must be under a mono-repo managed by melos',
    );
  }
  final scopeDir = Directory(e2eTestsPath).parent;
  final brickPath = path.joinAll([scopeDir.path, 'brick']);
  final brick = Brick.path(brickPath);
  return MasonGenerator.fromBrick(brick);
});

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
        registerFallbackValue(systemEncoding);
        final masonGenerator = await asyncGenerator;
        final tempDirectory = Directory.systemTemp.createTempSync(
          'altoke-common-e2e-test-${valueEqualityApproach.varIdentifier}-',
        );
        addTearDown(() => tempDirectory.deleteSync(recursive: true));
        final directoryGeneratorTarget =
            DirectoryGeneratorTarget(tempDirectory);
        final vars = <String, dynamic>{
          ValueEqualityApproach.varKey: valueEqualityApproach.varIdentifier,
        };
        await masonGenerator.hooks.preGen(
          workingDirectory: directoryGeneratorTarget.dir.path,
          vars: vars,
          onVarsChanged: (updatedVars) {
            vars
              ..clear()
              ..addAll(updatedVars);
          },
        );
        await masonGenerator.generate(
          directoryGeneratorTarget,
          vars: vars,
        );
        await masonGenerator.hooks.postGen(
          workingDirectory: directoryGeneratorTarget.dir.path,
          vars: vars,
          onVarsChanged: (updatedVars) {
            vars
              ..clear()
              ..addAll(updatedVars);
          },
        );
        final outputPath = path.join(
          directoryGeneratorTarget.dir.path,
          'common',
        );
        final formatResult = await runCommand(
          'dart format --set-exit-if-changed .',
          projectPath: outputPath,
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
        final analyzeResult = await runCommand(
          'dart analyze --fatal-infos --fatal-warnings .',
          projectPath: outputPath,
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
        final testResult = await runCommand(
          '''dart test --coverage=coverage -r expanded --test-randomize-ordering-seed random''',
          projectPath: outputPath,
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
        final formatCoverageResult = await runCommand(
          '''format_coverage --lcov --in=coverage --out=coverage/lcov.info --report-on=lib''',
          projectPath: outputPath,
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
        final coverageFilterResult = await runCommand(
          r'''coverde filter --input ./coverage/lcov.info --output ./coverage/filtered.lcov.info --filters \.freezed\.dart,\.g\.dart,\.mapper\.dart''',
          projectPath: outputPath,
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
        final coverageCheckResult = await runCommand(
          'coverde check -i coverage/filtered.lcov.info 100',
          projectPath: outputPath,
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

Future<ProcessResult> runCommand(
  String fullCommand, {
  required String projectPath,
}) async {
  final [command, ...args] = fullCommand.split(' ');
  final result = await Process.run(
    command,
    args,
    workingDirectory: projectPath,
    runInShell: true,
  );
  return result;
}
