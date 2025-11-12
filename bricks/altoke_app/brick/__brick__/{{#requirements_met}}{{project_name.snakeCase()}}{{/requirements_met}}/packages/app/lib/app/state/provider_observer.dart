import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

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
    ProviderObserverContext context,
    Object? value,
  ) {
    final message =
        '''
${DateTime.now()}
Provider added
Initial:  $value
'''
            .trim();
    log(message, name: context.provider.loggerName);
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
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
      name: context.provider.loggerName,
    );
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    final message =
        '''
${DateTime.now()}
Provider updated
Previous: $previousValue
New:      $newValue
'''
            .trim();
    log(message, name: context.provider.loggerName);
  }

  @override
  void didDisposeProvider(
    ProviderObserverContext context,
  ) {
    final message =
        '''
${DateTime.now()}
Provider disposed
'''
            .trim();
    log(message, name: context.provider.loggerName);
  }

  @override
  void mutationReset(
    ProviderObserverContext context,
    Mutation<Object?> mutation,
  ) {
    final message =
        '''
${DateTime.now()}
Mutation reset
'''
            .trim();
    log(message, name: mutation.loggerName);
  }

  @override
  void mutationStart(
    ProviderObserverContext context,
    Mutation<Object?> mutation,
  ) {
    final message =
        '''
${DateTime.now()}
Mutation started
'''
            .trim();
    log(message, name: mutation.loggerName);
  }

  @override
  void mutationError(
    ProviderObserverContext context,
    Mutation<Object?> mutation,
    Object error,
    StackTrace stackTrace,
  ) {
    final message =
        '''
${DateTime.now()}
Mutation error
'''
            .trim();
    log(
      message,
      error: error,
      stackTrace: stackTrace,
      name: mutation.loggerName,
    );
  }

  @override
  void mutationSuccess(
    ProviderObserverContext context,
    Mutation<Object?> mutation,
    Object? result,
  ) {
    final message =
        '''
${DateTime.now()}
Mutation success
'''
            .trim();
    log(message, name: mutation.loggerName);
  }
}

extension on ProviderBase<dynamic> {
  String get loggerName => name ?? runtimeType.toString();
}

extension on Mutation<dynamic> {
  String get loggerName => label?.toString() ?? runtimeType.toString();
}

// coverage:ignore-end
