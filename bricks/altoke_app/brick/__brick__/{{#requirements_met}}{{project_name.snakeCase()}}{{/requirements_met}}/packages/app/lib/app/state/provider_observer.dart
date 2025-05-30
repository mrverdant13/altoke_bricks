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
    developer.log(message, name: name, error: error, stackTrace: stackTrace);
  }

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    final message =
        '''
${DateTime.now()}
Provider added
Initial:  $value
'''
            .trim();
    log(message, name: provider.loggerName);
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    final message =
        '''
${DateTime.now()}
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
    final message =
        '''
${DateTime.now()}
Provider updated
Previous: $previousValue
New:      $newValue
'''
            .trim();
    log(message, name: provider.loggerName);
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    final message =
        '''
${DateTime.now()}
Provider disposed
'''
            .trim();
    log(message, name: provider.loggerName);
  }
}

extension on ProviderBase<Object?> {
  String get loggerName => name ?? runtimeType.toString();
}

// coverage:ignore-end
