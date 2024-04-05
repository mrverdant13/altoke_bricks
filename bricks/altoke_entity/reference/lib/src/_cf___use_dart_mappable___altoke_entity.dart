import 'package:altoke_common/common.dart';
import 'package:dart_mappable/dart_mappable.dart';

part '_cf___use_dart_mappable___altoke_entity.mapper.dart';

/// {@template altoke_entity.altoke_entity}
/// Altoke entity.
/// {@endtemplate}
@MappableClass()
class DmAltokeEntity with DmAltokeEntityMappable {
  /// {@macro altoke_entity.altoke_entity}
  const DmAltokeEntity({
    required this.id,
    required this.name,
    this.description,
  });

  /// The ID of this altoke entity.
  final int id;

  /// The name of this altoke entity.
  final String name;

  /// The description of this altoke entity.
  final String? description;
}

/// {@template altoke_entity.new_altoke_entity}
/// A new altoke entity.
/// {@endtemplate}
@MappableClass()
class DmNewAltokeEntity with DmNewAltokeEntityMappable {
  /// {@macro altoke_entity.new_altoke_entity}
  const DmNewAltokeEntity({
    required this.name,
    this.description,
  });

  /// The name of the new altoke entity.
  final String name;

  /// The description of the new altoke entity.
  final String? description;
}

/// {@template altoke_entity.partial_altoke_entity}
/// A partial altoke entity.
/// {@endtemplate}
@MappableClass()
class DmPartialAltokeEntity with DmPartialAltokeEntityMappable {
  /// {@macro altoke_entity.partial_altoke_entity}
  const DmPartialAltokeEntity({
    this.name = const DmOptional.none(),
    this.description = const DmOptional.none(),
  });

  /// The optional name for the altoke entity.
  final DmOptional<String> name;

  /// The optional description for the altoke entity.
  final DmOptional<String?> description;
}
