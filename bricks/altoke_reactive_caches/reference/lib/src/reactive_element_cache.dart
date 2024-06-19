import 'dart:async';

import 'package:altoke_common/common.dart';
import 'package:meta/meta.dart';

/// {@template reactive_caches.reactive_element_cache}
/// A reactive cache for a single element of type [E].
/// {@endtemplate}
class ReactiveElementCache<E extends Object> {
  /// {@macro reactive_caches.reactive_element_cache}
  ReactiveElementCache();

  /// The cached element.
  @visibleForTesting
  E? element;

  /// The stream controller for the cached element.
  @visibleForTesting
  StreamController<E?>? streamController;

  /// Performs side effects when the first listener is added to the stream.
  @visibleForTesting
  Future<void> onListen() async {
    streamController?.add(element);
  }

  /// Performs side effects when the last listener is removed from the stream.
  @visibleForTesting
  Future<void> onCancel() async {
    final controller = streamController;
    streamController = null;
    await controller?.close();
  }

  /// Caches the provided [element].
  ///
  /// If [element] is `null`, the cached element is cleared.
  void set(E? element) {
    this.element = element;
    streamController?.add(element);
  }

  /// Returns the cached element, or `null` if no element is cached.
  E? get() {
    return element;
  }

  /// Returns a stream of the cached element.
  Stream<E?> watch() {
    streamController ??= StreamController<E?>.broadcast(
      onListen: onListen,
      onCancel: onCancel,
    );
    return streamController!.stream.distinct();
  }

  /// Updates the cached element by applying the provided [update] callback.
  void update(UpdateCallback<E?> update) {
    element = update(element);
    streamController?.add(element);
  }
}
