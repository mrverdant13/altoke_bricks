import 'package:altoke_common/common.dart';
import 'package:altoke_entity/altoke_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hive_altoke_entity.g.dart';

/// {@template altoke_entities_hive_storage.hive_altoke_entity}
/// A Hive representation of an Altoke Entity.
/// {@endtemplate}
@JsonSerializable()
class HiveAltokeEntity {
  /// {@macro altoke_entities_hive_storage.hive_altoke_entity}
  const HiveAltokeEntity({
    required this.name,
    this.description,
  });

  /// Creates a [HiveAltokeEntity] from its JSON representation.
  factory HiveAltokeEntity.fromJson(Map<dynamic, dynamic> json) =>
      _$HiveAltokeEntityFromJson(json);

  /// JSON key for the name of a Hive Altoke Entity.
  static const nameJsonKey = 'name';

  /// JSON key for the description of a Hive Altoke Entity.
  static const descriptionJsonKey = 'description';

  /// The name of this altoke entity.
  @JsonKey(name: HiveAltokeEntity.nameJsonKey)
  final String name;

  /// The description of this altoke entity.
  @JsonKey(name: HiveAltokeEntity.descriptionJsonKey)
  final String? description;

  /// Converts this [HiveAltokeEntity] to its JSON representation.
  Json toJson() => _$HiveAltokeEntityToJson(this);

  /// Converts this [HiveAltokeEntity] to a [AltokeEntity].
  AltokeEntity toAltokeEntityWithId(int id) {
    return AltokeEntity(
      id: id,
      name: name,
      description: description,
    );
  }

  /// Applies the [partialAltokeEntity] to this [HiveAltokeEntity].
  HiveAltokeEntity copyWithAppliedPartial(
    PartialAltokeEntity partialAltokeEntity,
  ) {
    var hiveAltokeEntity = this;
    if (partialAltokeEntity.name case Some(value: final name)) {
      hiveAltokeEntity = HiveAltokeEntity(
        name: name.trim(),
        description: hiveAltokeEntity.description,
      );
    }
    if (partialAltokeEntity.description case Some(value: final description)) {
      hiveAltokeEntity = HiveAltokeEntity(
        name: hiveAltokeEntity.name,
        description: switch (description?.trim()) {
          null => null,
          String(:final isEmpty) when isEmpty => null,
          final description => description.trim(),
        },
      );
    }
    return hiveAltokeEntity;
  }
}

/// An extension on [AltokeEntity] to add mapping capabilities.
extension MappableAltokeEntity on AltokeEntity {
  /// Converts this [AltokeEntity] to a [HiveAltokeEntity].
  ///
  /// **NOTE:** The [id] is ignored in the conversion.
  HiveAltokeEntity toHive() {
    return HiveAltokeEntity(
      name: name,
      description: description,
    );
  }

  /// Converts this [AltokeEntity] to its Hive JSON representation.
  ///
  /// **NOTE:** The [id] is ignored in the conversion.
  Json toHiveJson() {
    return toHive().toJson();
  }
}

/// An extension on [NewAltokeEntity] to add mapping capabilities.
extension MappableNewAltokeEntity on NewAltokeEntity {
  /// Converts this [NewAltokeEntity] to a [HiveAltokeEntity].
  HiveAltokeEntity toHive() {
    return HiveAltokeEntity(
      name: name,
      description: description,
    );
  }

  /// Converts this [NewAltokeEntity] to its Hive JSON representation.
  Json toHiveJson() {
    return toHive().toJson();
  }
}

/// An altoke entity entry.
typedef AltokeEntityEntry = MapEntry<dynamic, Map<dynamic, dynamic>>;

/// An extension on [AltokeEntityEntry] to add mapping capabilities.
extension ExtendedAltokeEntityEntry on AltokeEntityEntry {
  /// Converts this [AltokeEntityEntry] to a [AltokeEntity].
  AltokeEntity toAltokeEntity() {
    return HiveAltokeEntity.fromJson(value).toAltokeEntityWithId(key as int);
  }
}
