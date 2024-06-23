import 'dart:async';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:shell/dart.dart';
import 'package:shell/melos.dart';
import 'package:shell/shell.dart';

Future<void> run(HookContext context) async {
  final projectPath = path.join(
    Directory.current.path,
    context.vars['projectName'] as String,
  );
  final projectDir = Directory(projectPath);
  final appPath = path.joinAll([projectPath, 'packages', 'app']);
  final appDir = Directory(appPath);
  final logger = context.logger;
  Progress? progress;
  Timer? progressTimer;

  AsyncVoidCallback onStart(String message) {
    return () async {
      progress = logger.progress(message);
      progressTimer = Timer.periodic(
        const Duration(milliseconds: 100),
        (timer) {
          progress?.update(message);
        },
      );
    };
  }

  AsyncVoidCallback onSuccess(String message) {
    return () async {
      progressTimer?.cancel();
      progress?.complete(message);
    };
  }

  AsyncVoidHandlerCallback<ExceptionDetails> onError(String message) {
    return (details) async {
      progressTimer?.cancel();
      progress?.fail(message);
      logger
        ..err(details.exception.toString())
        ..err(details.stackTrace.toString());
    };
  }

  await Melos.bootstrap(
    projectDir,
    onStart: onStart('📦 Installing dependencies'),
    onSuccess: onSuccess('📦 Dependencies installed!'),
    onError: onError('📦 Failed to install dependencies'),
  );
  await Melos.runScript(
    projectDir,
    'gen.all.fast',
    onStart: onStart('🏭 Running code generation'),
    onSuccess: onSuccess('🏭 Code generation complete!'),
    onError: onError('🏭 Failed to run code generation'),
  );

  // HACK: Avoid undesired results when globally applying fixes.
  // Applying fixes to the root results in unwanted changes on some
  // `pubspec.yaml` files.
  // This can be simplified in a single execution when the issue is resolved.
  await Dart.applyFixes(
    Directory(path.join(appPath, 'lib')),
    codes: ['directives_ordering'],
    onStart: onStart('🔧 Applying fixes'),
    onSuccess: onSuccess('🔧 Fixes applied!'),
    onError: onError('🔧 Failed to apply fixes'),
  );
  await Dart.applyFixes(
    Directory(path.join(appPath, 'test')),
    codes: ['directives_ordering'],
    onStart: onStart('🔧 Applying fixes'),
    onSuccess: onSuccess('🔧 Fixes applied!'),
    onError: onError('🔧 Failed to apply fixes'),
  );

  await Melos.runScript(
    appDir,
    'format.all',
    onStart: onStart('🪄 Formatting code'),
    onSuccess: onSuccess('🪄 Code formatted!'),
    onError: onError('🪄 Failed to format code'),
  );
}
