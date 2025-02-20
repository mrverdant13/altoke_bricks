import 'package:common/common.dart';{{#use_dart_mappable}}import 'package:dart_mappable/dart_mappable.dart';{{/use_dart_mappable}}{{#use_equatable}}import 'package:equatable/equatable.dart';{{/use_equatable}}{{#use_freezed}}import 'package:freezed_annotation/freezed_annotation.dart';{{/use_freezed}}{{#use_meta}}import 'package:meta/meta.dart';{{/use_meta}}{{#use_freezed}}part '{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.freezed.dart';{{/use_freezed}}{{#use_dart_mappable}}part '{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.mapper.dart';{{/use_dart_mappable}}{{#use_dart_mappable}}/// {@template {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
/// {{entity_singular.sentenceCase()}}.
/// {@endtemplate}
@MappableClass()
@immutable
class {{entity_singular.pascalCase()}} with {{entity_singular.pascalCase()}}Mappable {
  /// {@macro {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
  const {{entity_singular.pascalCase()}}({
    required this.id,
    required this.name,
    this.description,
  });

  /// The ID of this {{entity_singular.lowerCase()}}.
  final int id;

  /// The name of this {{entity_singular.lowerCase()}}.
  final String name;

  /// The description of this {{entity_singular.lowerCase()}}.
  final String? description;
}

/// {@template {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.new_{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
/// A new {{entity_singular.lowerCase()}}.
/// {@endtemplate}
@MappableClass()
@immutable
class New{{entity_singular.pascalCase()}} with New{{entity_singular.pascalCase()}}Mappable {
  /// {@macro {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.new_{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
  const New{{entity_singular.pascalCase()}}({required this.name, this.description});

  /// The name of the new {{entity_singular.lowerCase()}}.
  final String name;

  /// The description of the new {{entity_singular.lowerCase()}}.
  final String? description;
}

/// {@template {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.partial_{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
/// A partial {{entity_singular.lowerCase()}}.
/// {@endtemplate}
@MappableClass()
@immutable
class Partial{{entity_singular.pascalCase()}} with Partial{{entity_singular.pascalCase()}}Mappable {
  /// {@macro {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.partial_{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
  const Partial{{entity_singular.pascalCase()}}({
    this.name = const Optional.none(),
    this.description = const Optional.none(),
  });

  /// The optional name for the {{entity_singular.lowerCase()}}.
  final Optional<String> name;

  /// The optional description for the {{entity_singular.lowerCase()}}.
  final Optional<String?> description;
}{{/use_dart_mappable}}{{#use_equatable}}/// {@template {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
/// {{entity_singular.sentenceCase()}}.
/// {@endtemplate}
class {{entity_singular.pascalCase()}} extends Equatable {
  /// {@macro {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
  const {{entity_singular.pascalCase()}}({required this.id, required this.name, this.description});

  /// The ID of this {{entity_singular.lowerCase()}}.
  final int id;

  /// The name of this {{entity_singular.lowerCase()}}.
  final String name;

  /// The description of this {{entity_singular.lowerCase()}}.
  final String? description;

  @override
  List<Object?> get props => [id, name, description];

  /// Returns a copy of this [{{entity_singular.pascalCase()}}] with the given fields replaced by
  /// the new values.
  {{entity_singular.pascalCase()}} copyWith({
    int? id,
    String? name,
    String? Function()? description,
  }) {
    return {{entity_singular.pascalCase()}}(
      id: id ?? this.id,
      name: name ?? this.name,
      description: (description ?? () => this.description)(),
    );
  }
}

/// {@template {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.new_{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
/// A new {{entity_singular.lowerCase()}}.
/// {@endtemplate}
class New{{entity_singular.pascalCase()}} extends Equatable {
  /// {@macro {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.new_{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
  const New{{entity_singular.pascalCase()}}({required this.name, this.description});

  /// The name of the new {{entity_singular.lowerCase()}}.
  final String name;

  /// The description of the new {{entity_singular.lowerCase()}}.
  final String? description;

  @override
  List<Object?> get props => [name, description];

  /// Returns a copy of this [New{{entity_singular.pascalCase()}}] with the given fields replaced
  /// by the new values.
  New{{entity_singular.pascalCase()}} copyWith({String? name, String? Function()? description}) {
    return New{{entity_singular.pascalCase()}}(
      name: name ?? this.name,
      description: (description ?? () => this.description)(),
    );
  }
}

/// {@template {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.partial_{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
/// A partial {{entity_singular.lowerCase()}}.
/// {@endtemplate}
class Partial{{entity_singular.pascalCase()}} extends Equatable {
  /// {@macro {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.partial_{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
  const Partial{{entity_singular.pascalCase()}}({
    this.name = const Optional.none(),
    this.description = const Optional.none(),
  });

  /// The optional name for the {{entity_singular.lowerCase()}}.
  final Optional<String> name;

  /// The optional description for the {{entity_singular.lowerCase()}}.
  final Optional<String?> description;

  @override
  List<Object> get props => [name, description];

  /// Returns a copy of this [Partial{{entity_singular.pascalCase()}}] with the given fields
  /// replaced by the new values.
  Partial{{entity_singular.pascalCase()}} copyWith({
    Optional<String>? name,
    Optional<String?>? description,
  }) {
    return Partial{{entity_singular.pascalCase()}}(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}{{/use_equatable}}{{#use_freezed}}/// {@template {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
/// {{entity_singular.sentenceCase()}}.
/// {@endtemplate}
@freezed
class {{entity_singular.pascalCase()}} with _${{entity_singular.pascalCase()}} {
  /// {@macro {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
  const factory {{entity_singular.pascalCase()}}({
    /// The ID of this {{entity_singular.lowerCase()}}.
    required int id,

    /// The name of this {{entity_singular.lowerCase()}}.
    required String name,

    /// The description of this {{entity_singular.lowerCase()}}.
    String? description,
  }) = _{{entity_singular.pascalCase()}};
}

/// {@template {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.new_{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
/// A new {{entity_singular.lowerCase()}}.
/// {@endtemplate}
@freezed
class New{{entity_singular.pascalCase()}} with _$New{{entity_singular.pascalCase()}} {
  /// {@macro {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.new_{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
  const factory New{{entity_singular.pascalCase()}}({
    /// The name of the new {{entity_singular.lowerCase()}}.
    required String name,

    /// The description of the new {{entity_singular.lowerCase()}}.
    String? description,
  }) = _New{{entity_singular.pascalCase()}};
}

/// {@template {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.partial_{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
/// A partial {{entity_singular.lowerCase()}}.
/// {@endtemplate}
@freezed
class Partial{{entity_singular.pascalCase()}} with _$Partial{{entity_singular.pascalCase()}} {
  /// {@macro {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.partial_{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
  const factory Partial{{entity_singular.pascalCase()}}({
    /// The optional name for the {{entity_singular.lowerCase()}}.
    @Default(Optional<String>.none()) Optional<String> name,

    /// The optional description for the {{entity_singular.lowerCase()}}.
    @Default(Optional<String?>.none()) Optional<String?> description,
  }) = _Partial{{entity_singular.pascalCase()}};
}{{/use_freezed}}{{#use_overrides}}/// {@template {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
/// {{entity_singular.sentenceCase()}}.
/// {@endtemplate}
@immutable
class {{entity_singular.pascalCase()}} {
  /// {@macro {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
  const {{entity_singular.pascalCase()}}({required this.id, required this.name, this.description});

  /// The ID of this {{entity_singular.lowerCase()}}.
  final int id;

  /// The name of this {{entity_singular.lowerCase()}}.
  final String name;

  /// The description of this {{entity_singular.lowerCase()}}.
  final String? description;

  @override
  String toString() =>
      '{{entity_singular.pascalCase()}}(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(covariant {{entity_singular.pascalCase()}} other) {
    if (identical(this, other)) return true;
    return other.id == id &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ id.hashCode ^ name.hashCode ^ description.hashCode;

  /// Returns a copy of this [{{entity_singular.pascalCase()}}] with the given fields replaced by
  /// the new values.
  {{entity_singular.pascalCase()}} copyWith({
    int? id,
    String? name,
    String? Function()? description,
  }) {
    return {{entity_singular.pascalCase()}}(
      id: id ?? this.id,
      name: name ?? this.name,
      description: (description ?? () => this.description)(),
    );
  }
}

/// {@template {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.new_{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
/// A new {{entity_singular.lowerCase()}}.
/// {@endtemplate}
@immutable
class New{{entity_singular.pascalCase()}} {
  /// {@macro {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.new_{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
  const New{{entity_singular.pascalCase()}}({required this.name, this.description});

  /// The name of the new {{entity_singular.lowerCase()}}.
  final String name;

  /// The description of the new {{entity_singular.lowerCase()}}.
  final String? description;

  @override
  String toString() =>
      'New{{entity_singular.pascalCase()}}(name: $name, description: $description)';

  @override
  bool operator ==(covariant New{{entity_singular.pascalCase()}} other) {
    if (identical(this, other)) return true;
    return other.name == name && other.description == description;
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ name.hashCode ^ description.hashCode;

  /// Returns a copy of this [New{{entity_singular.pascalCase()}}] with the given fields replaced
  /// by the new values.
  New{{entity_singular.pascalCase()}} copyWith({String? name, String? Function()? description}) {
    return New{{entity_singular.pascalCase()}}(
      name: name ?? this.name,
      description: (description ?? () => this.description)(),
    );
  }
}

/// {@template {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.partial_{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
/// A partial {{entity_singular.lowerCase()}}.
/// {@endtemplate}
@immutable
class Partial{{entity_singular.pascalCase()}} {
  /// {@macro {{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.partial_{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}}
  const Partial{{entity_singular.pascalCase()}}({
    this.name = const Optional.none(),
    this.description = const Optional.none(),
  });

  /// The optional name for the {{entity_singular.lowerCase()}}.
  final Optional<String> name;

  /// The optional description for the {{entity_singular.lowerCase()}}.
  final Optional<String?> description;

  @override
  String toString() =>
      'Partial{{entity_singular.pascalCase()}}(name: $name, description: $description)';

  @override
  bool operator ==(covariant Partial{{entity_singular.pascalCase()}} other) {
    if (identical(this, other)) return true;
    return other.name == name && other.description == description;
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ name.hashCode ^ description.hashCode;

  /// Returns a copy of this [Partial{{entity_singular.pascalCase()}}] with the given fields
  /// replaced by the new values.
  Partial{{entity_singular.pascalCase()}} copyWith({
    Optional<String>? name,
    Optional<String?>? description,
  }) {
    return Partial{{entity_singular.pascalCase()}}(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}{{/use_overrides}}