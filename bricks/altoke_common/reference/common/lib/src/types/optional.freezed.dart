// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'optional.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FOptional<T extends Object?> {}

/// @nodoc

class _$FSomeImpl<T extends Object?> extends FSome<T> {
  const _$FSomeImpl(this.value) : super._();

  /// The underlying value.
  @override
  final T value;

  @override
  String toString() {
    return 'FOptional<$T>.some(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FSomeImpl<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));
}

abstract class FSome<T extends Object?> extends FOptional<T> {
  const factory FSome(final T value) = _$FSomeImpl<T>;
  const FSome._() : super._();

  /// The underlying value.
  T get value;
}

/// @nodoc

class _$FNoneImpl<T extends Object?> extends FNone<T> {
  const _$FNoneImpl() : super._();

  @override
  String toString() {
    return 'FOptional<$T>.none()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FNoneImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class FNone<T extends Object?> extends FOptional<T> {
  const factory FNone() = _$FNoneImpl<T>;
  const FNone._() : super._();
}
