import 'package:altoke_common/common.dart';
import 'package:altoke_entity/altoke_entity.dart';
import 'package:realm/realm.dart';

part 'realm_altoke_entity.realm.dart';

/// Realm schema for Altoke Entities.
// ignore: non_constant_identifier_names
final RealmAltokeEntitySchema = RealmAltokeEntity.schema;

/// A Realm representation of an Altoke Entity.
@RealmModel()
class _RealmAltokeEntity {
  /// The ID of this altoke entity.
  @PrimaryKey()
  late int id;

  /// The name of this altoke entity.
  late String name;

  /// The description of this altoke entity.
  late String? description;

  /// Converts this [RealmAltokeEntity] to an [AltokeEntity].
  AltokeEntity toAltokeEntity() {
    return AltokeEntity(
      id: id,
      name: name,
      description: description,
    );
  }

  /// Applies the [partialAltokeEntity] to this [RealmAltokeEntity].
  RealmAltokeEntity copyWithAppliedPartial(
    PartialAltokeEntity partialAltokeEntity,
  ) {
    final realmAltokeEntity = RealmAltokeEntity(
      id,
      name,
      description: description,
    );
    if (partialAltokeEntity.name case Some(value: final name)) {
      realmAltokeEntity.name = name.trim();
    }
    if (partialAltokeEntity.description case Some(value: final description)) {
      realmAltokeEntity.description = switch (description?.trim()) {
        null => null,
        String(:final isEmpty) when isEmpty => null,
        final description => description.trim(),
      };
    }
    return realmAltokeEntity;
  }
}

/// An extension on [AltokeEntity] to add mapping capabilities.
extension MappableAltokeEntity on AltokeEntity {
  /// Converts this [AltokeEntity] to a [RealmAltokeEntity].
  RealmAltokeEntity toRealm() {
    return RealmAltokeEntity(
      id,
      name,
      description: description,
    );
  }
}

/// An extension on [NewAltokeEntity] to add mapping capabilities.
extension MappableNewAltokeEntity on NewAltokeEntity {
  /// Converts this [NewAltokeEntity] to a [RealmAltokeEntity].
  RealmAltokeEntity toRealmWithId(int id) {
    return RealmAltokeEntity(
      id,
      name,
      description: description,
    );
  }
}

/// An [Iterable] of [RealmAltokeEntity]s.
typedef RealmAltokeEntitiesIterable = Iterable<RealmAltokeEntity>;

/// Converts a list of [RealmAltokeEntity]s to a list of [AltokeEntity]s.
List<AltokeEntity> altokeEntitiesFromRealmAltokeEntities(
  RealmAltokeEntitiesIterable realmAltokeEntities,
) {
  return [
    for (final realmAltokeEntity in realmAltokeEntities)
      realmAltokeEntity.toAltokeEntity(),
  ];
}
