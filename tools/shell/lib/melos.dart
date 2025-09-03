import 'dart:async';
import 'dart:io' hide stderr, stdin, stdout;

import 'package:shell/shell.dart';

/// Melos utilities.
abstract class Melos {
  /// Bootstraps the project.
  static Future<void> bootstrap(
    Directory directory, {
    Stdin? stdin,
    StreamSink<List<int>>? stdout,
    StreamSink<List<int>>? stderr,
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
      environment: Platform.environment.withoutMelosReferences,
      includeParentEnvironment: false,
    );
  }

  /// Runs a script.
  static Future<void> runScript(
    Directory directory,
    String script, {
    Stdin? stdin,
    StreamSink<List<int>>? stdout,
    StreamSink<List<int>>? stderr,
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
      environment: Platform.environment.withoutMelosReferences,
      includeParentEnvironment: false,
    );
  }
}

extension on Map<String, String> {
  /// Returns a new map with all the keys that contain 'MELOS' removed.
  ///
  /// This is useful when you want to run a melos command within a process
  /// that already has been already created with melos.
  Map<String, String> get withoutMelosReferences {
    return {
      for (final MapEntry(:key, :value) in entries)
        if (!key.contains('MELOS')) key: value,
    };
  }
}
