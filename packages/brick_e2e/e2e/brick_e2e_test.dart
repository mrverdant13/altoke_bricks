@Tags(['e2e'])
library brick_e2e;

import 'dart:async';
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

final logger = Logger(
  level: Level.verbose,
);

Future<MasonGenerator> generator = Future(() async {
  final rootDir = Directory.current.parent.parent;
  logger.info('$greenCheck Root monorepo directory: ${rootDir.path}');
  final brickPath = path.joinAll([rootDir.path, 'packages', 'brick']);
  logger.info('$greenCheck Brick path: $brickPath');
  final brick = Brick.path(brickPath);
  return MasonGenerator.fromBrick(brick);
});

final greenCheck = green.wrap('✓');

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
        // final rootDir = Directory.current.parent.parent;
        // final brickPath = path.joinAll([rootDir.path, 'packages', 'brick']);
        // final brick = Brick.path(brickPath);
        // final masonGenerator = await MasonGenerator.fromBrick(brick);
        final masonGenerator = await generator;
        logger.info('$greenCheck Mason generator created');
        final tempDirectory = Directory.systemTemp.createTempSync(
          'altoke-app-e2e-test-${router.identifier}-${database.identifier}-',
        );
        logger.info('$greenCheck Temp directory created');
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
        await masonGenerator.generate(
          directoryGeneratorTarget,
          vars: vars,
          logger: logger,
        );
        logger.info('$greenCheck App generation completed');
        await masonGenerator.hooks.postGen(
          workingDirectory: directoryGeneratorTarget.dir.path,
          vars: vars,
          onVarsChanged: (updatedVars) {
            vars
              ..clear()
              ..addAll(updatedVars);
          },
          logger: logger,
        );
        logger.info('$greenCheck App post-gen hook executed');
        final applicationPath = path.join(
          directoryGeneratorTarget.dir.path,
          projectName,
        );
        final testResult = await runCommand(
          'melos run T',
          projectPath: applicationPath,
          prefix: '🧪 ',
          startMessage: 'Running tests.',
          successMessage: 'Tests complete!',
          failureMessage: 'Tests failed!',
        );
        expect(
          testResult,
          isSuccessfulProcessResult,
          reason: 'Tests failed',
        );
        final coverageMergingResult = await runCommand(
          'melos run M',
          projectPath: applicationPath,
          prefix: '📃 ',
          startMessage: 'Gathering test coverage.',
          successMessage: 'Test coverage gathered!',
          failureMessage: 'Test coverage gathering failed!',
        );
        expect(
          coverageMergingResult,
          isSuccessfulProcessResult,
          reason: 'Coverage gathering failed',
        );
        final coverageCheckResult = await runCommand(
          'melos run C',
          projectPath: applicationPath,
          prefix: '🕵🏻 ',
          startMessage: 'Checking test coverage.',
          successMessage: 'Coverage check complete!',
          failureMessage: 'Coverage check failed!',
        );
        expect(
          coverageCheckResult,
          isSuccessfulProcessResult,
          reason: 'Coverage check failed',
        );
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
  required String prefix,
  required String startMessage,
  required String successMessage,
  required String failureMessage,
}) async {
  final [command, ...args] = fullCommand.split(' ');
  final progress = logger.progress('$prefix$startMessage');
  final progressTimer = Timer.periodic(
    const Duration(milliseconds: 100),
    (timer) {
      progress.update('$prefix$startMessage');
    },
  );
  final result = await Process.run(
    command,
    args,
    workingDirectory: projectPath,
    runInShell: true,
  );
  progressTimer.cancel();
  switch (result.exitCode) {
    case 0:
      progress.complete('$prefix$successMessage');
    case _:
      progress.fail('$prefix$failureMessage');
  }
  return result;
}
