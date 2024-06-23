import 'dart:io' hide stderr, stdin, stdout;

import 'package:shell/shell.dart';

/// Melos utilities.
abstract class Melos {
  /// Bootstraps the project.
  static Future<void> bootstrap(
    Directory directory, {
    Stdin? stdin,
    Stdout? stdout,
    Stdout? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) async {
    await Shell.run(
      'melos bootstrap',
      workingDir: directory.path,
      stdin: stdin,
      stdout: stdout,
      stderr: stderr,
      onStart: onStart,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Runs a script.
  static Future<void> runScript(
    Directory directory,
    String script, {
    Stdin? stdin,
    Stdout? stdout,
    Stdout? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) async {
    await Shell.run(
      'melos run $script',
      workingDir: directory.path,
      stdin: stdin,
      stdout: stdout,
      stderr: stderr,
      onStart: onStart,
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}
