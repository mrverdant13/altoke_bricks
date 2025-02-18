/*remove-start*/
//
// ignore_for_file: unnecessary_import
/*remove-end*/

import 'package:altoke_common/common.dart';
/*{{#use_dart_mappable}}*/
import 'package:dart_mappable/dart_mappable.dart';
/*{{/use_dart_mappable}}*/

/*{{#use_equatable}}*/
import 'package:equatable/equatable.dart';
/*{{/use_equatable}}*/

/*{{#use_freezed}}*/
import 'package:freezed_annotation/freezed_annotation.dart';
/*{{/use_freezed}}*/

/*{{#use_meta}}*/
import 'package:meta/meta.dart'; /*{{/use_meta}}*/

/*{{#use_freezed}}*/
part 'altoke_entity.freezed.dart';
/*{{/use_freezed}}*/
/*{{#use_dart_mappable}}*/
part 'altoke_entity.mapper.dart';
/*{{/use_dart_mappable}}*/

/*{{#use_dart_mappable}}*/
/// {@template altoke_entity.altoke_entity}
/// Altoke entity.
/// {@endtemplate}
@MappableClass()
@immutable
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
@immutable
class DmNewAltokeEntity with DmNewAltokeEntityMappable {
  /// {@macro altoke_entity.new_altoke_entity}
  const DmNewAltokeEntity({required this.name, this.description});

  /// The name of the new altoke entity.
  final String name;

  /// The description of the new altoke entity.
  final String? description;
}

/// {@template altoke_entity.partial_altoke_entity}
/// A partial altoke entity.
/// {@endtemplate}
@MappableClass()
@immutable
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

/*{{/use_dart_mappable}}*/

/*{{#use_equatable}}*/
/// {@template altoke_entity.altoke_entity}
/// Altoke entity.
/// {@endtemplate}
class EAltokeEntity extends Equatable {
  /// {@macro altoke_entity.altoke_entity}
  const EAltokeEntity({required this.id, required this.name, this.description});

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
  const ENewAltokeEntity({required this.name, this.description});

  /// The name of the new altoke entity.
  final String name;

  /// The description of the new altoke entity.
  final String? description;

  @override
  List<Object?> get props => [name, description];

  /// Returns a copy of this [ENewAltokeEntity] with the given fields replaced
  /// by the new values.
  ENewAltokeEntity copyWith({String? name, String? Function()? description}) {
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
/*{{/use_equatable}}*/

/*{{#use_freezed}}*/
/// {@template altoke_entity.altoke_entity}
/// Altoke entity.
/// {@endtemplate}
@freezed
class FAltokeEntity with _$FAltokeEntity {
  /// {@macro altoke_entity.altoke_entity}
  const factory FAltokeEntity({
    /// The ID of this altoke entity.
    required int id,

    /// The name of this altoke entity.
    required String name,

    /// The description of this altoke entity.
    String? description,
  }) = _FAltokeEntity;
}

/// {@template altoke_entity.new_altoke_entity}
/// A new altoke entity.
/// {@endtemplate}
@freezed
class FNewAltokeEntity with _$FNewAltokeEntity {
  /// {@macro altoke_entity.new_altoke_entity}
  const factory FNewAltokeEntity({
    /// The name of the new altoke entity.
    required String name,

    /// The description of the new altoke entity.
    String? description,
  }) = _FNewAltokeEntity;
}

/// {@template altoke_entity.partial_altoke_entity}
/// A partial altoke entity.
/// {@endtemplate}
@freezed
class FPartialAltokeEntity with _$FPartialAltokeEntity {
  /// {@macro altoke_entity.partial_altoke_entity}
  const factory FPartialAltokeEntity({
    /// The optional name for the altoke entity.
    @Default(FOptional<String>.none()) FOptional<String> name,

    /// The optional description for the altoke entity.
    @Default(FOptional<String?>.none()) FOptional<String?> description,
  }) = _FPartialAltokeEntity;
}
/*{{/use_freezed}}*/

/*{{#use_overrides}}*/
/// {@template altoke_entity.altoke_entity}
/// Altoke entity.
/// {@endtemplate}
@immutable
class AltokeEntity {
  /// {@macro altoke_entity.altoke_entity}
  const AltokeEntity({required this.id, required this.name, this.description});

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

  /// Returns a copy of this [AltokeEntity] with the given fields replaced by
  /// the new values.
  AltokeEntity copyWith({
    int? id,
    String? name,
    String? Function()? description,
  }) {
    return AltokeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: (description ?? () => this.description)(),
    );
  }
}

/// {@template altoke_entity.new_altoke_entity}
/// A new altoke entity.
/// {@endtemplate}
@immutable
class NewAltokeEntity {
  /// {@macro altoke_entity.new_altoke_entity}
  const NewAltokeEntity({required this.name, this.description});

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

  /// Returns a copy of this [NewAltokeEntity] with the given fields replaced
  /// by the new values.
  NewAltokeEntity copyWith({String? name, String? Function()? description}) {
    return NewAltokeEntity(
      name: name ?? this.name,
      description: (description ?? () => this.description)(),
    );
  }
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

  /// Returns a copy of this [PartialAltokeEntity] with the given fields
  /// replaced by the new values.
  PartialAltokeEntity copyWith({
    Optional<String>? name,
    Optional<String?>? description,
  }) {
    return PartialAltokeEntity(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}

/*{{/use_overrides}}*/
