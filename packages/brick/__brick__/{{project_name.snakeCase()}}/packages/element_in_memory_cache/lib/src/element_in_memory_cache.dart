import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

/// {@template element_in_memory_cache}
/// An in-memory cache for a single element.
/// {@endtemplate}
class ElementInMemoryCache<T extends Object> {
  /// {@macro element_in_memory_cache}
  ElementInMemoryCache();

  /// The stream controller for the cached element.
  @visibleForTesting
  final BehaviorSubject<T?> streamController = BehaviorSubject<T?>.seeded(null);

  /// Caches the provided [element].
  ///
  /// If [element] is `null`, the cached element is cleared.
  Future<void> set(T? element) async {
    streamController.add(element);
  }

  /// Returns the cached element, or `null` if no element is cached.
  Future<T?> get() async {
    return streamController.value;
  }

  /// Returns a stream of the cached element.
  Stream<T?> watch() {
    return streamController.stream.distinct();
  }

  /// Clears the cached element and frees resources.
  Future<void> dispose() async {
    await streamController.close();
  }
}
