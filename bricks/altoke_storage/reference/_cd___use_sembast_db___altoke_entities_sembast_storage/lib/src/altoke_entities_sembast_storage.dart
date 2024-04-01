import 'package:altoke_common/common.dart';
import 'package:altoke_entities_sembast_storage/altoke_entities_sembast_storage.dart';
import 'package:altoke_entities_storage/altoke_entities_storage.dart';
import 'package:altoke_entity/altoke_entity.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:sembast/sembast.dart';

/// {@template altoke_entities_sembast_storage}
/// A persistent [AltokeEntitiesStorage] implementation using Sembast.
/// {@endtemplate}
class AltokeEntitiesSembastStorage implements AltokeEntitiesStorage {
  /// {@macro altoke_entities_sembast_storage}
  AltokeEntitiesSembastStorage({
    required this.database,
  });

  /// Store name for the altoke entities.
  @visibleForTesting
  static const storeName = '<altoke-entities-sembast-storage>';

  /// Store reference for the altoke entities.
  @visibleForTesting
  late final AltokeEntitiesStoreRef store = StoreRef(storeName);

  /// The Sembast database.
  @visibleForTesting
  final Database database;

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
    await store.addNewAltokeEntity(database, newAltokeEntity);
  }

  @override
  Future<void> insert({
    required AltokeEntity altokeEntity,
  }) async {
    await store.putAltokeEntity(database, altokeEntity);
  }

  @override
  Future<AltokeEntity?> getById(
    int altokeEntityId,
  ) async {
    return store.getAltokeEntityById(database, altokeEntityId);
  }

  @override
  Stream<Iterable<AltokeEntity>> watch({
    String? searchTerm,
  }) {
    final dbFilter = AltokeEntitiesFilter.matchesContent(searchTerm);
    return store
        .watchAltokeEntities(database, where: dbFilter)
        .distinct(altokeEntitiesEqualityChecker.equals);
  }

  @override
  Stream<int> watchCount({
    String? searchTerm,
  }) {
    final dbFilter = AltokeEntitiesFilter.matchesContent(searchTerm);
    return store.watchCount(database, where: dbFilter);
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
    await store.updateWithPartialAltokeEntity(
      database,
      id: altokeEntityId,
      partialAltokeEntity: partialAltokeEntity,
    );
  }

  @override
  Future<AltokeEntity?> deleteById(
    int altokeEntityId,
  ) async {
    return store.deleteAltokeEntityById(database, altokeEntityId);
  }

  @override
  Future<void> deleteAll({
    PartialAltokeEntity? referenceAltokeEntity,
  }) async {
    final dbFilter = AltokeEntitiesFilter.matchesPartial(referenceAltokeEntity);
    await store.deleteAllAltokeEntities(database, where: dbFilter);
  }
}
