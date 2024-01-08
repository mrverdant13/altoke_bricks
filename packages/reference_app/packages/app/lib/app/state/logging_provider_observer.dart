import 'dart:convert';
import 'dart:developer';

import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/tasks.dart';

class LoggingPodsObserver implements ProviderObserver {
  static final jsonDecoder = JsonEncoder.withIndent(
    '  ',
    (object) => object.toString(),
  );

  static String? resolveStringifiedArgs({
    required ProviderBase<Object?> provider,
    required ProviderContainer container,
  }) {
    Object? resolveArgs() {
      if (provider is AsyncPaginatedFilteredTasksProvider) {
        final statusFilter = container.read(selectedTasksStatusFilterPod);
        final searchTerm = container.read(taskSearchTermPod);
        return {
          'statusFilter': statusFilter,
          'searchTerm': searchTerm,
          'offset': provider.offset,
          'limit': provider.limit,
        };
      } else if (provider == asyncFilteredTasksCountPod) {
        final statusFilter = container.read(selectedTasksStatusFilterPod);
        final searchTerm = container.read(taskSearchTermPod);
        return {
          'statusFilter': statusFilter,
          'searchTerm': searchTerm,
        };
      } else if (provider is TaskEditorProvider) {
        return {
          'taskId': provider.taskId,
        };
      } else {
        return provider.argument;
      }
    }

    final args = resolveArgs();
    if (args == null) return null;
    if (args is String) return '<$args>';
    if (args is Map) return jsonDecoder.convert(args);
    return args.toString();
  }

  static String? resolveStringifiedValue({
    required ProviderBase<Object?> provider,
    required Object? value,
  }) {
    Object? resolveValue() {
      if (value == null) return null;
      if (provider is AsyncPaginatedFilteredTasksProvider) {
        value as AsyncValue<List<Task>>;
        return value.whenData((tasks) => tasks.length);
      }
      return value;
    }

    final resolvedValue = resolveValue();
    if (resolvedValue == null) return null;
    if (resolvedValue is String) return '<$resolvedValue>';
    if (resolvedValue is Map) return jsonDecoder.convert(resolvedValue);
    return resolvedValue.toString();
  }

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (provider.shouldBeIgnored) return;
    final buf = StringBuffer()..writeln(provider.loggingName);
    final stringifiedArgs = resolveStringifiedArgs(
      provider: provider,
      container: container,
    );
    if (stringifiedArgs != null) {
      buf
        ..write('Arguments: ')
        ..writeln(stringifiedArgs);
    }
    final stringifiedValue = resolveStringifiedValue(
      provider: provider,
      value: value,
    );
    buf
      ..write('🔶: ')
      ..write(stringifiedValue ?? '❌');
    log(buf.toString());
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    if (provider.shouldBeIgnored) return;
    final buf = StringBuffer()
      ..writeln(provider.loggingName)
      ..writeln('💀');
    final stringifiedArgs = resolveStringifiedArgs(
      provider: provider,
      container: container,
    );
    if (stringifiedArgs != null) {
      buf
        ..write('Arguments: ')
        ..writeln(stringifiedArgs);
    }
    log(buf.toString());
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (provider.shouldBeIgnored) return;
    final buf = StringBuffer()..writeln(provider.loggingName);
    final stringifiedArgs = resolveStringifiedArgs(
      provider: provider,
      container: container,
    );
    if (stringifiedArgs != null) {
      buf
        ..write('Arguments: ')
        ..writeln(stringifiedArgs);
    }
    final stringifiedPreviousValue = resolveStringifiedValue(
      provider: provider,
      value: previousValue,
    );
    final stringifiedNewValue = resolveStringifiedValue(
      provider: provider,
      value: newValue,
    );
    buf
      ..write('🔹: ')
      ..writeln(stringifiedPreviousValue ?? '❌')
      ..write('🔷: ')
      ..writeln(stringifiedNewValue ?? '❌');
    log(buf.toString());
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    if (provider.shouldBeIgnored) return;
    final buf = StringBuffer()
      ..writeln(provider.loggingName)
      ..writeln('❌');
    final stringifiedArgs = resolveStringifiedArgs(
      provider: provider,
      container: container,
    );
    if (stringifiedArgs != null) {
      buf
        ..write('Arguments: ')
        ..writeln(stringifiedArgs);
    }
    log(
      buf.toString(),
      error: error,
      stackTrace: stackTrace,
    );
  }
}

extension on ProviderBase<dynamic> {
  String get loggingName => name ?? runtimeType.toString();

  bool get shouldBeIgnored {
    if (!kDebugMode) return true; // Only log in debug mode.
    if (this == taskPod) return true; // Scoping pod only.
    return false;
  }
}
