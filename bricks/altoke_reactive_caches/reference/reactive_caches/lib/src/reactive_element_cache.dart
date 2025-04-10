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
    : equalityChecker = equalityChecker ?? defaultEqualityChecker {
    stream = ImmediateFirerStream<E?>(
      streamController.stream,
      computeInitialValue: () => Some(element),
    );
    streamSubscription = stream.listen((element) {
      this.element = element;
    });
  }

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
  final streamController = StreamController<E?>.broadcast(sync: true);

  /// The stream of the cached element.
  @visibleForTesting
  // late final stream = streamController.stream;
  late final Stream<E?> stream;

  /// The subscription to the stream of the cached element.
  @visibleForTesting
  late final StreamSubscription<E?> streamSubscription;

  /// Caches the provided [element].
  ///
  /// If [element] is `null`, the cached element is cleared.
  void set(E? element) {
    streamController.add(element);
  }

  /// Returns the cached element, or `null` if no element is cached.
  E? get() {
    return element;
  }

  /// Returns a stream of the cached element.
  Stream<E?> watch() {
    return stream.distinct(equalityChecker);
  }

  /// Updates the cached element by applying the provided [update] callback.
  void update(UpdateCallback<E?> update) {
    streamController.add(update(element));
  }

  /// Releases the resources used by the cache.
  Future<void> dispose() async {
    await streamSubscription.cancel();
    await streamController.close();
  }
}
