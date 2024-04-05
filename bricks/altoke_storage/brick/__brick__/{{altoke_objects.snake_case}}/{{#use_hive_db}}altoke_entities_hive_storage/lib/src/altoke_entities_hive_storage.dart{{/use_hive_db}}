import 'package:altoke_common/common.dart';
import 'package:altoke_entities_hive_storage/altoke_entities_hive_storage.dart';
import 'package:altoke_entities_storage/altoke_entities_storage.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

/// {@template altoke_entities_hive_storage}
/// A persistent [AltokeEntitiesStorage] implementation using Hive.
/// {@endtemplate}
class AltokeEntitiesHiveStorage implements AltokeEntitiesStorage {
  /// {@macro altoke_entities_hive_storage}
  AltokeEntitiesHiveStorage();

  /// Name for the altoke entities altokeEntitiesBox.
  static const altokeEntitiesBoxName = '.altoke-entities-hive-storage.';

  /// Box for the altoke entities.
  @visibleForTesting
  final Future<AltokeEntitiesBox> asyncAltokeEntitiesBox =
      Hive.openBox(altokeEntitiesBoxName);

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
    final altokeEntitiesBox = await asyncAltokeEntitiesBox;
    await altokeEntitiesBox.addNewAltokeEntity(newAltokeEntity);
  }

  @override
  Future<void> insert({
    required AltokeEntity altokeEntity,
  }) async {
    final altokeEntitiesBox = await asyncAltokeEntitiesBox;
    await altokeEntitiesBox.putAltokeEntity(altokeEntity);
  }

  @override
  Future<AltokeEntity?> getById(
    int altokeEntityId,
  ) async {
    final altokeEntitiesBox = await asyncAltokeEntitiesBox;
    return altokeEntitiesBox.getAltokeEntityById(altokeEntityId);
  }

  @override
  Stream<Iterable<AltokeEntity>> watch({
    String? searchTerm,
  }) async* {
    final dbFilter = AltokeEntitiesFilter.matchesContent(searchTerm);
    final altokeEntitiesBox = await asyncAltokeEntitiesBox;
    yield* () async* {
      yield altokeEntitiesBox.getAltokeEntities(where: dbFilter);
      yield* altokeEntitiesBox
          .watch()
          .map((_) => altokeEntitiesBox.getAltokeEntities(where: dbFilter));
    }()
        .distinct(altokeEntitiesEqualityChecker.equals);
  }

  @override
  Stream<int> watchCount({
    String? searchTerm,
  }) async* {
    final dbFilter = AltokeEntitiesFilter.matchesContent(searchTerm);
    final altokeEntitiesBox = await asyncAltokeEntitiesBox;
    yield* () async* {
      yield altokeEntitiesBox.getCount(where: dbFilter);
      yield* altokeEntitiesBox
          .watch()
          .map((_) => altokeEntitiesBox.getCount(where: dbFilter));
    }()
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
    final altokeEntitiesBox = await asyncAltokeEntitiesBox;
    return altokeEntitiesBox.updateWithPartialAltokeEntity(
      id: altokeEntityId,
      partialAltokeEntity: partialAltokeEntity,
    );
  }

  @override
  Future<AltokeEntity?> deleteById(
    int altokeEntityId,
  ) async {
    final altokeEntitiesBox = await asyncAltokeEntitiesBox;
    return altokeEntitiesBox.deleteAltokeEntityById(altokeEntityId);
  }

  @override
  Future<void> deleteAll({
    PartialAltokeEntity? referenceAltokeEntity,
  }) async {
    final altokeEntitiesBox = await asyncAltokeEntitiesBox;
    final filter = AltokeEntitiesFilter.matchesPartial(referenceAltokeEntity);
    if (filter == null) {
      await altokeEntitiesBox.clear();
      return;
    }
    await altokeEntitiesBox.deleteAllAltokeEntities(where: filter);
  }

  /// Frees up resources used by the storage.
  Future<void> dispose() async {
    final altokeEntitiesBox = await asyncAltokeEntitiesBox;
    await altokeEntitiesBox.close();
  }
}
