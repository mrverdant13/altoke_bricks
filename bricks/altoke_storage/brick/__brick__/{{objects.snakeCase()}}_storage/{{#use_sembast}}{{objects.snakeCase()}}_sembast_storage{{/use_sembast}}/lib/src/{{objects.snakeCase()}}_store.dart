import 'package:common/common.dart';
import 'package:{{objects.snakeCase()}}_sembast_storage/{{objects.snakeCase()}}_sembast_storage.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:sembast/sembast.dart';

/// A reference to a raw {{objects.lowerCase()}} store.
typedef {{objects.pascalCase()}}StoreRef = StoreRef<int, Map<String, Object?>>;

/// An extension on [{{objects.pascalCase()}}StoreRef] to add functionality.
extension Extended{{objects.pascalCase()}}Box on {{objects.pascalCase()}}StoreRef {
  /// Saves the [new{{object.pascalCase()}}] to the box with an auto-generated ID.
  Future<int> addNew{{object.pascalCase()}}(
    Database database,
    New{{object.pascalCase()}} new{{object.pascalCase()}},
  ) async {
    return add(database, new{{object.pascalCase()}}.toSembastJson());
  }

  /// Saves the [{{object.camelCase()}}] to the box.
  Future<void> put{{object.pascalCase()}}(
    Database database,
    {{object.pascalCase()}} {{object.camelCase()}},
  ) async {
    await record({{object.camelCase()}}.id).put(database, {{object.camelCase()}}.toSembastJson());
  }

  /// Retrieves the {{object.lowerCase()}} with the given [id].
  Future<{{object.pascalCase()}}?> get{{object.pascalCase()}}ById(
    Database database,
    int id,
  ) async {
    final {{object.camelCase()}}Snapshot = await record(id).getSnapshot(database);
    return {{object.camelCase()}}Snapshot?.to{{object.pascalCase()}}();
  }

  /// Returns a stream of {{objects.lowerCase()}} that match the given [where] filter.
  ///
  /// The results are sorted by name.
  Stream<Iterable<{{object.pascalCase()}}>> watch{{objects.pascalCase()}}(
    Database database, {
    required Filter where,
  }) {
    final dbFinder = Finder(
      filter: where,
      sortOrders: [
        SortOrder(
          Sembast{{object.pascalCase()}}.nameJsonKey,
        ),
      ],
    );
    return query(finder: dbFinder)
        .onSnapshots(database)
        .map({{objects.camelCase()}}From{{objects.pascalCase()}}Snapshots);
  }

  /// Returns aa stream of the count of {{objects.lowerCase()}} that match the given
  /// [where] filter.
  Stream<int> watchCount(
    Database database, {
    required Filter where,
  }) {
    final dbFinder = Finder(
      filter: where,
      sortOrders: [
        SortOrder(
          Sembast{{object.pascalCase()}}.nameJsonKey,
        ),
      ],
    );
    return query(finder: dbFinder).onCount(database);
  }

  /// Updates the {{object.lowerCase()}} with the given [id] with the new
  /// [partial{{object.pascalCase()}}].
  Future<void> updateWithPartial{{object.pascalCase()}}(
    Database database, {
    required int id,
    required Partial{{object.pascalCase()}} partial{{object.pascalCase()}},
  }) async {
    await record(id).update(database, partial{{object.pascalCase()}}.toSembastJson());
  }

  /// Deletes the {{object.lowerCase()}} with the given [id].
  Future<{{object.pascalCase()}}?> delete{{object.pascalCase()}}ById(
    Database database,
    int id,
  ) async {
    final {{object.camelCase()}}Snapshot = await record(id).getSnapshot(database);
    if ({{object.camelCase()}}Snapshot == null) return null;
    await record(id).delete(database);
    return {{object.camelCase()}}Snapshot.to{{object.pascalCase()}}();
  }

  /// Deletes all the {{objects.lowerCase()}} that match the given [where] filter.
  Future<void> deleteAll{{objects.pascalCase()}}(
    Database database, {
    required Filter? where,
  }) async {
    final dbFinder = Finder(filter: where);
    await delete(database, finder: dbFinder);
  }
}

/// A set of filters to apply on [{{object.pascalCase()}}]s
abstract class {{objects.pascalCase()}}Filter {
  /// A no-op filter.
  static Filter noFilter = Filter.custom((record) => true);

  /// A filter to match the given [partial{{object.pascalCase()}}].
  static Filter? matchesPartial(
    Partial{{object.pascalCase()}}? partial{{object.pascalCase()}},
  ) {
    if (partial{{object.pascalCase()}} == null) return null;
    final Partial{{object.pascalCase()}}(:name, :description) = partial{{object.pascalCase()}};
    final nameMatches = switch (name) {
      None() => noFilter,
      Some(value: final nameFragment) => nameContains(nameFragment),
    };
    final descriptionMatches = switch (description) {
      None() => noFilter,
      Some(value: final descriptionFragment) => switch (
            descriptionFragment?.trim()) {
          null => descriptionIsNull(),
          final descriptionFragment => descriptionContains(descriptionFragment),
        },
    };
    return andAll([nameMatches, descriptionMatches]);
  }

  /// A filter to match the given [name] against the [{{object.pascalCase()}}.name].
  static Filter nameContains(String name) {
    return switch (name.trim()) {
      String(:final isEmpty) when isEmpty => noFilter,
      final nameFragment => Filter.matches(
          Sembast{{object.pascalCase()}}.nameJsonKey,
          nameFragment,
        ),
    };
  }

  /// A filter to match `null` [{{object.pascalCase()}}.description]s.
  static Filter descriptionIsNull() {
    return Filter.isNull(Sembast{{object.pascalCase()}}.descriptionJsonKey);
  }

  /// A filter to match non-`null` [{{object.pascalCase()}}.description]s.
  static Filter descriptionIsNotNull() {
    return Filter.notNull(Sembast{{object.pascalCase()}}.descriptionJsonKey);
  }

  /// A filter to match the given [description] against the
  /// [{{object.pascalCase()}}.description].
  static Filter descriptionContains(String description) {
    return switch (description.trim()) {
      String(:final isEmpty) when isEmpty => descriptionIsNotNull(),
      final descriptionFragment => Filter.matches(
          Sembast{{object.pascalCase()}}.descriptionJsonKey,
          descriptionFragment,
        ),
    };
  }

  /// A filter to match the given [content] against the [{{object.pascalCase()}}.name] and
  /// [{{object.pascalCase()}}.description].
  static Filter matchesContent(
    String? content,
  ) {
    return switch (content?.trim()) {
      null => noFilter,
      String(:final isEmpty) when isEmpty => noFilter,
      final searchTerm => Filter.or([
          nameContains(searchTerm),
          descriptionContains(searchTerm),
        ])
    };
  }

  /// A filter that combines the given [filters] to match all of them.
  static Filter andAll(
    Iterable<Filter> filters,
  ) {
    final validFilters = filters.nonNulls;
    if (validFilters.isEmpty) return noFilter;
    return Filter.and([...validFilters]);
  }
}
