import 'dart:async';
import 'dart:io';

import 'package:data_persistence_approach/data_persistence_approach.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:pubspec_deps_sorter/pubspec_deps_sorter.dart';
import 'package:shell/dart.dart';
import 'package:shell/shell.dart';

Future<void> run(HookContext context) async {
  final selectedApproach = DataPersistenceApproach.getSelectedApproach(context);
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

  Future<void> runCommands({
    required Directory projectDir,
    String? codeGenerationCommand,
  }) async {
    sortPubspecDependencies(projectDir.path);
    await Dart.getPackages(
      projectDir,
      onStart: onStart('📦 Installing dependencies'),
      onSuccess: onSuccess('📦 Dependencies installed!'),
      onError: onError('📦 Failed to install dependencies'),
    );
    if (codeGenerationCommand != null) {
      await Shell.run(
        codeGenerationCommand,
        workingDir: projectDir.path,
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

  final umbrellaPath = path.join(
    Directory.current.path,
    '${(context.vars['objects'] as String).snakeCase}_storage',
  );
  final interfaceProjectPath = path.join(
    umbrellaPath,
    '${(context.vars['objects'] as String).snakeCase}_storage',
  );
  await runCommands(
    projectDir: Directory(interfaceProjectPath),
  );
  final implementationProjectPath = path.join(
    umbrellaPath,
    '''${(context.vars['objects'] as String).snakeCase}_${selectedApproach.varIdentifier}_storage''',
  );
  await runCommands(
    projectDir: Directory(implementationProjectPath),
    codeGenerationCommand: selectedApproach.codeGenerationCommand,
  );
}
