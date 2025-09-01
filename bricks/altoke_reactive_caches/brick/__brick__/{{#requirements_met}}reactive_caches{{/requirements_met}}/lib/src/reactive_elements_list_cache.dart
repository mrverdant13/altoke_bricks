import 'dart:async';

import 'package:common/common.dart';
import 'package:{{#requirements_met}}reactive_caches{{/requirements_met}}/{{#requirements_met}}reactive_caches{{/requirements_met}}.dart';
import 'package:{{#requirements_met}}reactive_caches{{/requirements_met}}/src/immediate_firer_stream.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

/// {@template {{#requirements_met}}reactive_caches{{/requirements_met}}.reactive_elements_list_cache}
/// A reactive cache for a [List] of elements of type [E].
/// {@endtemplate}
class ReactiveElementsListCache<E extends Object?> {
  /// {@macro {{#requirements_met}}reactive_caches{{/requirements_met}}.reactive_elements_list_cache}
  ///
  /// If [equalityChecker] is `null`, the [defaultEqualityChecker] is used.
  ReactiveElementsListCache({ElementsListEqualityChecker<E>? equalityChecker})
    : equalityChecker = equalityChecker ?? defaultEqualityChecker {
    stream = ImmediateFirerStream<List<E>>(
      streamController.stream,
      computeInitialValue: () => Some(elements),
    );
    streamSubscription = stream.listen((elements) {
      this.elements = elements;
    });
  }

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
  final StreamController<List<E>> streamController =
      StreamController<List<E>>.broadcast(sync: true);

  /// The stream of the cached elements.
  @visibleForTesting
  late final Stream<List<E>> stream;

  /// The subscription to the stream of the cached elements.
  @visibleForTesting
  late final StreamSubscription<List<E>> streamSubscription;

  /// Caches the provided [elements], replacing the current cached list.
  void set(Iterable<E> elements) {
    streamController.add([...elements]);
  }

  /// Appends the provided [elements] to the cached list.
  void appendMany(Iterable<E> elements) {
    streamController.add([...this.elements, ...elements]);
  }

  /// Prepends the provided [elements] to the cached list.
  void prependMany(Iterable<E> elements) {
    streamController.add([...elements, ...this.elements]);
  }

  /// Returns the cached list filtered by the provided [where] callback.
  List<E> get({WhereCallback<E> where = noFilter}) {
    return elements.where(where).toList();
  }

  /// Returns a stream of the cached list filtered by the provided [where]
  /// callback.
  Stream<List<E>> watch({WhereCallback<E> where = noFilter}) {
    return stream
        .map((elements) => elements.where(where).toList())
        .distinct(equalityChecker);
  }

  /// Inserts the provided [elements] at the provided [index] in the cached
  /// list.
  ///
  /// If [index] is out of bounds, no action is taken.
  void insertMany(List<E> elements, {required int index}) {
    if (index < 0 || index > this.elements.length) return;
    streamController.add([
      ...this.elements.take(index),
      ...elements,
      ...this.elements.skip(index),
    ]);
  }

  /// Places the provided [indexedElements] according to the provided [mode].
  ///
  /// If an index is out of bounds, the corresponding element is not placed.
  void placeMany(
    IndexedIterable<E> indexedElements, {
    required PlacementMode mode,
  }) {
    streamController.add(
      elements
          .mapIndexed((index, currentElement) {
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
          })
          .flattened
          .toList(),
    );
  }

  /// Updates the cached list by applying the provided [update] callback to each
  /// element that matches the provided [where] callback.
  void update({
    required UpdateCallback<E> update,
    WhereIndexedCallback<E> where = noIndexedFilter,
  }) {
    streamController.add([
      for (final (index, element) in elements.indexed)
        if (where(index, element)) update(element) else element,
    ]);
  }

  /// Removes the elements from the cached list that match the provided [where]
  /// callback.
  void remove({WhereIndexedCallback<E> where = noIndexedFilter}) {
    streamController.add([
      for (final (index, element) in elements.indexed)
        if (!where(index, element)) element,
    ]);
  }

  /// Removes the last [count] elements from the cached list.
  ///
  /// If [count] is greater than the length of the cached list, the entire list
  /// is removed.
  void removeLast([int count = 1]) {
    if (count < 1) return;
    streamController.add([...elements.take(elements.length - count)]);
  }

  /// Removes the first [count] elements from the cached list.
  ///
  /// If [count] is greater than the length of the cached list, the entire list
  /// is removed.
  void removeFirst([int count = 1]) {
    if (count < 1) return;
    streamController.add([...elements.skip(count)]);
  }

  /// Releases the resources used by the cache.
  Future<void> dispose() async {
    await streamSubscription.cancel();
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
}
