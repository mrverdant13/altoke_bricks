{{#use_dart_mappable}}import 'package:dart_mappable/dart_mappable.dart';{{/use_dart_mappable}}{{#use_equatable}}import 'package:equatable/equatable.dart';{{/use_equatable}}{{#use_freezed}}import 'package:freezed_annotation/freezed_annotation.dart';{{/use_freezed}}{{#use_meta}}import 'package:meta/meta.dart';{{/use_meta}}{{#use_freezed}}part 'optional.freezed.dart';{{/use_freezed}}{{#use_dart_mappable}}part 'optional.mapper.dart';{{/use_dart_mappable}}{{#use_dart_mappable}}/// {@template {{#requirements_met}}common{{/requirements_met}}.optional}
/// A representation of an optional value.
/// {@endtemplate}
@MappableClass()
@immutable
sealed class Optional<T extends Object?> with OptionalMappable<T> {
  /// {@macro {{#requirements_met}}common{{/requirements_met}}.optional}
  const Optional();

  /// Creates an [Optional] with a present value.
  const factory Optional.some(T value) = DmSome<T>;

  /// Creates an [Optional] with an absent value.
  const factory Optional.none() = DmNone<T>;
}

/// {@template {{#requirements_met}}common{{/requirements_met}}.some}
/// A representation of a present value.
/// {@endtemplate}
@MappableClass()
@immutable
class DmSome<T extends Object?> extends Optional<T> with DmSomeMappable<T> {
  /// {@macro {{#requirements_met}}common{{/requirements_met}}.some}
  const DmSome(this.value);

  /// The underlying value.
  final T value;

  // HACK: Manual override required to avoid edge cases.
  @override
  bool operator ==(Object other) {
    if (other is! DmSome<T>) return false;
    if (identical(this, other)) return true;
    return other.value == value;
  }

  // HACK: Manual override required to avoid edge cases.
  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}

/// {@template {{#requirements_met}}common{{/requirements_met}}.none}
/// A representation of an absent value.
/// {@endtemplate}
@MappableClass()
@immutable
class DmNone<T extends Object?> extends Optional<T> with DmNoneMappable<T> {
  /// {@macro {{#requirements_met}}common{{/requirements_met}}.none}
  const DmNone();

  // HACK: Manual override required to avoid edge cases.
  @override
  bool operator ==(Object other) {
    if (other is! DmNone<T>) return false;
    return identical(this, other);
  }

  // HACK: Manual override required to avoid edge cases.
  @override
  int get hashCode => runtimeType.hashCode;
}{{/use_dart_mappable}}{{#use_equatable}}/// {@template {{#requirements_met}}common{{/requirements_met}}.optional}
/// A representation of an optional value.
/// {@endtemplate}
sealed class Optional<T extends Object?> extends Equatable {
  /// {@macro {{#requirements_met}}common{{/requirements_met}}.optional}
  const Optional();

  /// Creates an [Optional] with a present value.
  const factory Optional.some(T value) = ESome<T>;

  /// Creates an [Optional] with an absent value.
  const factory Optional.none() = ENone<T>;
}

/// {@template {{#requirements_met}}common{{/requirements_met}}.some}
/// A representation of a present value.
/// {@endtemplate}
class ESome<T extends Object?> extends Optional<T> {
  /// {@macro {{#requirements_met}}common{{/requirements_met}}.some}
  const ESome(this.value);

  /// The underlying value.
  final T value;

  @override
  List<Object?> get props => [value];
}

/// {@template {{#requirements_met}}common{{/requirements_met}}.none}
/// A representation of an absent value.
/// {@endtemplate}
class ENone<T extends Object?> extends Optional<T> {
  /// {@macro {{#requirements_met}}common{{/requirements_met}}.none}
  const ENone();

  @override
  List<Object?> get props => [];
}{{/use_equatable}}{{#use_freezed}}/// {@template {{#requirements_met}}common{{/requirements_met}}.optional}
/// A representation of an optional value.
/// {@endtemplate}
@Freezed(copyWith: false)
class Optional<T extends Object?> with _$Optional<T> {
  /// {@macro {{#requirements_met}}common{{/requirements_met}}.optional}
  const Optional._();

  /// Creates an [Optional] with a present value.
  const factory Optional.some(
    /// The underlying value.
    T value,
  ) = FSome<T>;

  /// Creates an [Optional] with an absent value.
  const factory Optional.none() = FNone<T>;
}{{/use_freezed}}{{#use_overrides}}/// {@template {{#requirements_met}}common{{/requirements_met}}.optional}
/// A representation of an optional value.
/// {@endtemplate}
@immutable
sealed class Optional<T extends Object?> {
  /// {@macro {{#requirements_met}}common{{/requirements_met}}.optional}
  const Optional();

  /// Creates an [Optional] with a present value.
  const factory Optional.some(T value) = Some<T>;

  /// Creates an [Optional] with an absent value.
  const factory Optional.none() = None<T>;
}

/// {@template {{#requirements_met}}common{{/requirements_met}}.some}
/// A representation of a present value.
/// {@endtemplate}
@immutable
class Some<T extends Object?> extends Optional<T> {
  /// {@macro {{#requirements_met}}common{{/requirements_met}}.some}
  const Some(
    this.value,
  );

  /// The underlying value.
  final T value;

  @override
  String toString() => 'Some<$T>(value: $value)';

  @override
  bool operator ==(covariant Optional<T> other) {
    if (other is! Some<T>) return false;
    if (identical(this, other)) return true;
    return other.value == value;
  }

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}

/// {@template {{#requirements_met}}common{{/requirements_met}}.none}
/// A representation of an absent value.
/// {@endtemplate}
@immutable
class None<T extends Object?> extends Optional<T> {
  /// {@macro {{#requirements_met}}common{{/requirements_met}}.none}
  const None();

  @override
  String toString() => 'None<$T>()';

  @override
  bool operator ==(covariant Optional<T> other) {
    if (other is! None<T>) return false;
    return identical(this, other);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}{{/use_overrides}}