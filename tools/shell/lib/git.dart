import 'dart:io' hide stderr, stdin, stdout;

import 'package:shell/shell.dart';

/// Git utilities.
abstract class Git {
  /// Removes untracked files from the provided [directory].
  static Future<void> cleanDirectory(
    Directory directory, {
    Stdin? stdin,
    Stdout? stdout,
    Stdout? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) async {
    await Shell.run(
      'git clean -dfX ${directory.path}',
      stdin: stdin,
      stdout: stdout,
      stderr: stderr,
      onStart: onStart,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Checks if the provided [entity] is ignored.
  static Future<void> ignores(
    FileSystemEntity entity, {
    Stdin? stdin,
    Stdout? stdout,
    Stdout? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) async {
    await Shell.run(
      'git check-ignore ${entity.path}',
      stdin: stdin,
      stdout: stdout,
      stderr: stderr,
      onStart: onStart,
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}
