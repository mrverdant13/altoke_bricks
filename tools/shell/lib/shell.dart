import 'dart:io';

/// Shell utilities.
class Shell {
  /// Removes untracked files from the provided [directory].
  static Future<void> gitCleanDirectory(
    Directory directory,
  ) async {
    final result = await run('git clean -dfX ${directory.path}');
    if (result.exitCode != 0) {
      throw Exception('Failed to git-clean directory: ${directory.path}');
    }
  }

  /// Copies a directory located at [source] to [destination].
  static Future<void> copyDirectory({
    required Directory source,
    required Directory destination,
  }) {
    if (Platform.isLinux || Platform.isMacOS) {
      return run('cp -r ${source.path} ${destination.path}');
    }
    if (Platform.isWindows) {
      // cspell: disable-next-line
      return run('cmd /c xcopy ${source.path} ${destination.path} /E /I /Y');
    }
    throw UnsupportedError('Unsupported platform');
  }

  /// Removes a [directory].
  static Future<void> removeDirectory(
    Directory directory,
  ) {
    if (Platform.isLinux || Platform.isMacOS) {
      return run('rm -rf ${directory.path}');
    }
    if (Platform.isWindows) {
      return run('cmd /c rmdir ${directory.path} /S /Q');
    }
    throw UnsupportedError('Unsupported platform');
  }

  /// Runs a process by executing [fullCommand].
  static Future<ProcessResult> run(
    String fullCommand, {
    bool throwOnError = true,
    String? workingDir,
  }) async {
    final [command, ...arguments] = fullCommand.split(' ');
    final result = await Process.run(
      command,
      arguments,
      workingDirectory: workingDir,
      runInShell: true,
    );
    if (throwOnError) _throwIfProcessFailed(result, command, arguments);
    return result;
  }

  /// Throws a [ProcessException] if the [result] failed.
  ///
  /// The [command] and [arguments] are used to give context to the exception.
  static void _throwIfProcessFailed(
    ProcessResult result,
    String command,
    List<String> arguments,
  ) {
    if (result.exitCode != 0) {
      final values = {
        'Standard out': result.stdout.toString().trim(),
        'Standard error': result.stderr.toString().trim(),
      }..removeWhere((k, v) => v.isEmpty);
      final message = switch (values) {
        final Map<String, String> m when m.isEmpty => 'Unknown error',
        final Map<String, String> m when m.length == 1 => m.values.single,
        final Map<String, String> m =>
          m.entries.map((e) => '${e.key}\n${e.value}').join('\n'),
      };
      throw ProcessException(command, arguments, message, result.exitCode);
    }
  }
}
