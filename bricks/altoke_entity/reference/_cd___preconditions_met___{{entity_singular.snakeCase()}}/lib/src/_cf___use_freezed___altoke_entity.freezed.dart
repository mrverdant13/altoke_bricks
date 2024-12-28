// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '_cf___use_freezed___altoke_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FAltokeEntity {
  /// The ID of this altoke entity.
  int get id => throw _privateConstructorUsedError;

  /// The name of this altoke entity.
  String get name => throw _privateConstructorUsedError;

  /// The description of this altoke entity.
  String? get description => throw _privateConstructorUsedError;

  /// Create a copy of FAltokeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FAltokeEntityCopyWith<FAltokeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FAltokeEntityCopyWith<$Res> {
  factory $FAltokeEntityCopyWith(
          FAltokeEntity value, $Res Function(FAltokeEntity) then) =
      _$FAltokeEntityCopyWithImpl<$Res, FAltokeEntity>;
  @useResult
  $Res call({int id, String name, String? description});
}

/// @nodoc
class _$FAltokeEntityCopyWithImpl<$Res, $Val extends FAltokeEntity>
    implements $FAltokeEntityCopyWith<$Res> {
  _$FAltokeEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FAltokeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FAltokeEntityImplCopyWith<$Res>
    implements $FAltokeEntityCopyWith<$Res> {
  factory _$$FAltokeEntityImplCopyWith(
          _$FAltokeEntityImpl value, $Res Function(_$FAltokeEntityImpl) then) =
      __$$FAltokeEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? description});
}

