import 'dart:async';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

Future<void> run(HookContext context) async {
  final projectPath = path.join(
    Directory.current.path,
    context.vars['project_name'] as String,
  );
  final actualAppPath = path.joinAll([projectPath, 'packages', 'app']);
  final logger = context.logger;
  await runCommand(
    'melos bs',
    projectPath: projectPath,
    logger: logger,
    prefix: '📦 ',
    startMessage: 'Bootstrapping project.',
    completeMessage: 'Project bootstrapped!',
  );
  await runCommand(
    'melos run gen.all.fast',
    projectPath: projectPath,
    logger: logger,
    prefix: '🏭 ',
    startMessage: 'Running code generation.',
    completeMessage: 'Code generation complete!',
  );
  const dartFixCommand = 'dart fix --apply --code=directives_ordering';
  await runCommand(
    '$dartFixCommand lib && $dartFixCommand test',
    projectPath: actualAppPath,
    logger: logger,
    prefix: '🔧 ',
    startMessage: 'Applying fixes.',
    completeMessage: 'Fixes applied!',
  );
  await runCommand(
    'melos run format.all.fast',
    projectPath: projectPath,
    logger: logger,
    prefix: '🪄  ',
    startMessage: 'Formatting code.',
    completeMessage: 'Code formatted!',
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
