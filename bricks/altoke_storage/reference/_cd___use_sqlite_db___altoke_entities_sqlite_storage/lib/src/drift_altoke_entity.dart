import 'package:altoke_entities_sqlite_storage/altoke_entities.drift.dart'
    as drift;
import 'package:altoke_entity/altoke_entity.dart';

/// A SQLite data class for Altoke Entities.
typedef DriftAltokeEntity = drift.AltokeEntity;

/// An extension on [DriftAltokeEntity] to add mapping capabilities.
extension MappableDriftAltokeEntity on DriftAltokeEntity {
  /// Converts this [DriftAltokeEntity] to an [AltokeEntity].
  AltokeEntity toAltokeEntity() {
    return AltokeEntity(
      id: id,
      name: name,
      description: description,
    );
  }
}

/// An [Iterable] of [DriftAltokeEntity]s.
typedef DriftAltokeEntitiesIterable = Iterable<DriftAltokeEntity>;

/// Converts an [DriftAltokeEntity] to a [AltokeEntity]s.
AltokeEntity altokeEntityFromDriftAltokeEntity(
  DriftAltokeEntity driftAltokeEntity,
) {
  return driftAltokeEntity.toAltokeEntity();
}

/// Converts an [DriftAltokeEntitiesIterable] to a list of [AltokeEntity]s.
List<AltokeEntity> altokeEntitiesFromDriftAltokeEntities(
  DriftAltokeEntitiesIterable driftAltokeEntities,
) {
  return driftAltokeEntities.map(altokeEntityFromDriftAltokeEntity).toList();
}
