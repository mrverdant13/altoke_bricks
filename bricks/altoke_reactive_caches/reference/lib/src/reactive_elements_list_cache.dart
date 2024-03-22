import 'package:altoke_common/common.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

/// {@template reactive_caches.reactive_elements_list_cache}
/// A reactive cache for a [List] of elements of type [E].
/// {@endtemplate}
class ReactiveElementsListCache<E extends Object?> {
  /// {@macro reactive_caches.reactive_elements_list_cache}
  ReactiveElementsListCache();

  /// The stream controller for the cached list.
  @visibleForTesting
  final BehaviorSubject<List<E>> streamController = BehaviorSubject.seeded([]);

  /// Equality checker for lists.
  @visibleForTesting
  final listEqualityChecker = ListEquality<E>();

  /// Caches the provided [elements], replacing the current cached list.
  void set(Iterable<E> elements) {
    streamController.add([...elements]);
  }

  /// Appends the provided [elements] to the cached list.
  void appendMany(Iterable<E> elements) {
    final currentElements = streamController.value;
    final resultingElements = [...currentElements, ...elements];
    streamController.add(resultingElements);
  }

  /// Prepends the provided [elements] to the cached list.
  void prependMany(Iterable<E> elements) {
    final currentElements = streamController.value;
    final resultingElements = [...elements, ...currentElements];
    streamController.add(resultingElements);
  }

  /// Returns the cached list filtered by the provided [where] callback.
  List<E> get({
    WhereCallback<E> where = noFilter,
  }) {
    return streamController.value.where(where).toList();
  }

  /// Returns a stream of the cached list filtered by the provided [where]
  /// callback.
  Stream<List<E>> watch({
    WhereCallback<E> where = noFilter,
  }) {
    return streamController.stream
        .map((list) => list.where(where).toList())
        .distinct(listEqualityChecker.equals);
  }

  /// Inserts the provided [elements] at the provided [index] in the cached
  /// list.
  ///
  /// If [index] is out of bounds, no action is taken.
  void insertMany(
    List<E> elements, {
    required int index,
  }) {
    final currentElements = streamController.value;
    if (index < 0 || index > currentElements.length) return;
    final resultingElements = [
      ...currentElements.take(index),
      ...elements,
      ...currentElements.skip(index),
    ];
    streamController.add(resultingElements);
  }

  /// Places the provided [indexedElements] according to the provided [mode].
  ///
  /// If an index is out of bounds, the corresponding element is not placed.
  void placeMany(
    IndexedIterable<E> indexedElements, {
    required PlacementMode mode,
  }) {
    final currentElements = streamController.value;
    final overriddenElements = currentElements.mapIndexed(
      (index, currentElement) {
        final overridingElements = indexedElements
            .where((indexedElement) => indexedElement.$1 == index)
            .map((indexedElement) => indexedElement.$2);
        return switch (mode) {
          PlacementMode.appendGroup => [
              currentElement,
              if (overridingElements.isNotEmpty) ...overridingElements,
            ],
          PlacementMode.appendFirst => [
              currentElement,
              if (overridingElements.isNotEmpty) overridingElements.first,
            ],
          PlacementMode.appendLast => [
              currentElement,
              if (overridingElements.isNotEmpty) overridingElements.last,
            ],
          PlacementMode.prependGroup => [
              if (overridingElements.isNotEmpty) ...overridingElements,
              currentElement,
            ],
          PlacementMode.prependFirst => [
              if (overridingElements.isNotEmpty) overridingElements.first,
              currentElement,
            ],
          PlacementMode.prependLast => [
              if (overridingElements.isNotEmpty) overridingElements.last,
              currentElement,
            ],
          PlacementMode.replaceWithGroup => [
              if (overridingElements.isNotEmpty)
                ...overridingElements
              else
                currentElement,
            ],
          PlacementMode.replaceWithFirst => [
              if (overridingElements.isNotEmpty)
                overridingElements.first
              else
                currentElement,
            ],
          PlacementMode.replaceWithLast => [
              if (overridingElements.isNotEmpty)
                overridingElements.last
              else
                currentElement,
            ],
        };
      },
    );
    final resultingElements = overriddenElements.flattened;
    streamController.add([...resultingElements]);
  }

  /// Updates the cached list by applying the provided [update] callback to each
  /// element that matches the provided [where] callback.
  void update({
    required UpdateCallback<E> update,
    WhereIndexedCallback<E> where = noIndexedFilter,
  }) {
    final currentElements = streamController.value;
    final resultingElements = [
      for (final (index, element) in currentElements.indexed)
        if (where(index, element)) update(element) else element,
    ];
    streamController.add(resultingElements);
  }

  /// Removes the elements from the cached list that match the provided [where]
  /// callback.
  void remove({
    WhereIndexedCallback<E> where = noIndexedFilter,
  }) {
    final currentElements = streamController.value;
    final resultingElements = [
      for (final (index, element) in currentElements.indexed)
        if (!where(index, element)) element,
    ];
    streamController.add(resultingElements);
  }

