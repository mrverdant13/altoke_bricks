// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'optional.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FOptional<T extends Object?> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FOptional<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FOptional<$T>()';
}


}





/// @nodoc


class FSome<T extends Object?> extends FOptional<T> {
  const FSome(this.value): super._();
  

/// The underlying value.
 final  T value;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FSome<T>&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'FOptional<$T>.some(value: $value)';
}


}




/// @nodoc


class FNone<T extends Object?> extends FOptional<T> {
  const FNone(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FNone<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FOptional<$T>.none()';
}


}




// dart format on
