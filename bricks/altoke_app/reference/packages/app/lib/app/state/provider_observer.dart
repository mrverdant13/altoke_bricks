import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// coverage:ignore-start
class LoggerProviderObserver extends ProviderObserver {
  const LoggerProviderObserver();

  void log(
    String message, {
    required String name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode) return;
    switch (kIsWeb) {
      case true:
        // HACK: Avoid logging issues on web.
        // Using this logging approach as the `log` function has an
        // unexpected behavior on web.
        // Reference: https://github.com/flutter/flutter/issues/47913
        final lines = LineSplitter.split(message);
        final resultingLines = lines.map((line) => '$name: $line');
        final resultingMessage = resultingLines.join('\n');
        debugPrint(resultingMessage);
      case false:
        developer.log(
          message,
          name: name,
          error: error,
          stackTrace: stackTrace,
        );
    }
  }

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    final message = '''
Provider added
$value
'''
        .trim();
    log(
      message,
      name: provider.loggerName,
    );
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    final message = '''
Provider failed
$error
'''
        .trim();
    log(
      message,
      error: error,
      stackTrace: stackTrace,
      name: provider.loggerName,
    );
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    final message = '''
Provider updated
Previous: $previousValue
New: $newValue
'''
        .trim();
    log(
      message,
      name: provider.loggerName,
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    final message = '''
Provider disposed
'''
        .trim();
    log(
      message,
      name: provider.loggerName,
    );
  }
}

extension on ProviderBase<Object?> {
  String get loggerName => name ?? runtimeType.toString();
}
// coverage:ignore-end
