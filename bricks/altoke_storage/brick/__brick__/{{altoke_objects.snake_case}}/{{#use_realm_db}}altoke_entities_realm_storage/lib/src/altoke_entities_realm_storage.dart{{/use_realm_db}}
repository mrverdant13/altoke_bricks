import 'package:altoke_common/common.dart';
import 'package:altoke_entities_realm_storage/src/altoke_entities_filter.dart';
import 'package:altoke_entities_realm_storage/src/realm_{{object.snakeCase()}}.dart';
import 'package:altoke_entities_storage/altoke_entities_storage.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:realm/realm.dart';

/// {@template altoke_entities_realm_storage}
/// A persistent [AltokeEntitiesStorage] implementation using Realm.
/// {@endtemplate}
class AltokeEntitiesRealmStorage implements AltokeEntitiesStorage {
  /// {@macro altoke_entities_realm_storage}
  AltokeEntitiesRealmStorage({
    required this.database,
  });

  /// The Realm database.
  @visibleForTesting
  final Realm database;

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
    await database.write(() async {
      final latestAltokeEntityId = database
              .query<RealmAltokeEntity>('id != 0 SORT(id DESC) LIMIT(1)')
              .firstOrNull
              ?.id ??
          0;
      final newId = latestAltokeEntityId + 1;
      database.add<RealmAltokeEntity>(newAltokeEntity.toRealmWithId(newId));
    });
  }

  @override
  Future<void> insert({
    required AltokeEntity altokeEntity,
  }) async {
    await database.write(() async {
      database.add<RealmAltokeEntity>(
        altokeEntity.toRealm(),
        update: true,
      );
    });
  }

  @override
  Future<AltokeEntity?> getById(
    int altokeEntityId,
  ) async {
    final realmAltokeEntity = database.find<RealmAltokeEntity>(altokeEntityId);
    return realmAltokeEntity?.toAltokeEntity();
  }

  @override
  Stream<List<AltokeEntity>> watch({
    String? searchTerm,
  }) {
    final queryExpression = AltokeEntitiesFilter.matchesContent(searchTerm);
    final filteredAltokeEntitiesQuery = switch (queryExpression) {
      String() => database.query<RealmAltokeEntity>(
          '$queryExpression SORT(name ASC)',
        ),
      null => database.query<RealmAltokeEntity>(
          // cspell:disable-next-line
          'TRUEPREDICATE SORT(name ASC)',
        ),
    };
    return filteredAltokeEntitiesQuery.changes
        .asBroadcastStream()
        .map((changes) => changes.results)
        .map(altokeEntitiesFromRealmAltokeEntities)
        .distinct(altokeEntitiesEqualityChecker.equals);
  }

  @override
  Stream<int> watchCount({
    String? searchTerm,
  }) {
    final queryExpression = AltokeEntitiesFilter.matchesContent(searchTerm);
    final allAltokeEntitiesQuery = database.all<RealmAltokeEntity>();
    final filteredAltokeEntitiesQuery = queryExpression == null
        ? allAltokeEntitiesQuery
        : allAltokeEntitiesQuery.query(queryExpression);
    return filteredAltokeEntitiesQuery.changes
        .map((changes) => changes.results.length)
        .distinct();
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
    final existingAltokeEntity =
        database.find<RealmAltokeEntity>(altokeEntityId);
    if (existingAltokeEntity == null) return;
    await database.write(() async {
      database.add(
        existingAltokeEntity.copyWithAppliedPartial(partialAltokeEntity),
        update: true,
      );
    });
  }

  @override
  Future<AltokeEntity?> deleteById(
    int altokeEntityId,
  ) async {
    final existingRealmAltokeEntity =
        database.find<RealmAltokeEntity>(altokeEntityId);
    if (existingRealmAltokeEntity == null) return null;
    final existingAltokeEntity = existingRealmAltokeEntity.toAltokeEntity();
    await database.write(() async {
      database.delete<RealmAltokeEntity>(existingRealmAltokeEntity);
    });
    return existingAltokeEntity;
  }

  @override
  Future<void> deleteAll({
    PartialAltokeEntity? referenceAltokeEntity,
  }) async {
    final queryExpression =
        AltokeEntitiesFilter.matchesPartial(referenceAltokeEntity);
    if (queryExpression == null) {
      await database.write(() async {
        database.deleteAll<RealmAltokeEntity>();
      });
      return;
    }
    await database.write(() async {
      final matchingAltokeEntities =
          database.all<RealmAltokeEntity>().query(queryExpression);
      database.deleteMany<RealmAltokeEntity>(matchingAltokeEntities);
    });
  }
}
