import 'package:altoke_common/common.dart';
import 'package:altoke_entities_hive_storage/altoke_entities_hive_storage.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

/// The box for Altoke Entities.
typedef AltokeEntitiesBox = Box<Map<dynamic, dynamic>>;

/// An extension on [AltokeEntitiesBox] to add functionality.
extension ExtendedAltokeEntitiesBox on AltokeEntitiesBox {
  /// Returns all the persisted altoke entities.
  Iterable<AltokeEntity> get altokeEntities {
    return toMap().entries.map((entry) => entry.toAltokeEntity());
  }

  /// Saves the [newAltokeEntity] to the box with an auto-generated ID.
  Future<int> addNewAltokeEntity(NewAltokeEntity newAltokeEntity) async {
    return add(newAltokeEntity.toHiveJson());
  }

  /// Saves the [altokeEntity] to the box.
  Future<void> putAltokeEntity(AltokeEntity altokeEntity) async {
    return put(altokeEntity.id, altokeEntity.toHiveJson());
  }

  /// Retrieves the altoke entity with the given [id].
  AltokeEntity? getAltokeEntityById(int id) {
    final rawAltokeEntity = get(id);
    if (rawAltokeEntity == null) return null;
    return HiveAltokeEntity.fromJson(rawAltokeEntity).toAltokeEntityWithId(id);
  }

  /// Returns the altoke entities that match the given [where] filter.
  ///
  /// The results are sorted by name.
  Iterable<AltokeEntity> getAltokeEntities({
    required WhereCallback<AltokeEntity> where,
  }) {
    return altokeEntities
        .where(where)
        .sortedBy((altokeEntity) => altokeEntity.name);
  }

  /// Returns the count of altoke entities that match the given [where] filter.
  int getCount({
    required WhereCallback<AltokeEntity> where,
  }) {
    return altokeEntities.where(where).length;
  }

  /// Updates the altoke entity with the given [id] with the new
  /// [partialAltokeEntity].
  Future<void> updateWithPartialAltokeEntity({
    required int id,
    required PartialAltokeEntity partialAltokeEntity,
  }) async {
    final rawAltokeEntity = get(id);
    if (rawAltokeEntity == null) return;
    final altokeEntity = HiveAltokeEntity.fromJson(rawAltokeEntity)
        .copyWithAppliedPartial(partialAltokeEntity);
    await put(
      id,
      altokeEntity.toJson(),
    );
  }

  /// Deletes the altoke entity with the given [id].
  Future<AltokeEntity?> deleteAltokeEntityById(int id) async {
    final rawAltokeEntity = get(id);
    if (rawAltokeEntity == null) return null;
    await delete(id);
    return HiveAltokeEntity.fromJson(rawAltokeEntity).toAltokeEntityWithId(id);
  }

  /// Deletes all the altoke entities that match the given [where] filter.
  Future<void> deleteAllAltokeEntities({
    required WhereCallback<AltokeEntity> where,
  }) async {
    final keysToDelete =
        altokeEntities.where(where).map((altokeEntity) => altokeEntity.id);
    await deleteAll(keysToDelete);
  }
}

/// A set of filters to apply on [AltokeEntity]s
abstract class AltokeEntitiesFilter {
  /// A filter to match the given [partialAltokeEntity].
  static WhereCallback<AltokeEntity>? matchesPartial(
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
  static WhereCallback<AltokeEntity> nameContains(String name) {
    return switch (name.trim()) {
      String(:final isEmpty) when isEmpty => noFilter,
      final searchTerm => (altokeEntity) =>
          altokeEntity.name.contains(searchTerm),
    };
  }

  /// A filter to match `null` [AltokeEntity.description]s.
  static WhereCallback<AltokeEntity> descriptionIsNull() {
    return (altokeEntity) => altokeEntity.description == null;
  }

  /// A filter to match non-`null` [AltokeEntity.description]s.
  static WhereCallback<AltokeEntity> descriptionIsNotNull() {
    return (altokeEntity) => altokeEntity.description != null;
  }

  /// A filter to match the given [description] against the
  /// [AltokeEntity.description].
  static WhereCallback<AltokeEntity> descriptionContains(String description) {
    return switch (description.trim()) {
      String(:final isEmpty) when isEmpty => descriptionIsNotNull(),
      final descriptionFragment => (altokeEntity) =>
          altokeEntity.description?.contains(descriptionFragment) ?? false,
    };
  }

  /// A filter to match the given [content] against the [AltokeEntity.name] and
  /// [AltokeEntity.description].
  static WhereCallback<AltokeEntity> matchesContent(
    String? content,
  ) {
    return switch (content?.trim()) {
      null => noFilter,
      String(:final isEmpty) when isEmpty => noFilter,
      final searchTerm => orAll([
          nameContains(searchTerm),
          descriptionContains(searchTerm),
        ])
    };
  }

  /// A filter that combines the given [filters] to match all of them.
  static WhereCallback<AltokeEntity> andAll(
    Iterable<WhereCallback<AltokeEntity>?> filters,
  ) {
    final validFilters = filters.whereNotNull();
    if (validFilters.isEmpty) return noFilter;
    return (altokeEntity) =>
        validFilters.every((filter) => filter(altokeEntity));
  }

  /// A filter that combines the given [filters] to match any of them.
  static WhereCallback<AltokeEntity> orAll(
    Iterable<WhereCallback<AltokeEntity>?> filters,
  ) {
    final validFilters = filters.whereNotNull();
    if (validFilters.isEmpty) return noFilter;
    return (altokeEntity) => validFilters.any((filter) => filter(altokeEntity));
  }
}
