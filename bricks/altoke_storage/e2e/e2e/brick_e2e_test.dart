@Tags(['e2e'])
library brick_e2e_test;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:data_persistence_approach/data_persistence_approach.dart';
import 'package:mason/mason.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:monorepo_elements/monorepo_elements.dart';
import 'package:path/path.dart' as path;
import 'package:shell/shell.dart';
import 'package:test/test.dart';

Future<void> main() async {
  // FIXME: Test Realm approach once it is testable.
  // Ref: https://github.com/realm/realm-dart/issues/1619
  final testableApproaches = DataPersistenceApproach.values.where(
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
        // addTearDown(() => tempDir.deleteSync(recursive: true));
        final directoryGeneratorTarget = DirectoryGeneratorTarget(tempDir);
        final altokeCommonVars = <String, dynamic>{
          'value_equality_approach': 'overrides',
        };
        await BrickGenerator.common.runFullGeneration(
          target: directoryGeneratorTarget,
          vars: altokeCommonVars,
        );
        final altokeEntityVars = <String, dynamic>{
          'entity_singular': 'altoke entity',
          'package_description': 'Altoke entity.',
          'value_equality_approach': 'overrides',
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
          final formatResult = await Shell.run(
            'dart format --set-exit-if-changed .',
            workingDir: workingDir,
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
            workingDir: workingDir,
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
            workingDir: workingDir,
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
            workingDir: workingDir,
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
            r'''coverde filter --input ./coverage/lcov.info --output ./coverage/filtered.lcov.info --filters \.drift\.dart,\.g\.dart,\.realm\.dart''',
            workingDir: workingDir,
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
            workingDir: workingDir,
            throwOnError: false,
          );
          expect(
            coverageCheckResult,
            isSuccessfulProcessResult,
            reason: 'Coverage check failed',
          );
        }

        await runCommands(workingDir: interfaceProjectPath);
        await runCommands(workingDir: implementationProjectPath);
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
