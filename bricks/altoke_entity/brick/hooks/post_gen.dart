import 'dart:async';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:shell/dart.dart';
import 'package:shell/shell.dart';
import 'package:value_equality_approach/value_equality_approach.dart';

Future<void> run(HookContext context) async {
  if (context.vars['preconditions_met'] != true) return;
  final projectPath = path.join(
    Directory.current.path,
    (context.vars['entity_singular'] as String).snakeCase,
  );
  final projectDir = Directory(projectPath);
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

  await Dart.getPackages(
    projectDir,
    onStart: onStart('📦 Installing dependencies'),
    onSuccess: onSuccess('📦 Dependencies installed!'),
    onError: onError('📦 Failed to install dependencies'),
  );
  if (context.valueEqualityUsesCodeGeneration) {
    await Dart.generateCode(
      projectDir,
      onStart: onStart('🏭 Running code generation'),
      onSuccess: onSuccess('🏭 Code generation complete!'),
      onError: onError('🏭 Failed to run code generation'),
    );
  }
  await Dart.applyFixes(
    projectDir,
    codes: ['directives_ordering'],
    onStart: onStart('🔧 Applying fixes'),
    onSuccess: onSuccess('🔧 Fixes applied!'),
    onError: onError('🔧 Failed to apply fixes'),
  );
  await Dart.format(
    projectDir,
    onStart: onStart('🪄 Formatting code'),
    onSuccess: onSuccess('🪄 Code formatted!'),
    onError: onError('🪄 Failed to format code'),
  );
}
