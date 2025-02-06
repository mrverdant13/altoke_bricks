import 'dart:async';

/// A stream that immediately emits the latest value of the source stream.
extension LatestValueEmittingStream<T> on Stream<T> {
  /// Allows to listen to the stream and immediately emit the latest value.
  Stream<T> emitImmediately() {
    var done = false;
    T? latest;
    final currentListeners = <MultiStreamController<T>>{};
    late StreamSubscription<T>? subscription;
    subscription = listen(
      (event) async {
        latest = event;
        for (final listener in currentListeners) {
          listener.addSync(latest as T);
        }
      },
      onError: (Object error, StackTrace stack) async {
        for (final listener in currentListeners) {
          listener.addErrorSync(error, stack);
        }
      },
      onDone: () async {
        done = true;
        for (final listener in currentListeners) {
          listener.closeSync();
        }
        currentListeners.clear();
        await subscription?.cancel();
        subscription = null;
      },
    );
    return Stream.multi(
      (controller) async {
        if (done) {
          await controller.close();
          if (currentListeners.isEmpty) {
            await subscription?.cancel();
            subscription = null;
          }
          return;
        }
        currentListeners.add(controller);
        controller
          ..add(latest as T)
          ..onCancel = () {
            currentListeners.remove(controller);
            if (currentListeners.isEmpty) {
              subscription?.cancel();
              subscription = null;
            }
          };
      },
      isBroadcast: isBroadcast,
    );
  }
}
