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
  Map<String, dynamic> toJson() => _$HiveAltokeEntityToJson(this);

  /// Converts this [HiveAltokeEntity] to a [AltokeEntity].
  AltokeEntity toEntityWithId(int id) {
    return AltokeEntity(
      id: id,
      name: name,
      description: description,
    );
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
}

/// {@template altoke_entities_hive_storage.hive_partial_altoke_entity}
/// A Hive representation of a partial Altoke Entity.
/// {@endtemplate}
class HivePartialAltokeEntity {
  /// {@macro altoke_entities_hive_storage.hive_partial_altoke_entity}
  const HivePartialAltokeEntity({
    this.name = const Optional.none(),
    this.description = const Optional.none(),
  });

  /// Creates a [HivePartialAltokeEntity] from a [PartialAltokeEntity].
  factory HivePartialAltokeEntity.fromEntity(
    PartialAltokeEntity partialAltokeEntity,
  ) {
    return HivePartialAltokeEntity(
      name: partialAltokeEntity.name,
      description: partialAltokeEntity.description,
    );
  }

  /// The name for the altoke entity.
  final Optional<String> name;

  /// The description for the altoke entity.
  final Optional<String?> description;

  /// Converts this [HivePartialAltokeEntity] to its JSON representation.
  Json toJson() {
    return {
      if (name case Some(:final value)) HiveAltokeEntity.nameJsonKey: value,
      if (description case Some(:final value))
        HiveAltokeEntity.descriptionJsonKey: value,
    };
  }

  /// Converts this [HivePartialAltokeEntity] to a filter callback for Hive.
  WhereCallback<AltokeEntity> toFilter() {
    final nameMatches = switch (name) {
      None() => (_) => true,
      Some(value: final nameFragment) => switch (nameFragment.trim()) {
          String(:final isEmpty) when isEmpty => (_) => true,
          final nameFragment => (AltokeEntity altokeEntity) =>
              altokeEntity.name.contains(nameFragment),
        },
    };
    final descriptionMatches = switch (description) {
      None() => (_) => true,
      Some(value: final descriptionFragment) => switch (
            descriptionFragment?.trim()) {
          null => (AltokeEntity altokeEntity) =>
              altokeEntity.description == null,
          String(:final isEmpty) when isEmpty => (AltokeEntity altokeEntity) =>
              altokeEntity.description != null,
          final descriptionFragment => (AltokeEntity altokeEntity) =>
              switch (altokeEntity.description) {
                null => false,
                final description => description.contains(descriptionFragment),
              },
        },
    };
    return (altokeEntity) =>
        nameMatches(altokeEntity) && descriptionMatches(altokeEntity);
  }
}

/// An extension on [PartialAltokeEntity] to add mapping capabilities.
extension MappablePartialAltokeEntity on PartialAltokeEntity {
  /// Converts this [PartialAltokeEntity] to a [HivePartialAltokeEntity].
  HivePartialAltokeEntity toHive() => HivePartialAltokeEntity.fromEntity(this);
}
