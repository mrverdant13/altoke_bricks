import 'package:altoke_common/common.dart';
import 'package:altoke_entity/altoke_entity.dart';
import 'package:isar/isar.dart';

part 'isar_altoke_entity.g.dart';

/// An Isar representation of an Altoke Entity.
@Collection(accessor: 'isarAltokeEntities')
class IsarAltokeEntity {
  /// The ID of this altoke entity.
  late Id id = Isar.autoIncrement;

  /// The name of this altoke entity.
  late String name;

  /// The description of this altoke entity.
  late String? description;

  /// Converts this [IsarAltokeEntity] to an [AltokeEntity].
  AltokeEntity toAltokeEntity() {
    return AltokeEntity(
      id: id,
      name: name,
      description: description,
    );
  }

  /// Applies the [partialAltokeEntity] to this [IsarAltokeEntity].
  IsarAltokeEntity copyWithAppliedPartial(
    PartialAltokeEntity partialAltokeEntity,
  ) {
    final isarAltokeEntity = IsarAltokeEntity()..id = id;
    if (partialAltokeEntity.name case Some(value: final name)) {
      isarAltokeEntity.name = name.trim();
    }
    if (partialAltokeEntity.description case Some(value: final description)) {
      isarAltokeEntity.description = switch (description?.trim()) {
        null => null,
        String(:final isEmpty) when isEmpty => null,
        final description => description.trim(),
      };
    }
    return isarAltokeEntity;
  }
}

/// An extension on [AltokeEntity] to add mapping capabilities.
extension MappableAltokeEntity on AltokeEntity {
  /// Converts this [AltokeEntity] to a [IsarAltokeEntity].
  IsarAltokeEntity toIsar() {
    return IsarAltokeEntity()
      ..id = id
      ..name = name
      ..description = description;
  }
}

/// An extension on [NewAltokeEntity] to add mapping capabilities.
extension MappableNewAltokeEntity on NewAltokeEntity {
  /// Converts this [NewAltokeEntity] to a [IsarAltokeEntity].
  IsarAltokeEntity toIsar() {
    return IsarAltokeEntity()
      ..name = name
      ..description = description;
  }
}

/// An [Iterable] of [IsarAltokeEntity]s.
typedef IsarTasksIterable = Iterable<IsarAltokeEntity>;

/// Converts an [IsarAltokeEntity] to a [AltokeEntity]s.
AltokeEntity altokeEntityFromIsarTask(IsarAltokeEntity isarAltokeEntity) {
  return isarAltokeEntity.toAltokeEntity();
}

/// Converts an [IsarTasksIterable] to a list of [AltokeEntity]s.
List<AltokeEntity> tasksFromIsarTasks(IsarTasksIterable isarAltokeEntities) {
  return isarAltokeEntities.map(altokeEntityFromIsarTask).toList();
}
