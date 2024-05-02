import 'dart:async';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:value_equality_approach/value_equality_approach.dart';

Future<void> run(HookContext context) async {
  final projectPath = path.join(
    Directory.current.path,
    'common',
  );
  final logger = context.logger;
  await runCommand(
    'dart pub get',
    projectPath: projectPath,
    logger: logger,
    prefix: '📦 ',
    startMessage: 'Installing dependencies.',
    completeMessage: 'Dependencies installed!',
  );
  if (ValueEqualityApproach.getSelectedApproach(context).usesCodeGeneration) {
    await runCommand(
      'dart run build_runner build --delete-conflicting-outputs',
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
