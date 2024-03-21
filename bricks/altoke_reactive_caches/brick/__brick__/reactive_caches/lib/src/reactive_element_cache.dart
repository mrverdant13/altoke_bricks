import 'package:common/common.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

/// {@template reactive_caches.reactive_element_cache}
/// A reactive cache for a single element of type [E].
/// {@endtemplate}
class ReactiveElementCache<E extends Object> {
  /// {@macro reactive_caches.reactive_element_cache}
  ReactiveElementCache();

  /// The stream controller for the cached element.
  @visibleForTesting
  final BehaviorSubject<E?> streamController = BehaviorSubject.seeded(null);

  /// Caches the provided [element].
  ///
  /// If [element] is `null`, the cached element is cleared.
  void set(E? element) {
    streamController.add(element);
  }

  /// Returns the cached element, or `null` if no element is cached.
  E? get() {
    return streamController.value;
  }

  /// Returns a stream of the cached element.
  Stream<E?> watch() {
    return streamController.stream.distinct();
  }

  /// Updates the cached element by applying the provided [update] callback.
  void update(UpdateCallback<E?> update) {
    final currentElement = streamController.value;
    streamController.add(update(currentElement));
  }

  /// Clears the cached element and frees resources.
  Future<void> dispose() async {
    streamController.add(null);
    await streamController.close();
  }
}
