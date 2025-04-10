import 'dart:async';

import 'package:common/common.dart';
import 'package:meta/meta.dart';

/// {@template {{#requirements_met}}reactive_caches{{/requirements_met}}.immediate_firer_stream}
/// A stream that immediately emits the computed initial value.
/// {@endtemplate}
class ImmediateFirerStream<T extends Object?> extends StreamView<T> {
  /// {@macro {{#requirements_met}}reactive_caches{{/requirements_met}}.immediate_firer_stream}
  ImmediateFirerStream(super.source, {required this.computeInitialValue});

  /// Whether the wrapped stream is done.
  @visibleForTesting
  bool sourceIsDone = false;

  /// A callback that computes the initial value of the stream.
  @visibleForTesting
  final Optional<T> Function() computeInitialValue;

  /// The current listeners of the stream.
  @visibleForTesting
  final currentListeners = <MultiStreamController<T>>{};

  /// The underlying subscription.
  @visibleForTesting
  StreamSubscription<T>? sourceSubscription;

  /// The multi-subscription stream.
  @visibleForTesting
  late final multiStream = Stream<T>.multi((controller) async {
    if (sourceIsDone) {
      controller.closeSync();
      if (currentListeners.isEmpty) {
        await sourceSubscription?.cancel();
        sourceSubscription = null;
      }
      return;
    }
    currentListeners.add(controller);
    final initialValue = computeInitialValue();
    if (initialValue case Some(:final value)) controller.addSync(value);
    controller.onCancel = () {
      currentListeners.remove(controller);
      if (currentListeners.isEmpty) {
        sourceSubscription?.cancel();
        sourceSubscription = null;
      }
    };
  }, isBroadcast: isBroadcast);

  /// Handles the data event from the source stream.
  @visibleForTesting
  void onSourceData(T event) {
    for (final listener in [...currentListeners]) {
      listener.addSync(event);
    }
  }

  /// Handles the error event from the source stream.
  @visibleForTesting
  void onSourceError(Object error, StackTrace stack) {
    for (final listener in [...currentListeners]) {
      listener.addErrorSync(error, stack);
    }
  }

  /// Handles the done event from the source stream.
  @visibleForTesting
  Future<void> onSourceDone() async {
    sourceIsDone = true;
    for (final listener in [...currentListeners]) {
      listener.closeSync();
    }
    currentListeners.clear();
    await sourceSubscription?.cancel();
    sourceSubscription = null;
  }

  /// Listens to the source stream.
  @visibleForTesting
  StreamSubscription<T>? listenToSource({bool? cancelOnError}) {
    if (sourceIsDone) return null;
    return sourceSubscription ??= super.listen(
      onSourceData,
      onError: onSourceError,
      onDone: onSourceDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  StreamSubscription<T> listen(
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    listenToSource(cancelOnError: cancelOnError);
    return multiStream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}
