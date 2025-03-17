// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FTask {
  /// The ID of this task.
  int get id => throw _privateConstructorUsedError;

  /// The name of this task.
  String get name => throw _privateConstructorUsedError;

  /// The description of this task.
  String? get description => throw _privateConstructorUsedError;

  /// Create a copy of FTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FTaskCopyWith<FTask> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FTaskCopyWith<$Res> {
  factory $FTaskCopyWith(FTask value, $Res Function(FTask) then) =
      _$FTaskCopyWithImpl<$Res, FTask>;
  @useResult
  $Res call({int id, String name, String? description});
}

/// @nodoc
class _$FTaskCopyWithImpl<$Res, $Val extends FTask>
    implements $FTaskCopyWith<$Res> {
  _$FTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FTaskImplCopyWith<$Res> implements $FTaskCopyWith<$Res> {
  factory _$$FTaskImplCopyWith(
    _$FTaskImpl value,
    $Res Function(_$FTaskImpl) then,
  ) = __$$FTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? description});
}

/// @nodoc
class __$$FTaskImplCopyWithImpl<$Res>
    extends _$FTaskCopyWithImpl<$Res, _$FTaskImpl>
    implements _$$FTaskImplCopyWith<$Res> {
  __$$FTaskImplCopyWithImpl(
    _$FTaskImpl _value,
    $Res Function(_$FTaskImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
  }) {
    return _then(
      _$FTaskImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$FTaskImpl implements _FTask {
  const _$FTaskImpl({required this.id, required this.name, this.description});

  /// The ID of this task.
  @override
  final int id;

  /// The name of this task.
  @override
  final String name;

  /// The description of this task.
  @override
  final String? description;

  @override
  String toString() {
    return 'FTask(id: $id, name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FTaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, description);

  /// Create a copy of FTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FTaskImplCopyWith<_$FTaskImpl> get copyWith =>
      __$$FTaskImplCopyWithImpl<_$FTaskImpl>(this, _$identity);
}

abstract class _FTask implements FTask {
  const factory _FTask({
    required final int id,
    required final String name,
    final String? description,
  }) = _$FTaskImpl;

  /// The ID of this task.
  @override
  int get id;

  /// The name of this task.
  @override
  String get name;

  /// The description of this task.
  @override
  String? get description;

  /// Create a copy of FTask
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FTaskImplCopyWith<_$FTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FNewTask {
  /// The name of the new task.
  String get name => throw _privateConstructorUsedError;

  /// The description of the new task.
  String? get description => throw _privateConstructorUsedError;

  /// Create a copy of FNewTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FNewTaskCopyWith<FNewTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FNewTaskCopyWith<$Res> {
  factory $FNewTaskCopyWith(FNewTask value, $Res Function(FNewTask) then) =
      _$FNewTaskCopyWithImpl<$Res, FNewTask>;
  @useResult
  $Res call({String name, String? description});
}

/// @nodoc
class _$FNewTaskCopyWithImpl<$Res, $Val extends FNewTask>
    implements $FNewTaskCopyWith<$Res> {
  _$FNewTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FNewTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? description = freezed}) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FNewTaskImplCopyWith<$Res>
    implements $FNewTaskCopyWith<$Res> {
  factory _$$FNewTaskImplCopyWith(
    _$FNewTaskImpl value,
    $Res Function(_$FNewTaskImpl) then,
  ) = __$$FNewTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? description});
}

/// @nodoc
class __$$FNewTaskImplCopyWithImpl<$Res>
    extends _$FNewTaskCopyWithImpl<$Res, _$FNewTaskImpl>
    implements _$$FNewTaskImplCopyWith<$Res> {
  __$$FNewTaskImplCopyWithImpl(
    _$FNewTaskImpl _value,
    $Res Function(_$FNewTaskImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FNewTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? description = freezed}) {
    return _then(
      _$FNewTaskImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$FNewTaskImpl implements _FNewTask {
  const _$FNewTaskImpl({required this.name, this.description});

  /// The name of the new task.
  @override
  final String name;

  /// The description of the new task.
  @override
  final String? description;

  @override
  String toString() {
    return 'FNewTask(name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FNewTaskImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, description);

  /// Create a copy of FNewTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FNewTaskImplCopyWith<_$FNewTaskImpl> get copyWith =>
      __$$FNewTaskImplCopyWithImpl<_$FNewTaskImpl>(this, _$identity);
}

abstract class _FNewTask implements FNewTask {
  const factory _FNewTask({
    required final String name,
    final String? description,
  }) = _$FNewTaskImpl;

  /// The name of the new task.
  @override
  String get name;

  /// The description of the new task.
  @override
  String? get description;

  /// Create a copy of FNewTask
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FNewTaskImplCopyWith<_$FNewTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FPartialTask {
  /// The optional name for the task.
  FOptional<String> get name => throw _privateConstructorUsedError;

  /// The optional description for the task.
  FOptional<String?> get description => throw _privateConstructorUsedError;

  /// Create a copy of FPartialTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FPartialTaskCopyWith<FPartialTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FPartialTaskCopyWith<$Res> {
  factory $FPartialTaskCopyWith(
    FPartialTask value,
    $Res Function(FPartialTask) then,
  ) = _$FPartialTaskCopyWithImpl<$Res, FPartialTask>;
  @useResult
  $Res call({FOptional<String> name, FOptional<String?> description});
}

/// @nodoc
class _$FPartialTaskCopyWithImpl<$Res, $Val extends FPartialTask>
    implements $FPartialTaskCopyWith<$Res> {
  _$FPartialTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FPartialTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? description = null}) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as FOptional<String>,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as FOptional<String?>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FPartialTaskImplCopyWith<$Res>
    implements $FPartialTaskCopyWith<$Res> {
  factory _$$FPartialTaskImplCopyWith(
    _$FPartialTaskImpl value,
    $Res Function(_$FPartialTaskImpl) then,
  ) = __$$FPartialTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FOptional<String> name, FOptional<String?> description});
}

/// @nodoc
class __$$FPartialTaskImplCopyWithImpl<$Res>
    extends _$FPartialTaskCopyWithImpl<$Res, _$FPartialTaskImpl>
    implements _$$FPartialTaskImplCopyWith<$Res> {
  __$$FPartialTaskImplCopyWithImpl(
    _$FPartialTaskImpl _value,
    $Res Function(_$FPartialTaskImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FPartialTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? description = null}) {
    return _then(
      _$FPartialTaskImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as FOptional<String>,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as FOptional<String?>,
      ),
    );
  }
}

/// @nodoc

class _$FPartialTaskImpl implements _FPartialTask {
  const _$FPartialTaskImpl({
    this.name = const FOptional<String>.none(),
    this.description = const FOptional<String?>.none(),
  });

  /// The optional name for the task.
  @override
  @JsonKey()
  final FOptional<String> name;

  /// The optional description for the task.
  @override
  @JsonKey()
  final FOptional<String?> description;

  @override
  String toString() {
    return 'FPartialTask(name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FPartialTaskImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, description);

  /// Create a copy of FPartialTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FPartialTaskImplCopyWith<_$FPartialTaskImpl> get copyWith =>
      __$$FPartialTaskImplCopyWithImpl<_$FPartialTaskImpl>(this, _$identity);
}

abstract class _FPartialTask implements FPartialTask {
  const factory _FPartialTask({
    final FOptional<String> name,
    final FOptional<String?> description,
  }) = _$FPartialTaskImpl;

  /// The optional name for the task.
  @override
  FOptional<String> get name;

  /// The optional description for the task.
  @override
  FOptional<String?> get description;

  /// Create a copy of FPartialTask
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FPartialTaskImplCopyWith<_$FPartialTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
