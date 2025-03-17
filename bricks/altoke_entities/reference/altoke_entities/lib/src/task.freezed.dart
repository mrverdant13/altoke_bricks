// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FTask {

 int get id; String get name; String? get description;
/// Create a copy of FTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FTaskCopyWith<FTask> get copyWith => _$FTaskCopyWithImpl<FTask>(this as FTask, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FTask&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description);

@override
String toString() {
  return 'FTask(id: $id, name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class $FTaskCopyWith<$Res>  {
  factory $FTaskCopyWith(FTask value, $Res Function(FTask) _then) = _$FTaskCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description
});




}
/// @nodoc
class _$FTaskCopyWithImpl<$Res>
    implements $FTaskCopyWith<$Res> {
  _$FTaskCopyWithImpl(this._self, this._then);

  final FTask _self;
  final $Res Function(FTask) _then;

/// Create a copy of FTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,}) {
  return _then(FTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
mixin _$FNewTask {

 String get name; String? get description;
/// Create a copy of FNewTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FNewTaskCopyWith<FNewTask> get copyWith => _$FNewTaskCopyWithImpl<FNewTask>(this as FNewTask, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FNewTask&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,name,description);

@override
String toString() {
  return 'FNewTask(name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class $FNewTaskCopyWith<$Res>  {
  factory $FNewTaskCopyWith(FNewTask value, $Res Function(FNewTask) _then) = _$FNewTaskCopyWithImpl;
@useResult
$Res call({
 String name, String? description
});




}
/// @nodoc
class _$FNewTaskCopyWithImpl<$Res>
    implements $FNewTaskCopyWith<$Res> {
  _$FNewTaskCopyWithImpl(this._self, this._then);

  final FNewTask _self;
  final $Res Function(FNewTask) _then;

/// Create a copy of FNewTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = freezed,}) {
  return _then(FNewTask(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
mixin _$FPartialTask {

 FOptional<String> get name; FOptional<String?> get description;
/// Create a copy of FPartialTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FPartialTaskCopyWith<FPartialTask> get copyWith => _$FPartialTaskCopyWithImpl<FPartialTask>(this as FPartialTask, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FPartialTask&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,name,description);

@override
String toString() {
  return 'FPartialTask(name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class $FPartialTaskCopyWith<$Res>  {
  factory $FPartialTaskCopyWith(FPartialTask value, $Res Function(FPartialTask) _then) = _$FPartialTaskCopyWithImpl;
@useResult
$Res call({
 FOptional<String> name, FOptional<String?> description
});




}
/// @nodoc
class _$FPartialTaskCopyWithImpl<$Res>
    implements $FPartialTaskCopyWith<$Res> {
  _$FPartialTaskCopyWithImpl(this._self, this._then);

  final FPartialTask _self;
  final $Res Function(FPartialTask) _then;

/// Create a copy of FPartialTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,}) {
  return _then(FPartialTask(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as FOptional<String>,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as FOptional<String?>,
  ));
}

}


// dart format on
