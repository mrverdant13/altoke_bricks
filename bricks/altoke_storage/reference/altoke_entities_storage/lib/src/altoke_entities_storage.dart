import 'package:altoke_entities_storage/altoke_entities_storage.dart';
import 'package:altoke_entity/altoke_entity.dart';

/// {@template altoke_entities_storage}
/// An interface for a persistent storage of Altoke Entities.
/// {@endtemplate}
abstract interface class AltokeEntitiesStorage {
  /// Creates a new altoke entity.
  ///
  /// Throws a [CreateAltokeEntityFailure] if the altoke entity fails to be
  /// created.
  Future<void> create({
    required NewAltokeEntity newAltokeEntity,
  });

  /// Inserts an altoke entity.
  Future<void> insert({
    required AltokeEntity altokeEntity,
  });

  /// Retrieves an altoke entity by its ID.
  Future<AltokeEntity?> getById(
    int altokeEntityId,
  );

  /// Returns a stream of the altoke entities that match the given [searchTerm].
  Stream<Iterable<AltokeEntity>> watch({
    String? searchTerm,
  });

  /// Returns the number of altoke entities that match the given
  /// [searchTerm].
  Stream<int> watchCount({
    String? searchTerm,
  });

  /// Updates an altoke entity identified by its [altokeEntityId] with the given
  /// [partialAltokeEntity].
  ///
  /// Throws an [UpdateAltokeEntityFailure] if the altoke entity fails to be
  /// updated.
  Future<void> update({
    required int altokeEntityId,
    required PartialAltokeEntity partialAltokeEntity,
  });

  /// Deletes an altoke entity identified by its [altokeEntityId].
  Future<AltokeEntity?> deleteById(
    int altokeEntityId,
  );

  /// Deletes all altoke entities that match the given [referenceAltokeEntity].
  Future<void> deleteAll({
    PartialAltokeEntity? referenceAltokeEntity,
  });
}
