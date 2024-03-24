import 'package:altoke_common/common.dart';
import 'package:altoke_entities_hive_storage/altoke_entities_hive_storage.dart';
import 'package:altoke_entity/altoke_entity.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

/// An altoke entity entry.
typedef AltokeEntityEntry = MapEntry<dynamic, Map<dynamic, dynamic>>;

/// An extension on [AltokeEntityEntry] to add mapping capabilities.
extension ExtendedAltokeEntityEntry on AltokeEntityEntry {
  /// Converts this [AltokeEntityEntry] to a [AltokeEntity].
  AltokeEntity toAltokeEntity() {
    return HiveAltokeEntity.fromJson(value).toEntityWithId(key as int);
  }
}

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
    return add(newAltokeEntity.toHive().toJson());
  }

  /// Saves the [altokeEntity] to the box.
  Future<void> putAltokeEntity(AltokeEntity altokeEntity) async {
    return put(altokeEntity.id, altokeEntity.toHive().toJson());
  }

  /// Retrieves the altoke entity with the given [id].
  AltokeEntity? getAltokeEntityById(int id) {
    final rawAltokeEntity = get(id);
    if (rawAltokeEntity == null) return null;
    return HiveAltokeEntity.fromJson(rawAltokeEntity).toEntityWithId(id);
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
    await put(
      id,
      {
        ...rawAltokeEntity,
        ...partialAltokeEntity.toHive().toJson(),
      },
    );
  }

  /// Deletes the altoke entity with the given [id].
  Future<AltokeEntity?> deleteAltokeEntityById(int id) async {
    final rawAltokeEntity = get(id);
    if (rawAltokeEntity == null) return null;
    await delete(id);
    return HiveAltokeEntity.fromJson(rawAltokeEntity).toEntityWithId(id);
  }

  /// Deletes all the altoke entities that match the given [where] filter.
  Future<void> deleteAllAltokeEntities({
    required WhereCallback<AltokeEntity> where,
  }) async {
    final keysToDelete = altokeEntities
        .where(where)
        .map((altokeEntity) => altokeEntity.id)
        .toList();
    await deleteAll(keysToDelete);
  }
}
