import 'dart:async';

import 'package:meta/meta.dart';

/// An extension on [Stream] that allows to listen to the stream and
/// immediately emit the valid latest value.
extension ImmediateFirerPromotableStream<T> on Stream<T> {
  /// Allows to listen to the stream and immediately emit the latest value.
  Stream<T> asImmediateFirer() {
    return ImmediateFirerStream(this);
  }
}

/// {@template {{#requirements_met}}reactive_caches{{/requirements_met}}.immediate_firer_stream}
/// A stream that immediately emits the latest value of the [source] stream.
/// {@endtemplate}
class ImmediateFirerStream<T> extends Stream<T> {
  /// {@macro {{#requirements_met}}reactive_caches{{/requirements_met}}.immediate_firer_stream}
  ImmediateFirerStream(this.source);

  /// The source stream.
  @visibleForTesting
  final Stream<T> source;

  /// Whether the [source] is done.
  @visibleForTesting
  bool sourceIsDone = false;

  /// The latest valid value of the source stream.
  @visibleForTesting
  T? latestValue;

  /// The current listeners of the stream.
  @visibleForTesting
  final currentListeners = <MultiStreamController<T>>{};

  /// The underlying subscription to the [source].
  @visibleForTesting
  StreamSubscription<T>? sourceSubscription;

  @override
  bool get isBroadcast => source.isBroadcast;

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
    if (latestValue is T) controller.addSync(latestValue as T);
    controller.onCancel = () {
      currentListeners.remove(controller);
      if (currentListeners.isEmpty) {
        sourceSubscription?.cancel();
        sourceSubscription = null;
      }
    };
  }, isBroadcast: source.isBroadcast);

  /// Handles the data event from the source stream.
  void onSourceData(T event) {
    latestValue = event;
    if (latestValue is! T) return;
    for (final listener in [...currentListeners]) {
      listener.addSync(latestValue as T);
    }
  }

  /// Handles the error event from the source stream.
  void onSourceError(Object error, StackTrace stack) {
    for (final listener in [...currentListeners]) {
      listener.addErrorSync(error, stack);
    }
  }

  /// Handles the done event from the source stream.
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
  StreamSubscription<T>? listenToSource({bool? cancelOnError}) {
    if (sourceIsDone) return null;
    return sourceSubscription ??= source.listen(
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
