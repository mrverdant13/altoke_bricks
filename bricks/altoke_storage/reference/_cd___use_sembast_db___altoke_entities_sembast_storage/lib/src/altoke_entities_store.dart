import 'package:altoke_common/common.dart';
import 'package:altoke_entities_sembast_storage/altoke_entities_sembast_storage.dart';
import 'package:altoke_entity/altoke_entity.dart';
import 'package:collection/collection.dart';
import 'package:sembast/sembast.dart';

/// A reference to a raw altoke entities store.
typedef AltokeEntitiesStoreRef = StoreRef<int, Json>;

/// An extension on [AltokeEntitiesStoreRef] to add functionality.
extension ExtendedAltokeEntitiesBox on AltokeEntitiesStoreRef {
  /// Saves the [newAltokeEntity] to the box with an auto-generated ID.
  Future<int> addNewAltokeEntity(
    Database database,
    NewAltokeEntity newAltokeEntity,
  ) async {
    return add(database, newAltokeEntity.toSembastJson());
  }

  /// Saves the [altokeEntity] to the box.
  Future<void> putAltokeEntity(
    Database database,
    AltokeEntity altokeEntity,
  ) async {
    await record(altokeEntity.id).put(database, altokeEntity.toSembastJson());
  }

  /// Retrieves the altoke entity with the given [id].
  Future<AltokeEntity?> getAltokeEntityById(
    Database database,
    int id,
  ) async {
    final altokeEntitySnapshot = await record(id).getSnapshot(database);
    return altokeEntitySnapshot?.toAltokeEntity();
  }

  /// Returns a stream of altoke entities that match the given [where] filter.
  ///
  /// The results are sorted by name.
  Stream<Iterable<AltokeEntity>> watchAltokeEntities(
    Database database, {
    required Filter where,
  }) {
    final dbFinder = Finder(
      filter: where,
      sortOrders: [
        SortOrder(
          SembastAltokeEntity.nameJsonKey,
        ),
      ],
    );
    return query(finder: dbFinder)
        .onSnapshots(database)
        .map(altokeEntitiesFromAltokeEntitiesSnapshots);
  }

  /// Returns aa stream of the count of altoke entities that match the given
  /// [where] filter.
  Stream<int> watchCount(
    Database database, {
    required Filter where,
  }) {
    final dbFinder = Finder(
      filter: where,
      sortOrders: [
        SortOrder(
          SembastAltokeEntity.nameJsonKey,
        ),
      ],
    );
    return query(finder: dbFinder).onCount(database);
  }

  /// Updates the altoke entity with the given [id] with the new
  /// [partialAltokeEntity].
  Future<void> updateWithPartialAltokeEntity(
    Database database, {
    required int id,
    required PartialAltokeEntity partialAltokeEntity,
  }) async {
    await record(id).update(database, partialAltokeEntity.toSembastJson());
  }

  /// Deletes the altoke entity with the given [id].
  Future<AltokeEntity?> deleteAltokeEntityById(
    Database database,
    int id,
  ) async {
    final altokeEntitySnapshot = await record(id).getSnapshot(database);
    if (altokeEntitySnapshot == null) return null;
    await record(id).delete(database);
    return altokeEntitySnapshot.toAltokeEntity();
  }

  /// Deletes all the altoke entities that match the given [where] filter.
  Future<void> deleteAllAltokeEntities(
    Database database, {
    required Filter? where,
  }) async {
    final dbFinder = Finder(filter: where);
    await delete(database, finder: dbFinder);
  }
}

/// A set of filters to apply on [AltokeEntity]s
abstract class AltokeEntitiesFilter {
  /// A no-op filter.
  static Filter noFilter = Filter.custom((record) => true);

  /// A filter to match the given [partialAltokeEntity].
  static Filter? matchesPartial(
    PartialAltokeEntity? partialAltokeEntity,
  ) {
    if (partialAltokeEntity == null) return null;
    final PartialAltokeEntity(:name, :description) = partialAltokeEntity;
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

  /// A filter to match the given [name] against the [AltokeEntity.name].
  static Filter nameContains(String name) {
    return switch (name.trim()) {
      String(:final isEmpty) when isEmpty => noFilter,
      final nameFragment => Filter.matches(
          SembastAltokeEntity.nameJsonKey,
          nameFragment,
        ),
    };
  }

  /// A filter to match `null` [AltokeEntity.description]s.
  static Filter descriptionIsNull() {
    return Filter.isNull(SembastAltokeEntity.descriptionJsonKey);
  }

  /// A filter to match non-`null` [AltokeEntity.description]s.
  static Filter descriptionIsNotNull() {
    return Filter.notNull(SembastAltokeEntity.descriptionJsonKey);
  }

  /// A filter to match the given [description] against the
  /// [AltokeEntity.description].
  static Filter descriptionContains(String description) {
    return switch (description.trim()) {
      String(:final isEmpty) when isEmpty => descriptionIsNotNull(),
      final descriptionFragment => Filter.matches(
          SembastAltokeEntity.descriptionJsonKey,
          descriptionFragment,
        ),
    };
  }

  /// A filter to match the given [content] against the [AltokeEntity.name] and
  /// [AltokeEntity.description].
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
    final validFilters = filters.whereNotNull();
    if (validFilters.isEmpty) return noFilter;
    return Filter.and([...validFilters]);
  }

  /// A filter that combines the given [filters] to match any of them.
  static Filter orAll(
    Iterable<Filter> filters,
  ) {
    final validFilters = filters.whereNotNull();
    if (validFilters.isEmpty) return noFilter;
    return Filter.or([...validFilters]);
  }
}
