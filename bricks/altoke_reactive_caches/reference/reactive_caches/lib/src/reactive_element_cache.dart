import 'dart:async';

import 'package:altoke_common/common.dart';
import 'package:altoke_reactive_caches/reactive_caches.dart';
import 'package:altoke_reactive_caches/src/immediate_firer_stream.dart';
import 'package:meta/meta.dart';

/// {@template reactive_caches.reactive_element_cache}
/// A reactive cache for a single element of type [E].
/// {@endtemplate}
class ReactiveElementCache<E extends Object> {
  /// {@macro reactive_caches.reactive_element_cache}
  ///
  /// If [equalityChecker] is `null`, the [defaultEqualityChecker] is used.
  ReactiveElementCache({ElementEqualityChecker<E?>? equalityChecker})
    : equalityChecker = equalityChecker ?? defaultEqualityChecker;

  /// The default equality checker for an element of type [E].
  @visibleForTesting
  static bool defaultEqualityChecker<E extends Object?>(E a, E b) => a == b;

  /// The equality checker for the cached element.
  @visibleForTesting
  final ElementEqualityChecker<E?> equalityChecker;

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
      sync: true,
    );
    return streamController!.stream
        .distinct(equalityChecker)
        .asImmediateFirer();
  }

  /// Updates the cached element by applying the provided [update] callback.
  void update(UpdateCallback<E?> update) {
    element = update(element);
    streamController?.add(element);
  }
}
