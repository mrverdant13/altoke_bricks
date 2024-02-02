@Tags(['e2e'])
library brick_e2e;

import 'dart:convert';
import 'dart:io'
    show Directory, Process, ProcessResult, Stdin, Stdout, systemEncoding;

import 'package:mason/mason.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

class MockStdin extends Mock implements Stdin {}

class MockStdout extends Mock implements Stdout {}

enum Router {
  autoRoute('auto_route'),
  goRouter('go_router'),
  ;

  const Router(this.identifier);

  final String identifier;

  Map<String, bool> get selectionVarsMap => {
        for (final router in Router.values)
          'use_${router.identifier}_router': router == this,
      };
}

enum Database {
  hive('hive'),
  isar('isar'),
  realm('realm'),
  sembast('sembast'),
  sqlite('sqlite'),
  ;

  const Database(this.identifier);

  final String identifier;

  Map<String, bool> get selectionVarsMap => {
        for (final database in Database.values)
          'use_${database.identifier}_database': database == this,
      };
}

Future<void> main() async {
  await testAppGeneration(
    '''

GIVEN the Altoke app brick
WHEN an app generation is run
THEN the generated app should be valid and testable
''',
    generationCases: {
      for (final router in Router.values)
        for (final database in Database.values)
          (router: router, database: database),
    },
  );
}

typedef AppGenerationCase = ({
  Router router,
  Database database,
});

@isTest
Future<void> testAppGeneration(
  String description, {
  required Set<AppGenerationCase> generationCases,
}) async {
  for (final generationCase in generationCases) {
    final (:router, :database) = generationCase;
    final composedDescription = '''

${description.trim()}
=> with `${router.identifier}`
=> with `${database.identifier}`
''';
    test(
      composedDescription,
      () async {
        // final terminalStdout = io.stdout;
        // final mockStdin = MockStdin();
        // final mockStdout = MockStdout();
        // final mockStderr = MockStdout();
        // IOOverrides.runZoned(
        //   () async {
        registerFallbackValue(systemEncoding);
        // when(() => mockStdout.supportsAnsiEscapes).thenReturn(true);
        final rootDir = Directory.current.parent.parent;
        final brickPath = path.joinAll([rootDir.path, 'packages', 'brick']);
        final brick = Brick.path(brickPath);
        final masonGenerator = await MasonGenerator.fromBrick(brick);
        final tempDirectory = Directory.systemTemp.createTempSync(
          'altoke-app-e2e-test-${router.identifier}-${database.identifier}-',
        );
        final directoryGeneratorTarget =
            DirectoryGeneratorTarget(tempDirectory);

        // HACK: Bypass the `preGen` hook by setting the `vars` directly.
        // This is required since the logger provided to the `preGen` hook
        // does not seem to be the same that the logger injected in the
        // `HookContext` of the pre-gen hook implementation.
        // See: https://discord.com/channels/649708778631200778/846830668386271263/1148828740785295450
        final projectName =
            'e2e_${router.identifier}_${database.identifier}_app';
        final projectDescription =
            'E2E App (`${router.identifier}` - `${database.identifier}`).';
        final vars = <String, dynamic>{
          'silent': true,
          'project_name': projectName,
          'project_description': projectDescription,
          ...router.selectionVarsMap,
          ...database.selectionVarsMap,
        };
        // var stepIndex = 0;
        // when(mockStdin.readLineSync).thenReturn(
        //   () {
        //     final value = switch (stepIndex) {
        //       0 => 'e2e_app_$routerPackageName',
        //       1 => 'E2E App (with `$routerPackageName`).',
        //       2 => routerPackageName,
        //       _ => null
        //     };
        //     stepIndex++;
        //     return value;
        //   }(),
        // );
        // await masonGenerator.hooks.preGen(
        //   workingDirectory: directoryGeneratorTarget.dir.path,
        //   vars: vars,
        //   onVarsChanged: (updatedVars) {
        //     vars
        //       ..clear()
        //       ..addAll(updatedVars);
        //   },
        // );
        final logger = Logger();
        await masonGenerator.generate(
          directoryGeneratorTarget,
          vars: vars,
          logger: logger,
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
        final applicationPath = path.join(
          directoryGeneratorTarget.dir.path,
          projectName,
        );
        const testFullCommand = 'melos run T';
        final [testCommand, ...testArgs] = testFullCommand.split(' ');
        final testResult = await Process.run(
          testCommand,
          testArgs,
          workingDirectory: applicationPath,
          runInShell: true,
        );
        expect(
          testResult,
          isSuccessfulProcessResult,
          reason: 'Tests failed',
        );
        const mergeCoverageFullCommand = 'melos run M';
        final [mergeCoverageCommand, ...mergeCoverageArgs] =
            mergeCoverageFullCommand.split(' ');
        final coverdeFilterResult = await Process.run(
          mergeCoverageCommand,
          mergeCoverageArgs,
          workingDirectory: applicationPath,
          runInShell: true,
        );
        expect(
          coverdeFilterResult,
          isSuccessfulProcessResult,
          reason: 'Coverage gathering failed',
        );
        const checkCoverageFullCommand = 'melos run C';
        final [checkCoverageCommand, ...checkCoverageArgs] =
            checkCoverageFullCommand.split(' ');
        final coverdeCheckResult = await Process.run(
          checkCoverageCommand,
          checkCoverageArgs,
          workingDirectory: applicationPath,
          runInShell: true,
        );
        expect(
          coverdeCheckResult,
          isSuccessfulProcessResult,
          reason: 'Coverage check failed',
        );
        // expect(
        //   coverdeCheck.exitCode,
        //   isZero,
        //   reason: 'Coverage check failed'
        //       '\n'
        //       '${coverdeCheck.stderr}',
        // );
        // expect(
        //   coverdeCheck.stderr,
        //   isEmpty,
        //   reason: 'Coverage check failed'
        //       '\n'
        //       '${coverdeCheck.stderr}',
        // );
        tempDirectory.deleteSync(recursive: true);
        //   },
        //   stdin: () => mockStdin,
        //   stdout: () => mockStdout,
        //   stderr: () => mockStderr,
        // );
      },
      timeout: const Timeout(Duration(minutes: 15)),
    );
  }
}

final isSuccessfulProcessResult = isA<ProcessResult>()
    .having(
  (processResult) => processResult.exitCode,
  'exitCode',
  isZero,
)
    .having(
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
);
