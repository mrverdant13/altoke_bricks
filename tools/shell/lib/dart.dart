import 'dart:async';
import 'dart:io' hide stderr, stdin, stdout;

import 'package:shell/shell.dart';

/// Dart utilities.
abstract class Dart {
  /// Adds packages to a project located in [directory].
  static Future<void> addPackages(
    Directory directory,
    List<String> packageDetails, {
    Stdin? stdin,
    Stdout? stdout,
    Stdout? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) async {
    await Shell.run(
      [
        'dart pub add',
        packageDetails.join(' '),
      ].join(' '),
      workingDir: directory.path,
      stdin: stdin,
      stdout: stdout,
      stderr: stderr,
      onStart: onStart,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Removes packages from a project located in [directory].
  static Future<void> removePackages(
    Directory directory,
    List<String> packageDetails, {
    Stdin? stdin,
    Stdout? stdout,
    Stdout? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) async {
    await Shell.run(
      [
        'dart pub remove',
        packageDetails.join(' '),
      ].join(' '),
      workingDir: directory.path,
      stdin: stdin,
      stdout: stdout,
      stderr: stderr,
      onStart: onStart,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Gets the packages for a project located in [directory].
  static Future<void> getPackages(
    Directory directory, {
    Stdin? stdin,
    Stdout? stdout,
    Stdout? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) async {
    await Shell.run(
      'dart pub get',
      workingDir: directory.path,
      stdin: stdin,
      stdout: stdout,
      stderr: stderr,
      onStart: onStart,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Executes code generation for a project located in [directory].
  static Future<void> generateCode(
    Directory directory, {
    bool deleteConflictingOutputs = true,
    Stdin? stdin,
    Stdout? stdout,
    Stdout? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) async {
    await Shell.run(
      [
        'dart run build_runner build',
        if (deleteConflictingOutputs) '--delete-conflicting-outputs',
      ].join(' '),
      workingDir: directory.path,
      stdin: stdin,
      stdout: stdout,
      stderr: stderr,
      onStart: onStart,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Fixes Dart files in the provided [entity].
  static Future<void> applyFixes(
    FileSystemEntity entity, {
    List<String> codes = const [],
    bool apply = true,
    Stdin? stdin,
    Stdout? stdout,
    Stdout? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) async {
    await Shell.run(
      [
        'dart fix',
        if (apply) '--apply',
        if (codes.isNotEmpty) '--code=${codes.join(',')}',
        entity.path,
      ].join(' '),
      stdin: stdin,
      stdout: stdout,
      stderr: stderr,
      onStart: onStart,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Formats Dart files in the provided [directory].
  static Future<void> format(
    Directory directory, {
    bool failIfChanged = false,
    Stdin? stdin,
    Stdout? stdout,
    Stdout? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) async {
    await Shell.run(
      [
        'dart format',
        if (failIfChanged) '--set-exit-if-changed',
        '.',
      ].join(' '),
      workingDir: directory.path,
      stdin: stdin,
      stdout: stdout,
      stderr: stderr,
      onStart: onStart,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Analyzes Dart files in the provided [directory].
  static Future<void> analyze(
    Directory directory, {
    bool fatalInfos = false,
    bool fatalWarnings = false,
    Stdin? stdin,
    Stdout? stdout,
    Stdout? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) async {
    await Shell.run(
      [
        'dart analyze',
        if (fatalInfos) '--fatal-infos',
        if (fatalWarnings) '--fatal-warnings',
        '.',
      ].join(' '),
      workingDir: directory.path,
      stdin: stdin,
      stdout: stdout,
      stderr: stderr,
      onStart: onStart,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Runs tests in the provided [directory].
  static Future<void> test(
    Directory directory, {
    Directory? coverageDirectory,
    Stdin? stdin,
    Stdout? stdout,
    Stdout? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) async {
    await Shell.run(
      [
        'dart test',
        if (coverageDirectory != null) '--coverage=${coverageDirectory.path}',
        '-r expanded',
        '--test-randomize-ordering-seed random',
      ].join(' '),
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
