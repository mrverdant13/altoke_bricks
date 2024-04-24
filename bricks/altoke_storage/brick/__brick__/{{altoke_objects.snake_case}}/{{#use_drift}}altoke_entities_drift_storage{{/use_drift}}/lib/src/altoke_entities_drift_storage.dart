import 'package:altoke_common/common.dart';
import 'package:altoke_entities_drift_storage/altoke_entities_drift_storage.dart';
import 'package:altoke_entities_drift_storage/src/drift_{{object.snakeCase()}}.dart';
import 'package:altoke_entities_storage/altoke_entities_storage.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:meta/meta.dart';

/// {@template altoke_entities_drift_storage}
/// A persistent [AltokeEntitiesStorage] implementation using Drift (SQLite).
/// {@endtemplate}
class AltokeEntitiesDriftStorage implements AltokeEntitiesStorage {
  /// {@macro altoke_entities_drift_storage}
  AltokeEntitiesDriftStorage({
    required this.altokeEntitiesDao,
  });

  /// The altoke entities DAO.
  @visibleForTesting
  late final DriftAltokeEntitiesDao altokeEntitiesDao;

  /// The altoke entities table.
  DriftAltokeEntitiesTable get altokeEntitiesTable =>
      altokeEntitiesDao.altokeEntities;

  /// Equality checker for [AltokeEntity]s.
  @visibleForTesting
  static const altokeEntitiesEqualityChecker = IterableEquality<AltokeEntity>();

  @override
  Future<void> create({
    required NewAltokeEntity newAltokeEntity,
  }) async {
    final NewAltokeEntity(
      name: name,
      description: description,
    ) = newAltokeEntity;
    if (name.isEmpty) throw const CreateAltokeEntityFailureEmptyName();
    await altokeEntitiesDao.add(name, description);
  }

  @override
  Future<void> insert({
    required AltokeEntity altokeEntity,
  }) async {
    final AltokeEntity(
      id: id,
      name: name,
      description: description,
    ) = altokeEntity;
    await altokeEntitiesDao.insert(id, name, description);
  }

  @override
  Future<AltokeEntity?> getById(
    int altokeEntityId,
  ) async {
    final rawAltokeEntity =
        await altokeEntitiesDao.getById(altokeEntityId).getSingleOrNull();
    return rawAltokeEntity?.toAltokeEntity();
  }

  @override
  Stream<List<AltokeEntity>> watch({
    String? searchTerm,
  }) {
    final query = altokeEntitiesTable.select()
      ..where(
        (table) => table.contentMatches(searchTerm),
      )
      ..orderBy(
        [
          (altokeEntities) => OrderingTerm(
                expression: altokeEntities.name,
              ),
        ],
      );
    return query
        .watch()
        .map(altokeEntitiesFromDriftAltokeEntities)
        .distinct(altokeEntitiesEqualityChecker.equals);
  }

  @override
  Stream<int> watchCount({
    String? searchTerm,
  }) {
    return altokeEntitiesTable
        .count(
          where: (table) => table.contentMatches(searchTerm),
        )
        .watchSingle();
  }

  @override
  Future<void> update({
    required int altokeEntityId,
    required PartialAltokeEntity partialAltokeEntity,
  }) async {
    if (partialAltokeEntity
        case PartialAltokeEntity(name: Some(value: String(:final isEmpty)))
        when isEmpty) {
      throw const UpdateAltokeEntityFailureEmptyName();
    }
    final PartialAltokeEntity(
      name: partialName,
      description: partialDescription,
    ) = partialAltokeEntity;
    await (altokeEntitiesTable.update()
          ..where((altokeEntities) => altokeEntities.id.equals(altokeEntityId)))
        .write(
      DriftAltokeEntitiesCompanion(
        name: switch (partialName) {
          None() => const Value.absent(),
          Some(value: final name) => switch (name.trim()) {
              String(:final isEmpty) when isEmpty => const Value.absent(),
              final name => Value(name),
            }
        },
        description: switch (partialDescription) {
          None() => const Value.absent(),
          Some(value: final description) => switch (description?.trim()) {
              null => const Value.absent(),
              String(:final isEmpty) when isEmpty => const Value.absent(),
              final description => Value(description),
            }
        },
      ),
    );
  }

  @override
  Future<AltokeEntity?> deleteById(
    int altokeEntityId,
  ) async {
    final rawAltokeEntity =
        await altokeEntitiesDao.getById(altokeEntityId).getSingleOrNull();
    if (rawAltokeEntity == null) return null;
    await altokeEntitiesDao.deleteById(altokeEntityId);
    return rawAltokeEntity.toAltokeEntity();
  }

  @override
  Future<void> deleteAll({
    PartialAltokeEntity? referenceAltokeEntity,
  }) async {
    if (referenceAltokeEntity == null) {
      await altokeEntitiesTable.deleteAll();
      return;
    }
    await altokeEntitiesTable.deleteWhere(
      (altokeEntities) => altokeEntities.matchesPartial(referenceAltokeEntity),
    );
  }
}
