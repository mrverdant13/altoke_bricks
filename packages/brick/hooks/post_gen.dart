import 'dart:async';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

Future<void> run(HookContext context) async {
  final projectPath = path.join(
    Directory.current.path,
    context.vars['project_name'] as String,
  );
  final logger = context.logger;
  if (bool.tryParse('${context.vars['silent']}') ?? false) {
    logger.level = Level.quiet;
  }
  await runCommand(
    command: 'flutter',
    args: [
      'pub',
      'get',
    ],
    projectPath: projectPath,
    logger: logger,
    prefix: '📦 ',
    startMessage: 'Resolving dependencies.',
    completeMessage: 'Dependencies resolved!',
  );
  await runCommand(
    command: 'dart',
    args: [
      'run',
      'build_runner',
      'build',
      '-d',
    ],
    projectPath: projectPath,
    logger: logger,
    prefix: '🏭 ',
    startMessage: 'Running code generation.',
    completeMessage: 'Code generation complete!',
  );
  await runCommand(
    command: 'dart',
    args: [
      'fix',
      '--apply',
      '--code=directives_ordering',
    ],
    projectPath: projectPath,
    logger: logger,
    prefix: '🔧 ',
    startMessage: 'Applying fixes.',
    completeMessage: 'Fixes applied!',
  );
  await runCommand(
    command: 'dart',
    args: [
      'format',
      '.',
    ],
    projectPath: projectPath,
    logger: logger,
    prefix: '🪄  ',
    startMessage: 'Formatting code.',
    completeMessage: 'Code formatted!',
  );
}

Future<void> runCommand({
  required String command,
  required List<String> args,
  required String projectPath,
  required Logger logger,
  required String prefix,
  required String startMessage,
  required String completeMessage,
}) async {
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
  final process = await Process.start(
    command,
    args,
    workingDirectory: projectPath,
    runInShell: Platform.isWindows,
  );
  await Future.wait([
    process.stdout.forEach((_) {}), // Required to avoid halting
    // stdout.addStream(process.stdout), // Avoid verbose output
    stderr.addStream(process.stderr),
  ]);
  progressTimer.cancel();
  progress.complete('$prefix$completeMessage');
}
