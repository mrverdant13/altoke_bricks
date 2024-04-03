import 'package:altoke_common/common.dart';
import 'package:altoke_entities_isar_storage/altoke_entities_isar_storage.dart';
import 'package:altoke_entities_storage/altoke_entities_storage.dart';
import 'package:altoke_entity/altoke_entity.dart';
import 'package:collection/collection.dart';
import 'package:isar/isar.dart';
import 'package:meta/meta.dart';

/// {@template tasks_isar_storage}
/// A persistent [AltokeEntitiesStorage] implementation using Isar.
/// {@endtemplate}
class AltokeEntitiesIsarStorage implements AltokeEntitiesStorage {
  /// {@macro tasks_isar_storage}
  const AltokeEntitiesIsarStorage({
    required this.database,
  });

  /// Box for the tasks.
  @visibleForTesting
  final Isar database;

  /// The tasks collection.
  @visibleForTesting
  IsarAltokeEntitiesCollection get altokeEntitiesCollection =>
      database.isarAltokeEntities;

  /// Equality checker for [AltokeEntity]s.
  @visibleForTesting
  static const altokeEntitiesEqualityChecker = IterableEquality<AltokeEntity>();

  @override
  Future<void> create({
    required NewAltokeEntity newAltokeEntity,
  }) async {
    if (newAltokeEntity.name.isEmpty) {
      throw const CreateAltokeEntityFailureEmptyName();
    }
    await database.writeTxn(
      () async => altokeEntitiesCollection.put(
        newAltokeEntity.toIsar(),
      ),
    );
  }

  @override
  Future<void> insert({
    required AltokeEntity altokeEntity,
  }) async {
    await database.writeTxn(
      () async => altokeEntitiesCollection.put(altokeEntity.toIsar()),
    );
  }

  @override
  Future<AltokeEntity?> getById(
    int altokeEntityId,
  ) async {
    final isarAltokeEntity = await altokeEntitiesCollection.get(altokeEntityId);
    return isarAltokeEntity?.toAltokeEntity();
  }

  @override
  Stream<Iterable<AltokeEntity>> watch({
    String? searchTerm,
  }) {
    final query = altokeEntitiesCollection
        .filter()
        .contentMatches(searchTerm)
        .sortByName();
    return query
        .watch(fireImmediately: true)
        .map(altokeEntitiesFromIsarAltokeEntities)
        .distinct(altokeEntitiesEqualityChecker.equals);
  }

  @override
  Stream<int> watchCount({
    String? searchTerm,
  }) {
    return altokeEntitiesCollection
        .filter()
        .contentMatches(searchTerm)
        .watch(fireImmediately: true)
        .map((tasks) => tasks.length);
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
    await database.writeTxn(
      () async {
        final isarAltokeEntity =
            await altokeEntitiesCollection.get(altokeEntityId);
        if (isarAltokeEntity == null) return;
        await altokeEntitiesCollection.put(
          isarAltokeEntity.copyWithAppliedPartial(partialAltokeEntity),
        );
      },
    );
  }

  @override
  Future<AltokeEntity?> deleteById(
    int altokeEntityId,
  ) async {
    final isarAltokeEntity = await altokeEntitiesCollection.get(altokeEntityId);
    if (isarAltokeEntity == null) return null;
    await database.writeTxn(
      () async => altokeEntitiesCollection.delete(altokeEntityId),
    );
    return isarAltokeEntity.toAltokeEntity();
  }

  @override
  Future<void> deleteAll({
    PartialAltokeEntity? referenceAltokeEntity,
  }) async {
    final query =
        altokeEntitiesCollection.filter().matchesPartial(referenceAltokeEntity);
    await database.writeTxn(
      () async => query.deleteAll(),
    );
  }
}