  /// Removes the last [count] elements from the cached list.
  ///
  /// If [count] is greater than the length of the cached list, the entire list
  /// is removed.
  void removeLast([int count = 1]) {
    if (count < 1) return;
    final currentElements = streamController.value;
    final resultingElements =
        currentElements.take(currentElements.length - count).toList();
    streamController.add(resultingElements);
  }

  /// Removes the first [count] elements from the cached list.
  ///
  /// If [count] is greater than the length of the cached list, the entire list
  /// is removed.
  void removeFirst([int count = 1]) {
    if (count < 1) return;
    final currentElements = streamController.value;
    final resultingElements = currentElements.skip(count).toList();
    streamController.add(resultingElements);
  }

  /// Clears the cached list and frees resources.
  Future<void> dispose() async {
    streamController.add([]);
    await streamController.close();
  }
}

/// The placement mode for the [ReactiveElementsListCache.placeMany] method.
enum PlacementMode {
  /// The provided elements to be placed with the same index are placed just
  /// after the corresponding element with that index in the cached list.
  ///
  /// Example:
  /// - Cached list: `[0, 1, 2, 3, 4]`
  /// - Indexed elements: `[(2, 2.1), (2, 2.2), (4, 4.1)]`
  /// - Resulting list: `[0, 1, 2, 2.1, 2.2, 3, 4, 4.1]`
  appendGroup,

  /// Only the first provided element with a specific index is placed just after
  /// the corresponding element with that index in the cached list.
  ///
  /// Example:
  /// - Cached list: `[0, 1, 2, 3, 4]`
  /// - Indexed elements: `[(2, 2.1), (2, 2.2), (4, 4.1)]`
  /// - Resulting list: `[0, 1, 2, 2.1, 3, 4, 4.1]`
  appendFirst,

  /// Only the last provided element with a specific index is placed just after
  /// the corresponding element with that index in the cached list.
  ///
  /// Example:
  /// - Cached list: `[0, 1, 2, 3, 4]`
  /// - Indexed elements: `[(2, 2.1), (2, 2.2), (4, 4.1)]`
  /// - Resulting list: `[0, 1, 2, 2.2, 3, 4, 4.1]`
  appendLast,

  /// The provided elements to be placed with the same index are placed just
  /// before the corresponding element with that index in the cached list.
  ///
  /// Example:
  /// - Cached list: `[0, 1, 2, 3, 4]`
  /// - Indexed elements: `[(2, 2.1), (2, 2.2), (4, 4.1)]`
  /// - Resulting list: `[0, 1, 2.1, 2.2, 2, 3, 4.1, 4]`
  prependGroup,

  /// Only the first provided element with a specific index is placed just
  /// before the corresponding element with that index in the cached list.
  ///
  /// Example:
  /// - Cached list: `[0, 1, 2, 3, 4]`
  /// - Indexed elements: `[(2, 2.1), (2, 2.2), (4, 4.1)]`
  /// - Resulting list: `[0, 1, 2.1, 2, 3, 4.1, 4]`
  prependFirst,

  /// Only the last provided element with a specific index is placed just before
  /// the corresponding element with that index in the cached list.
  ///
  /// Example:
  /// - Cached list: `[0, 1, 2, 3, 4]`
  /// - Indexed elements: `[(2, 2.1), (2, 2.2), (4, 4.1)]`
  /// - Resulting list: `[0, 1, 2.2, 2, 3, 4.1, 4]`
  prependLast,

  /// The provided elements to be placed with the same index replace the
  /// corresponding element with that index in the cached list.
  ///
  /// Example:
  /// - Cached list: `[0, 1, 2, 3, 4]`
  /// - Indexed elements: `[(2, 2.1), (2, 2.2), (4, 4.1)]`
  /// - Resulting list: `[0, 1, 2.1, 2.2, 3, 4.1]`
  replaceWithGroup,

  /// Only the first provided element with a specific index replaces the
  /// corresponding element with that index in the cached list.
  ///
  /// Example:
  /// - Cached list: `[0, 1, 2, 3, 4]`
  /// - Indexed elements: `[(2, 2.1), (2, 2.2), (4, 4.1)]`
  /// - Resulting list: `[0, 1, 2.1, 3, 4.1]`
  replaceWithFirst,

  /// Only the last provided element with a specific index replaces the
  /// corresponding element with that index in the cached list.
  ///
  /// Example:
  /// - Cached list: `[0, 1, 2, 3, 4]`
  /// - Indexed elements: `[(2, 2.1), (2, 2.2), (4, 4.1)]`
  /// - Resulting list: `[0, 1, 2.2, 3, 4.1]`
  replaceWithLast,
  ;
}
