import 'package:altoke_common/common.dart';
import 'package:equatable/equatable.dart';

/// {@template altoke_entity.altoke_entity}
/// Altoke entity.
/// {@endtemplate}
class EAltokeEntity extends Equatable {
  /// {@macro altoke_entity.altoke_entity}
  const EAltokeEntity({
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
  List<Object?> get props => [id, name, description];

  /// Returns a copy of this [EAltokeEntity] with the given fields replaced by
  /// the new values.
  EAltokeEntity copyWith({
    int? id,
    String? name,
    String? Function()? description,
  }) {
    return EAltokeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: (description ?? () => this.description)(),
    );
  }
}

/// {@template altoke_entity.new_altoke_entity}
/// A new altoke entity.
/// {@endtemplate}
class ENewAltokeEntity extends Equatable {
  /// {@macro altoke_entity.new_altoke_entity}
  const ENewAltokeEntity({
    required this.name,
    this.description,
  });

  /// The name of the new altoke entity.
  final String name;

  /// The description of the new altoke entity.
  final String? description;

  @override
  List<Object?> get props => [name, description];

  /// Returns a copy of this [ENewAltokeEntity] with the given fields replaced
  /// by the new values.
  ENewAltokeEntity copyWith({
    String? name,
    String? Function()? description,
  }) {
    return ENewAltokeEntity(
      name: name ?? this.name,
      description: (description ?? () => this.description)(),
    );
  }
}

/// {@template altoke_entity.partial_altoke_entity}
/// A partial altoke entity.
/// {@endtemplate}
class EPartialAltokeEntity extends Equatable {
  /// {@macro altoke_entity.partial_altoke_entity}
  const EPartialAltokeEntity({
    this.name = const EOptional.none(),
    this.description = const EOptional.none(),
  });

  /// The optional name for the altoke entity.
  final EOptional<String> name;

  /// The optional description for the altoke entity.
  final EOptional<String?> description;

  @override
  List<Object> get props => [name, description];

  /// Returns a copy of this [EPartialAltokeEntity] with the given fields
  /// replaced by the new values.
  EPartialAltokeEntity copyWith({
    EOptional<String>? name,
    EOptional<String?>? description,
  }) {
    return EPartialAltokeEntity(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
