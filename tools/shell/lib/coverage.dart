import 'dart:async';
import 'dart:io' hide stderr, stdin, stdout;

import 'package:shell/shell.dart';

/// Coverage utilities
abstract class Coverage {
  /// Formats coverage data as LCOV.
  static Future<void> formatAsLcov({
    required Directory input,
    required File output,
    required Directory reportOn,
    Stdin? stdin,
    StreamSink<List<int>>? stdout,
    StreamSink<List<int>>? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) async {
    await Shell.run(
      [
        'format_coverage',
        '--lcov',
        '--in=${input.path}',
        '--out=${output.path}',
        '--report-on=${reportOn.path}',
      ].join(' '),
      stdin: stdin,
      stdout: stdout,
      stderr: stderr,
      onStart: onStart,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Filters coverage data.
  static Future<void> filter({
    required File inputLcov,
    required File outputLcov,
    required List<String> filters,
    Stdin? stdin,
    StreamSink<List<int>>? stdout,
    StreamSink<List<int>>? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) async {
    await Shell.run(
      [
        'coverde filter',
        '--input ${inputLcov.path}',
        '--output ${outputLcov.path}',
        '--filters ${filters.join(',')}',
      ].join(' '),
      stdin: stdin,
      stdout: stdout,
      stderr: stderr,
      onStart: onStart,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Checks coverage.
  static Future<void> check({
    required File inputLcov,
    required int threshold,
    Stdin? stdin,
    StreamSink<List<int>>? stdout,
    StreamSink<List<int>>? stderr,
    AsyncVoidCallback? onStart,
    AsyncVoidCallback? onSuccess,
    AsyncVoidHandlerCallback<ExceptionDetails>? onError,
  }) async {
    await Shell.run(
      'coverde check -i ${inputLcov.path} $threshold',
      stdin: stdin,
      stdout: stdout,
      stderr: stderr,
      onStart: onStart,
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}
