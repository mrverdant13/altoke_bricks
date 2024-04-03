import 'package:altoke_common/common.dart';
import 'package:altoke_entity/altoke_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sembast/sembast.dart';

part 'sembast_altoke_entity.g.dart';

/// {@template altoke_entities_sembast_storage.sembast_altoke_entity}
/// A Sembast representation of an Altoke Entity.
/// {@endtemplate}
@JsonSerializable()
class SembastAltokeEntity {
  /// {@macro altoke_entities_sembast_storage.sembast_altoke_entity}
  const SembastAltokeEntity({
    required this.name,
    this.description,
  });

  /// Creates a [SembastAltokeEntity] from its JSON representation.
  factory SembastAltokeEntity.fromJson(Map<dynamic, dynamic> json) =>
      _$SembastAltokeEntityFromJson(json);

  /// JSON key for the name of a Sembast Altoke Entity.
  static const nameJsonKey = 'name';

  /// JSON key for the description of a Sembast Altoke Entity.
  static const descriptionJsonKey = 'description';

  /// The name of this altoke entity.
  @JsonKey(name: SembastAltokeEntity.nameJsonKey)
  final String name;

  /// The description of this altoke entity.
  @JsonKey(name: SembastAltokeEntity.descriptionJsonKey)
  final String? description;

  /// Converts this [SembastAltokeEntity] to its JSON representation.
  Json toJson() => _$SembastAltokeEntityToJson(this);

  /// Converts this [SembastAltokeEntity] to a [AltokeEntity].
  AltokeEntity toAltokeEntityWithId(int id) {
    return AltokeEntity(
      id: id,
      name: name,
      description: description,
    );
  }
}

/// An extension on [AltokeEntity] to add mapping capabilities.
extension MappableAltokeEntity on AltokeEntity {
  /// Converts this [AltokeEntity] to a [SembastAltokeEntity].
  ///
  /// **NOTE:** The [id] is ignored in the conversion.
  SembastAltokeEntity toSembast() {
    return SembastAltokeEntity(
      name: name,
      description: description,
    );
  }

  /// Converts this [AltokeEntity] to its Sembast JSON representation.
  ///
  /// **NOTE:** The [id] is ignored in the conversion.
  Json toSembastJson() {
    return toSembast().toJson();
  }
}

/// An extension on [NewAltokeEntity] to add mapping capabilities.
extension MappableNewAltokeEntity on NewAltokeEntity {
  /// Converts this [NewAltokeEntity] to a [SembastAltokeEntity].
  SembastAltokeEntity toSembast() {
    return SembastAltokeEntity(
      name: name,
      description: description,
    );
  }

  /// Converts this [NewAltokeEntity] to its Sembast JSON representation.
  Json toSembastJson() {
    return toSembast().toJson();
  }
}

/// An extension on [PartialAltokeEntity] to add mapping capabilities.
extension MappablePartialAltokeEntity on PartialAltokeEntity {
  /// Converts this [PartialAltokeEntity] to a [SembastPartialAltokeEntity].
  SembastPartialAltokeEntity toSembast() =>
      SembastPartialAltokeEntity.fromEntity(this);

  /// Converts this [PartialAltokeEntity] to its Sembast JSON representation.
  Json toSembastJson() => toSembast().toJson();
}

/// {@template altoke_entities_sembast_storage.sembast_partial_altoke_entity}
/// A Sembast representation of a partial Altoke Entity.
/// {@endtemplate}
class SembastPartialAltokeEntity {
  /// {@macro altoke_entities_sembast_storage.sembast_partial_altoke_entity}
  const SembastPartialAltokeEntity({
    this.name = const Optional.none(),
    this.description = const Optional.none(),
  });

  /// Creates a [SembastPartialAltokeEntity] from a [PartialAltokeEntity].
  factory SembastPartialAltokeEntity.fromEntity(
    PartialAltokeEntity partialAltokeEntity,
  ) {
    return SembastPartialAltokeEntity(
      name: partialAltokeEntity.name,
      description: partialAltokeEntity.description,
    );
  }

  /// The name for the altoke entity.
  final Optional<String> name;

  /// The description for the altoke entity.
  final Optional<String?> description;

  /// Converts this [SembastPartialAltokeEntity] to its JSON representation.
  Json toJson() {
    return {
      if (name case Some(:final value)) SembastAltokeEntity.nameJsonKey: value,
      if (description case Some(:final value))
        SembastAltokeEntity.descriptionJsonKey: value,
    };
  }
}

/// A snapshot that represents an altoke entity.
typedef AltokeEntitySnapshot = RecordSnapshot<int, Json>;

/// An extension on [AltokeEntitySnapshot] to add mapping capabilities.
extension ExtendedAltokeEntitySnapshot on AltokeEntitySnapshot {
  /// Converts this [AltokeEntitySnapshot] to a [AltokeEntity].
  AltokeEntity toAltokeEntity() {
    return SembastAltokeEntity.fromJson(value).toAltokeEntityWithId(key);
  }
}

/// An [Iterable] of [AltokeEntitySnapshot]s.
typedef SembastAltokeEntitySnapshotsIterable = Iterable<AltokeEntitySnapshot>;

/// Converts an [AltokeEntitySnapshot] to a [AltokeEntity]s.
AltokeEntity altokeEntityFromSembastAltokeEntity(
  AltokeEntitySnapshot altokeEntitySnapshot,
) {
  return altokeEntitySnapshot.toAltokeEntity();
}

/// Converts an [SembastAltokeEntitySnapshotsIterable] to a list of
/// [AltokeEntity]s.
List<AltokeEntity> altokeEntitiesFromAltokeEntitiesSnapshots(
  SembastAltokeEntitySnapshotsIterable sembastAltokeEntities,
) {
  return sembastAltokeEntities
      .map(altokeEntityFromSembastAltokeEntity)
      .toList();
}
