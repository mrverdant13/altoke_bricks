import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

class Shell {
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

  static Future<void> renameDirectory({
    required Directory directory,
    required String newName,
  }) async {
    await copyDirectory(
      source: directory,
      destination: Directory(path.joinAll([directory.parent.path, newName])),
    );
    await removeDirectory(directory);
  }

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

  @visibleForTesting
  static void throwIfProcessFailed(
    ProcessResult pr,
    String process,
    List<String> args,
  ) {
    if (pr.exitCode != 0) {
      final values = {
        'Standard out': pr.stdout.toString().trim(),
        'Standard error': pr.stderr.toString().trim()
      }..removeWhere((k, v) => v.isEmpty);
      final message = switch (values) {
        Map<String, String> m when m.isEmpty => 'Unknown error',
        Map<String, String> m when m.length == 1 => m.values.single,
        Map<String, String> m =>
          m.entries.map((e) => '${e.key}\n${e.value}').join('\n'),
      };
      throw ProcessException(process, args, message, pr.exitCode);
    }
  }
}
