import 'dart:io';

import 'package:meta/meta.dart';

/// Shell utilities.
class Shell {
  /// Copies a directory located at [source] to [destination].
  static Future<void> copyDirectory({
    required Directory source,
    required Directory destination,
  }) {
    if (Platform.isLinux || Platform.isMacOS) {
      return run('cp', [
        '-r',
        source.path,
        destination.path,
      ]);
    }
    if (Platform.isWindows) {
      return run('cmd', [
        '/c',
        'xcopy',
        source.path,
        destination.path,
        '/E',
        '/I',
        '/Y',
      ]);
    }
    throw UnsupportedError('Unsupported platform');
  }

  /// Removes a [directory].
  static Future<void> removeDirectory(
    Directory directory,
  ) {
    if (Platform.isLinux || Platform.isMacOS) {
      return run('rm', [
        '-rf',
        directory.path,
      ]);
    }
    if (Platform.isWindows) {
      return run('cmd', [
        '/c',
        'rmdir',
        directory.path,
        '/S',
        '/Q',
      ]);
    }
    throw UnsupportedError('Unsupported platform');
  }

  /// Runs a process by executing [cmd] with [args].
  @visibleForTesting
  static Future<ProcessResult> run(
    String cmd,
    List<String> args, {
    bool throwOnError = true,
    String? processWorkingDir,
  }) async {
    final result = await Process.run(
      cmd,
      args,
      workingDirectory: processWorkingDir,
      runInShell: true,
    );
    if (throwOnError) throwIfProcessFailed(result, cmd, args);
    return result;
  }

  /// Throws a [ProcessException] if the [pr] failed.
  ///
  /// The [process] and [args] are used to give context to the exception.
  @visibleForTesting
  static void throwIfProcessFailed(
    ProcessResult pr,
    String process,
    List<String> args,
  ) {
    if (pr.exitCode != 0) {
      final values = {
        'Standard out': pr.stdout.toString().trim(),
        'Standard error': pr.stderr.toString().trim(),
      }..removeWhere((k, v) => v.isEmpty);
      final message = switch (values) {
        final Map<String, String> m when m.isEmpty => 'Unknown error',
        final Map<String, String> m when m.length == 1 => m.values.single,
        final Map<String, String> m =>
          m.entries.map((e) => '${e.key}\n${e.value}').join('\n'),
      };
      throw ProcessException(process, args, message, pr.exitCode);
    }
  }
}
