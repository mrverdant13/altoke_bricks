// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'altoke_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FAltokeEntity {

 int get id; String get name; String? get description;
/// Create a copy of FAltokeEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FAltokeEntityCopyWith<FAltokeEntity> get copyWith => _$FAltokeEntityCopyWithImpl<FAltokeEntity>(this as FAltokeEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FAltokeEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description);

@override
String toString() {
  return 'FAltokeEntity(id: $id, name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class $FAltokeEntityCopyWith<$Res>  {
  factory $FAltokeEntityCopyWith(FAltokeEntity value, $Res Function(FAltokeEntity) _then) = _$FAltokeEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description
});




}
/// @nodoc
class _$FAltokeEntityCopyWithImpl<$Res>
    implements $FAltokeEntityCopyWith<$Res> {
  _$FAltokeEntityCopyWithImpl(this._self, this._then);

  final FAltokeEntity _self;
  final $Res Function(FAltokeEntity) _then;

/// Create a copy of FAltokeEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,}) {
  return _then(FAltokeEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc
mixin _$FNewAltokeEntity {

 String get name; String? get description;
/// Create a copy of FNewAltokeEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FNewAltokeEntityCopyWith<FNewAltokeEntity> get copyWith => _$FNewAltokeEntityCopyWithImpl<FNewAltokeEntity>(this as FNewAltokeEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FNewAltokeEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,name,description);

@override
String toString() {
  return 'FNewAltokeEntity(name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class $FNewAltokeEntityCopyWith<$Res>  {
  factory $FNewAltokeEntityCopyWith(FNewAltokeEntity value, $Res Function(FNewAltokeEntity) _then) = _$FNewAltokeEntityCopyWithImpl;
@useResult
$Res call({
 String name, String? description
});




}
/// @nodoc
class _$FNewAltokeEntityCopyWithImpl<$Res>
    implements $FNewAltokeEntityCopyWith<$Res> {
  _$FNewAltokeEntityCopyWithImpl(this._self, this._then);

  final FNewAltokeEntity _self;
  final $Res Function(FNewAltokeEntity) _then;

/// Create a copy of FNewAltokeEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = freezed,}) {
  return _then(FNewAltokeEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc
mixin _$FPartialAltokeEntity {

 FOptional<String> get name; FOptional<String?> get description;
/// Create a copy of FPartialAltokeEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FPartialAltokeEntityCopyWith<FPartialAltokeEntity> get copyWith => _$FPartialAltokeEntityCopyWithImpl<FPartialAltokeEntity>(this as FPartialAltokeEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FPartialAltokeEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,name,description);

@override
String toString() {
  return 'FPartialAltokeEntity(name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class $FPartialAltokeEntityCopyWith<$Res>  {
  factory $FPartialAltokeEntityCopyWith(FPartialAltokeEntity value, $Res Function(FPartialAltokeEntity) _then) = _$FPartialAltokeEntityCopyWithImpl;
@useResult
$Res call({
 FOptional<String> name, FOptional<String?> description
});




}
/// @nodoc
class _$FPartialAltokeEntityCopyWithImpl<$Res>
    implements $FPartialAltokeEntityCopyWith<$Res> {
  _$FPartialAltokeEntityCopyWithImpl(this._self, this._then);

  final FPartialAltokeEntity _self;
  final $Res Function(FPartialAltokeEntity) _then;

/// Create a copy of FPartialAltokeEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,}) {
  return _then(FPartialAltokeEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as FOptional<String>,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as FOptional<String?>,
  ));
}

}



// dart format on
