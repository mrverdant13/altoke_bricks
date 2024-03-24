import 'package:altoke_common/common.dart';
import 'package:meta/meta.dart';

/// {@template altoke_entity.altoke_entity}
/// Altoke entity.
/// {@endtemplate}
@immutable
class AltokeEntity {
  /// {@macro altoke_entity.altoke_entity}
  const AltokeEntity({
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

  @override
  String toString() =>
      'AltokeEntity(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(covariant AltokeEntity other) {
    if (identical(this, other)) return true;
    return other.id == id &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ id.hashCode ^ name.hashCode ^ description.hashCode;
}

/// {@template altoke_entity.new_altoke_entity}
/// A new altoke entity.
/// {@endtemplate}
@immutable
class NewAltokeEntity {
  /// {@macro altoke_entity.new_altoke_entity}
  const NewAltokeEntity({
    required this.name,
    this.description,
  });

  /// The name of the new altoke entity.
  final String name;

  /// The description of the new altoke entity.
  final String? description;

  @override
  String toString() =>
      'NewAltokeEntity(name: $name, description: $description)';

  @override
  bool operator ==(covariant NewAltokeEntity other) {
    if (identical(this, other)) return true;
    return other.name == name && other.description == description;
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ name.hashCode ^ description.hashCode;
}

/// {@template altoke_entity.partial_altoke_entity}
/// A partial altoke entity.
/// {@endtemplate}
@immutable
class PartialAltokeEntity {
  /// {@macro altoke_entity.partial_altoke_entity}
  const PartialAltokeEntity({
    this.name = const Optional.none(),
    this.description = const Optional.none(),
  });

  /// The optional name for the altoke entity.
  final Optional<String> name;

  /// The optional description for the altoke entity.
  final Optional<String?> description;

  @override
  String toString() =>
      'PartialAltokeEntity(name: $name, description: $description)';

  @override
  bool operator ==(covariant PartialAltokeEntity other) {
    if (identical(this, other)) return true;
    return other.name == name && other.description == description;
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ name.hashCode ^ description.hashCode;
}
