import 'package:altoke_objects_storage/altoke_objects_storage.dart';

/*remove-start*/
part 'altoke_object.dart';
/*remove-end*/
/*w 1v w*/

/// {@template altoke_objects_storage}
/// An interface for a persistent storage of Altoke Objects.
/// {@endtemplate}
abstract interface class AltokeObjectsStorage {
  /// Creates a new altoke object.
  ///
  /// Throws a [CreateAltokeObjectFailure] if the altoke object fails to be
  /// created.
  Future<void> create({
    required NewAltokeObject newAltokeObject,
  });

  /// Inserts an altoke object.
  Future<void> insert({
    required AltokeObject altokeObject,
  });

  /// Retrieves an altoke object by its ID.
  Future<AltokeObject?> getById(
    int altokeObjectId,
  );

  /// Returns a stream of the altoke objects that match the given [searchTerm].
  Stream<List<AltokeObject>> watch({
    String? searchTerm,
  });

  /// Returns the number of altoke objects that match the given
  /// [searchTerm].
  Stream<int> watchCount({
    String? searchTerm,
  });

  /// Updates an altoke object identified by its [altokeObjectId] with the given
  /// [partialAltokeObject].
  ///
  /// Throws an [UpdateAltokeObjectFailure] if the altoke object fails to be
  /// updated.
  Future<void> update({
    required int altokeObjectId,
    required PartialAltokeObject partialAltokeObject,
  });

  /// Deletes an altoke object identified by its [altokeObjectId].
  Future<AltokeObject?> deleteById(
    int altokeObjectId,
  );

  /// Deletes all altoke objects that match the given [referenceAltokeObject].
  Future<void> deleteAll({
    PartialAltokeObject? referenceAltokeObject,
  });
}
