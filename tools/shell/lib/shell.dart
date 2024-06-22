import 'dart:io';

/// Shell utilities.
class Shell {
  /// Removes untracked files from the provided [directory].
  static Future<void> gitCleanDirectory(
    Directory directory,
  ) async {
    await run('git clean -dfX ${directory.path}');
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

  /// Formats Dart files in the provided [directory].
  static Future<void> dartFormat(
    Directory directory, {
    bool failOnChanges = false,
  }) async {
    await run(
      [
        'dart format',
        if (failOnChanges) '--set-exit-if-changed',
        '.',
      ].join(' '),
      workingDir: directory.path,
    );
  }

  /// Analyzes Dart files in the provided [directory].
  static Future<void> dartAnalyze(
    Directory directory, {
    bool fatalInfos = false,
    bool fatalWarnings = false,
  }) async {
    await run(
      [
        'dart analyze',
        if (fatalInfos) '--fatal-infos',
        if (fatalWarnings) '--fatal-warnings',
        '.',
      ].join(' '),
      workingDir: directory.path,
    );
  }

  /// Runs tests in the provided [directory].
  static Future<void> dartTest(
    Directory directory, {
    Directory? coverageDirectory,
  }) async {
    await run(
      [
        'dart test',
        if (coverageDirectory != null) '--coverage=${coverageDirectory.path}',
        '-r expanded',
        '--test-randomize-ordering-seed random',
      ].join(' '),
      workingDir: directory.path,
    );
  }

  /// Formats coverage data.
  static Future<void> formatCoverageAsLcov({
    required Directory input,
    required File output,
    required Directory reportOn,
  }) async {
    await run(
      [
        'format_coverage',
        '--lcov',
        '--in=${input.path}',
        '--out=${output.path}',
        '--report-on=${reportOn.path}',
      ].join(' '),
    );
  }

  /// Filters coverage data.
  static Future<void> filterCoverage({
    required File inputLcov,
    required File outputLcov,
    required List<String> filters,
  }) async {
    await run(
      [
        'coverde filter',
        '--input ${inputLcov.path}',
        '--output ${outputLcov.path}',
        '--filters ${filters.join(',')}',
      ].join(' '),
    );
  }

  /// Checks coverage.
  static Future<void> checkCoverage({
    required File inputLcov,
    required int threshold,
  }) async {
    await run(
      'coverde check -i ${inputLcov.path} $threshold',
    );
  }

  /// Runs a process by executing [fullCommand].
  static Future<void> run(
    String fullCommand, {
    String? workingDir,
    Stdin? stdin,
  }) async {
    final [executable, ...arguments] = fullCommand.split(' ');
    final process = await Process.start(
      executable,
      arguments,
      workingDirectory: workingDir,
      runInShell: true,
    );
    final outBuf = StringBuffer()..writeln();
    final (_, _, _, exitCode) = await (
      process.stdout.forEach((raw) {
        final record = String.fromCharCodes(raw);
        outBuf.write('\x1B[34m$record\x1B[0m');
      }),
      process.stderr.forEach((raw) {
        final record = String.fromCharCodes(raw);
        outBuf.write('\x1B[31m$record\x1B[0m');
      }),
      stdin != null ? process.stdin.addStream(stdin) : Future<void>.value(),
      process.exitCode,
    ).wait;
    if (exitCode != 0) {
      throw ProcessException(
        '\x1B[31m$executable\x1B[0m',
        [for (final argument in arguments) '\x1B[31m$argument\x1B[0m'],
        outBuf.toString(),
        exitCode,
      );
    }
  }
}
