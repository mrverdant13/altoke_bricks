import 'dart:async';

import 'package:altoke_common/common.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

/// Callback signature for comparing lists of elements.
typedef ElementsListEqualityChecker<E extends Object?> = bool Function(
  List<E> a,
  List<E> b,
);

/// {@template reactive_caches.reactive_elements_list_cache}
/// A reactive cache for a [List] of elements of type [E].
/// {@endtemplate}
class ReactiveElementsListCache<E extends Object?> {
  /// {@macro reactive_caches.reactive_elements_list_cache}
  ///
  /// If [equalityChecker] is `null`, the [defaultEqualityChecker] is used.
  ReactiveElementsListCache({
    ElementsListEqualityChecker<E>? equalityChecker,
  }) : equalityChecker = equalityChecker ?? defaultEqualityChecker;

  /// The default equality checker for lists of elements of type [E].
  @visibleForTesting
  static bool defaultEqualityChecker<E extends Object?>(List<E> a, List<E> b) =>
      ListEquality<E>().equals(a, b);

  /// The equality checker for the cached list of elements.
  @visibleForTesting
  final ElementsListEqualityChecker<E> equalityChecker;

  /// The cached elements.
  @visibleForTesting
  List<E> elements = [];

  /// The stream controller for the cached elements.
  @visibleForTesting
  StreamController<List<E>>? streamController;

  /// Performs side effects when the first listener is added to the stream.
  Future<void> onListen() async {
    streamController?.add(elements);
  }

  /// Performs side effects when the last listener is removed from the stream.
  @visibleForTesting
  Future<void> onCancel() async {
    final streamController = this.streamController;
    this.streamController = null;
    await streamController?.close();
  }

  /// Caches the provided [elements], replacing the current cached list.
  void set(Iterable<E> elements) {
    this.elements = [...elements];
    streamController?.add(this.elements);
  }

  /// Appends the provided [elements] to the cached list.
  void appendMany(Iterable<E> elements) {
    this.elements = [...this.elements, ...elements];
    streamController?.add(this.elements);
  }

  /// Prepends the provided [elements] to the cached list.
  void prependMany(Iterable<E> elements) {
    this.elements = [...elements, ...this.elements];
    streamController?.add(this.elements);
  }

  /// Returns the cached list filtered by the provided [where] callback.
  List<E> get({
    WhereCallback<E> where = noFilter,
  }) {
    return elements.where(where).toList();
  }

  /// Returns a stream of the cached list filtered by the provided [where]
  /// callback.
  Stream<List<E>> watch({
    WhereCallback<E> where = noFilter,
  }) {
    streamController ??= StreamController<List<E>>.broadcast(
      onListen: onListen,
      onCancel: onCancel,
    );
    return streamController!.stream
        .map((list) => list.where(where).toList())
        .distinct(equalityChecker);
  }

  /// Inserts the provided [elements] at the provided [index] in the cached
  /// list.
  ///
  /// If [index] is out of bounds, no action is taken.
  void insertMany(
    List<E> elements, {
    required int index,
  }) {
    if (index < 0 || index > this.elements.length) return;
    this.elements = [
      ...this.elements.take(index),
      ...elements,
      ...this.elements.skip(index),
    ];
    streamController?.add(this.elements);
  }

  /// Places the provided [indexedElements] according to the provided [mode].
  ///
  /// If an index is out of bounds, the corresponding element is not placed.
  void placeMany(
    IndexedIterable<E> indexedElements, {
    required PlacementMode mode,
  }) {
    this.elements = this
        .elements
        .mapIndexed(
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
        )
        .flattened
        .toList();
    streamController?.add(this.elements);
  }

  /// Updates the cached list by applying the provided [update] callback to each
  /// element that matches the provided [where] callback.
  void update({
    required UpdateCallback<E> update,
    WhereIndexedCallback<E> where = noIndexedFilter,
  }) {
    this.elements = [
      for (final (index, element) in this.elements.indexed)
        if (where(index, element)) update(element) else element,
    ];
    streamController?.add(this.elements);
  }

  /// Removes the elements from the cached list that match the provided [where]
  /// callback.
  void remove({
    WhereIndexedCallback<E> where = noIndexedFilter,
  }) {
    this.elements = [
      for (final (index, element) in this.elements.indexed)
        if (!where(index, element)) element,
    ];
    streamController?.add(this.elements);
  }

  /// Removes the last [count] elements from the cached list.
  ///
  /// If [count] is greater than the length of the cached list, the entire list
  /// is removed.
  void removeLast([int count = 1]) {
    if (count < 1) return;
    this.elements = this.elements.take(this.elements.length - count).toList();
    streamController?.add(this.elements);
  }

  /// Removes the first [count] elements from the cached list.
  ///
  /// If [count] is greater than the length of the cached list, the entire list
  /// is removed.
  void removeFirst([int count = 1]) {
    if (count < 1) return;
    this.elements = this.elements.skip(count).toList();
    streamController?.add(this.elements);
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
