// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '_cf___use_freezed___optional.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FOptional<T extends Object?> {}

/// @nodoc
abstract class $FOptionalCopyWith<T extends Object?, $Res> {
  factory $FOptionalCopyWith(
          FOptional<T> value, $Res Function(FOptional<T>) then) =
      _$FOptionalCopyWithImpl<T, $Res, FOptional<T>>;
}

/// @nodoc
class _$FOptionalCopyWithImpl<T extends Object?, $Res,
    $Val extends FOptional<T>> implements $FOptionalCopyWith<T, $Res> {
  _$FOptionalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FSomeImplCopyWith<T extends Object?, $Res> {
  factory _$$FSomeImplCopyWith(
          _$FSomeImpl<T> value, $Res Function(_$FSomeImpl<T>) then) =
      __$$FSomeImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T some});
}

/// @nodoc
class __$$FSomeImplCopyWithImpl<T extends Object?, $Res>
    extends _$FOptionalCopyWithImpl<T, $Res, _$FSomeImpl<T>>
    implements _$$FSomeImplCopyWith<T, $Res> {
  __$$FSomeImplCopyWithImpl(
      _$FSomeImpl<T> _value, $Res Function(_$FSomeImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? some = freezed,
  }) {
    return _then(_$FSomeImpl<T>(
      freezed == some
          ? _value.some
          : some // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$FSomeImpl<T extends Object?> extends FSome<T> {
  const _$FSomeImpl(this.some) : super._();

  /// The underlying value.
  @override
  final T some;

  @override
  String toString() {
    return 'FOptional<$T>.some(some: $some)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FSomeImpl<T> &&
            const DeepCollectionEquality().equals(other.some, some));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(some));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FSomeImplCopyWith<T, _$FSomeImpl<T>> get copyWith =>
      __$$FSomeImplCopyWithImpl<T, _$FSomeImpl<T>>(this, _$identity);
}

abstract class FSome<T extends Object?> extends FOptional<T> {
  const factory FSome(final T some) = _$FSomeImpl<T>;
  const FSome._() : super._();

  /// The underlying value.
  T get some;
  @JsonKey(ignore: true)
  _$$FSomeImplCopyWith<T, _$FSomeImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FNoneImplCopyWith<T extends Object?, $Res> {
  factory _$$FNoneImplCopyWith(
          _$FNoneImpl<T> value, $Res Function(_$FNoneImpl<T>) then) =
      __$$FNoneImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$FNoneImplCopyWithImpl<T extends Object?, $Res>
    extends _$FOptionalCopyWithImpl<T, $Res, _$FNoneImpl<T>>
    implements _$$FNoneImplCopyWith<T, $Res> {
  __$$FNoneImplCopyWithImpl(
      _$FNoneImpl<T> _value, $Res Function(_$FNoneImpl<T>) _then)
      : super(_value, _then);
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
