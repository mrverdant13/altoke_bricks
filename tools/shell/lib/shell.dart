import 'dart:async';
import 'dart:io' hide stderr, stdin, stdout;

/// Shell utilities.
abstract class Shell {
  /// Copies a directory located at [source] to [destination].
  static Future<void> copyDirectory({
    required Directory source,
    required Directory destination,
    Stdin? stdin,
    Stdout? stdout,
    Stdout? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) {
    final fullCommand = () {
      if (Platform.isLinux || Platform.isMacOS) {
        return 'cp -r ${source.path} ${destination.path}';
      }
      if (Platform.isWindows) {
        // cspell: disable-next-line
        return 'cmd /c xcopy ${source.path} ${destination.path} /E /I /Y';
      }
    }();
    if (fullCommand == null) throw UnsupportedError('Unsupported platform');
    return run(
      fullCommand,
      stdin: stdin,
      stdout: stdout,
      stderr: stderr,
      onStart: onStart,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Removes a [directory].
  static Future<void> removeDirectory(
    Directory directory, {
    Stdin? stdin,
    Stdout? stdout,
    Stdout? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) {
    final fullCommand = () {
      if (Platform.isLinux || Platform.isMacOS) {
        return 'rm -rf ${directory.path}';
      }
      if (Platform.isWindows) {
        return 'cmd /c rmdir ${directory.path} /S /Q';
      }
    }();
    if (fullCommand == null) throw UnsupportedError('Unsupported platform');
    return run(
      fullCommand,
      stdin: stdin,
      stdout: stdout,
      stderr: stderr,
      onStart: onStart,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Runs a process by executing [fullCommand].
  static Future<void> run(
    String fullCommand, {
    String? workingDir,
    Stdin? stdin,
    Stdout? stdout,
    Stdout? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) async {
    final [executable, ...arguments] = fullCommand.split(' ');
    final process = await Process.start(
      executable,
      arguments,
      workingDirectory: workingDir,
      runInShell: true,
    );
    await onStart?.call();
    try {
      final outBuf = StringBuffer()..writeln();
      final [int exitCode, ...] = await [
        process.exitCode,
        process.stdout.forEach((raw) {
          final record = String.fromCharCodes(raw);
          outBuf.write('\x1B[34m$record\x1B[0m');
        }),
        process.stderr.forEach((raw) {
          final record = String.fromCharCodes(raw);
          outBuf.write('\x1B[31m$record\x1B[0m');
        }),
        if (stdin != null) process.stdin.addStream(stdin),
        if (stdout != null) stdout.addStream(process.stdout),
        if (stderr != null) stderr.addStream(process.stderr),
      ].wait;
      if (exitCode != 0) {
        throw ProcessException(
          '\x1B[31m$executable\x1B[0m',
          [for (final argument in arguments) '\x1B[31m$argument\x1B[0m'],
          outBuf.toString(),
          exitCode,
        );
      }
      await onSuccess?.call();
    } catch (error, stackTrace) {
      await onError?.call(ExceptionDetails(error, stackTrace));
      rethrow;
    }
  }
}

/// An async callback that does not return a value.
typedef AsyncVoidCallback = Future<void> Function();

/// An async callback that takes a parameter and does not return a value.
typedef AsyncVoidHandlerCallback<T> = Future<void> Function(T);

/// {@template shell.exception_details}
/// # Exception Details
/// {@endtemplate}
class ExceptionDetails {
  /// {@macro shell.exception_details}
  const ExceptionDetails(
    this.exception,
    this.stackTrace,
  );

  /// The exception.
  final Object exception;

  /// The stack trace.
  final StackTrace stackTrace;
}
