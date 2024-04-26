import 'dart:async';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:pubspec_sorter/pubspec_sorter.dart';

import 'src/data_persistence.dart';

Future<void> run(HookContext context) async {
  final selectedApproach = DataPersistenceApproach.getSelectedApproach(context);
  final logger = context.logger;

  Future<void> runCommands({
    required String projectPath,
    required bool runCodeGeneration,
  }) async {
    sortPubspecDependencies(projectPath);
    await runCommand(
      'dart pub get',
      projectPath: projectPath,
      logger: logger,
      prefix: '📦 ',
      startMessage: 'Installing dependencies.',
      completeMessage: 'Dependencies installed!',
    );
    if (runCodeGeneration) {
      await runCommand(
        selectedApproach.codeGenerationCommand,
        projectPath: projectPath,
        logger: logger,
        prefix: '🏭 ',
        startMessage: 'Running code generation.',
        completeMessage: 'Code generation complete!',
      );
    }
    await runCommand(
      'dart fix --apply --code=directives_ordering',
      projectPath: projectPath,
      logger: logger,
      prefix: '🔧 ',
      startMessage: 'Applying fixes.',
      completeMessage: 'Fixes applied!',
    );
    await runCommand(
      'dart format .',
      projectPath: projectPath,
      logger: logger,
      prefix: '🪄  ',
      startMessage: 'Formatting code.',
      completeMessage: 'Code formatted!',
    );
  }

  final umbrellaPath = path.join(
    Directory.current.path,
    '${(context.vars['objects'] as String).snakeCase}_storage',
  );
  final interfaceProjectPath = path.join(
    umbrellaPath,
    '${(context.vars['objects'] as String).snakeCase}_storage',
  );
  await runCommands(
    projectPath: interfaceProjectPath,
    runCodeGeneration: false,
  );
  final implementationProjectPath = path.join(
    umbrellaPath,
    '''${(context.vars['objects'] as String).snakeCase}_${selectedApproach.varIdentifier}_storage''',
  );
  await runCommands(
    projectPath: implementationProjectPath,
    runCodeGeneration: true,
  );
}

Future<ProcessResult> runCommand(
  String fullCommand, {
  required String projectPath,
  required Logger logger,
  required String prefix,
  required String startMessage,
  required String completeMessage,
}) async {
  final [command, ...args] = fullCommand.split(' ');
  const progressMessages = [
    'This may take a while',
    'Still working',
    'Almost there',
    'Just a little longer',
  ];
  final progress = logger.progress('$prefix$startMessage');
  final progressTimer = Timer.periodic(
    const Duration(milliseconds: 100),
    (timer) {
      final messageIndex = (timer.tick ~/ 50) % progressMessages.length;
      final message = progressMessages[messageIndex];
      progress.update('$prefix$startMessage $message');
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
      progress.complete('$prefix$completeMessage');
    case _:
      final errorDetails = result.stderr?.toString();
      progress.fail('$prefix${errorDetails == null ? '' : '\n$errorDetails'}');
      exit(result.exitCode);
  }
  return result;
}