/// @nodoc
class __$$FAltokeEntityImplCopyWithImpl<$Res>
    extends _$FAltokeEntityCopyWithImpl<$Res, _$FAltokeEntityImpl>
    implements _$$FAltokeEntityImplCopyWith<$Res> {
  __$$FAltokeEntityImplCopyWithImpl(
      _$FAltokeEntityImpl _value, $Res Function(_$FAltokeEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of FAltokeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
  }) {
    return _then(_$FAltokeEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FAltokeEntityImpl implements _FAltokeEntity {
  const _$FAltokeEntityImpl(
      {required this.id, required this.name, this.description});

  /// The ID of this altoke entity.
  @override
  final int id;

  /// The name of this altoke entity.
  @override
  final String name;

  /// The description of this altoke entity.
  @override
  final String? description;

  @override
  String toString() {
    return 'FAltokeEntity(id: $id, name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FAltokeEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, description);

  /// Create a copy of FAltokeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FAltokeEntityImplCopyWith<_$FAltokeEntityImpl> get copyWith =>
      __$$FAltokeEntityImplCopyWithImpl<_$FAltokeEntityImpl>(this, _$identity);
}

abstract class _FAltokeEntity implements FAltokeEntity {
  const factory _FAltokeEntity(
      {required final int id,
      required final String name,
      final String? description}) = _$FAltokeEntityImpl;

  /// The ID of this altoke entity.
  @override
  int get id;

  /// The name of this altoke entity.
  @override
  String get name;

  /// The description of this altoke entity.
  @override
  String? get description;

  /// Create a copy of FAltokeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FAltokeEntityImplCopyWith<_$FAltokeEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FNewAltokeEntity {
  /// The name of the new altoke entity.
  String get name => throw _privateConstructorUsedError;

  /// The description of the new altoke entity.
  String? get description => throw _privateConstructorUsedError;

  /// Create a copy of FNewAltokeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FNewAltokeEntityCopyWith<FNewAltokeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FNewAltokeEntityCopyWith<$Res> {
  factory $FNewAltokeEntityCopyWith(
          FNewAltokeEntity value, $Res Function(FNewAltokeEntity) then) =
      _$FNewAltokeEntityCopyWithImpl<$Res, FNewAltokeEntity>;
  @useResult
  $Res call({String name, String? description});
}

/// @nodoc
class _$FNewAltokeEntityCopyWithImpl<$Res, $Val extends FNewAltokeEntity>
    implements $FNewAltokeEntityCopyWith<$Res> {
  _$FNewAltokeEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FNewAltokeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FNewAltokeEntityImplCopyWith<$Res>
    implements $FNewAltokeEntityCopyWith<$Res> {
  factory _$$FNewAltokeEntityImplCopyWith(_$FNewAltokeEntityImpl value,
          $Res Function(_$FNewAltokeEntityImpl) then) =
      __$$FNewAltokeEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? description});
}

/// @nodoc
class __$$FNewAltokeEntityImplCopyWithImpl<$Res>
    extends _$FNewAltokeEntityCopyWithImpl<$Res, _$FNewAltokeEntityImpl>
    implements _$$FNewAltokeEntityImplCopyWith<$Res> {
  __$$FNewAltokeEntityImplCopyWithImpl(_$FNewAltokeEntityImpl _value,
      $Res Function(_$FNewAltokeEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of FNewAltokeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
  }) {
    return _then(_$FNewAltokeEntityImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FNewAltokeEntityImpl implements _FNewAltokeEntity {
  const _$FNewAltokeEntityImpl({required this.name, this.description});

  /// The name of the new altoke entity.
  @override
  final String name;

  /// The description of the new altoke entity.
  @override
  final String? description;

  @override
  String toString() {
    return 'FNewAltokeEntity(name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FNewAltokeEntityImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, description);

  /// Create a copy of FNewAltokeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FNewAltokeEntityImplCopyWith<_$FNewAltokeEntityImpl> get copyWith =>
      __$$FNewAltokeEntityImplCopyWithImpl<_$FNewAltokeEntityImpl>(
          this, _$identity);
}

abstract class _FNewAltokeEntity implements FNewAltokeEntity {
  const factory _FNewAltokeEntity(
      {required final String name,
      final String? description}) = _$FNewAltokeEntityImpl;

  /// The name of the new altoke entity.
  @override
  String get name;

  /// The description of the new altoke entity.
  @override
  String? get description;

  /// Create a copy of FNewAltokeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FNewAltokeEntityImplCopyWith<_$FNewAltokeEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FPartialAltokeEntity {
  /// The optional name for the altoke entity.
  FOptional<String> get name => throw _privateConstructorUsedError;

  /// The optional description for the altoke entity.
  FOptional<String?> get description => throw _privateConstructorUsedError;

  /// Create a copy of FPartialAltokeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FPartialAltokeEntityCopyWith<FPartialAltokeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FPartialAltokeEntityCopyWith<$Res> {
  factory $FPartialAltokeEntityCopyWith(FPartialAltokeEntity value,
          $Res Function(FPartialAltokeEntity) then) =
      _$FPartialAltokeEntityCopyWithImpl<$Res, FPartialAltokeEntity>;
  @useResult
  $Res call({FOptional<String> name, FOptional<String?> description});
}

/// @nodoc
class _$FPartialAltokeEntityCopyWithImpl<$Res,
        $Val extends FPartialAltokeEntity>
    implements $FPartialAltokeEntityCopyWith<$Res> {
  _$FPartialAltokeEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FPartialAltokeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as FOptional<String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as FOptional<String?>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FPartialAltokeEntityImplCopyWith<$Res>
    implements $FPartialAltokeEntityCopyWith<$Res> {
  factory _$$FPartialAltokeEntityImplCopyWith(_$FPartialAltokeEntityImpl value,
          $Res Function(_$FPartialAltokeEntityImpl) then) =
      __$$FPartialAltokeEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FOptional<String> name, FOptional<String?> description});
}

/// @nodoc
class __$$FPartialAltokeEntityImplCopyWithImpl<$Res>
    extends _$FPartialAltokeEntityCopyWithImpl<$Res, _$FPartialAltokeEntityImpl>
    implements _$$FPartialAltokeEntityImplCopyWith<$Res> {
  __$$FPartialAltokeEntityImplCopyWithImpl(_$FPartialAltokeEntityImpl _value,
      $Res Function(_$FPartialAltokeEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of FPartialAltokeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_$FPartialAltokeEntityImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as FOptional<String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as FOptional<String?>,
    ));
  }
}

/// @nodoc

class _$FPartialAltokeEntityImpl implements _FPartialAltokeEntity {
  const _$FPartialAltokeEntityImpl(
      {this.name = const FOptional<String>.none(),
      this.description = const FOptional<String?>.none()});

  /// The optional name for the altoke entity.
  @override
  @JsonKey()
  final FOptional<String> name;

  /// The optional description for the altoke entity.
  @override
  @JsonKey()
  final FOptional<String?> description;

  @override
  String toString() {
    return 'FPartialAltokeEntity(name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FPartialAltokeEntityImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, description);

  /// Create a copy of FPartialAltokeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FPartialAltokeEntityImplCopyWith<_$FPartialAltokeEntityImpl>
      get copyWith =>
          __$$FPartialAltokeEntityImplCopyWithImpl<_$FPartialAltokeEntityImpl>(
              this, _$identity);
}

abstract class _FPartialAltokeEntity implements FPartialAltokeEntity {
  const factory _FPartialAltokeEntity(
      {final FOptional<String> name,
      final FOptional<String?> description}) = _$FPartialAltokeEntityImpl;

  /// The optional name for the altoke entity.
  @override
  FOptional<String> get name;

  /// The optional description for the altoke entity.
  @override
  FOptional<String?> get description;

  /// Create a copy of FPartialAltokeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FPartialAltokeEntityImplCopyWith<_$FPartialAltokeEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
