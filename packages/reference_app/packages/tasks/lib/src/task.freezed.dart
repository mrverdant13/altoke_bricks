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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Task {
  /// The task ID.
  int get id => throw _privateConstructorUsedError;

  /// The task title.
  String get title => throw _privateConstructorUsedError;

  /// Whether the task is completed.
  bool get isCompleted => throw _privateConstructorUsedError;

  /// The task creation date.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// The task description.
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {int id,
      String title,
      bool isCompleted,
      DateTime createdAt,
      String? description});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? isCompleted = null,
    Object? createdAt = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
          _$TaskImpl value, $Res Function(_$TaskImpl) then) =
      __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      bool isCompleted,
      DateTime createdAt,
      String? description});
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? isCompleted = null,
    Object? createdAt = null,
    Object? description = freezed,
  }) {
    return _then(_$TaskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TaskImpl implements _Task {
  const _$TaskImpl(
      {required this.id,
      required this.title,
      required this.isCompleted,
      required this.createdAt,
      this.description});

  /// The task ID.
  @override
  final int id;

  /// The task title.
  @override
  final String title;

  /// Whether the task is completed.
  @override
  final bool isCompleted;

  /// The task creation date.
  @override
  final DateTime createdAt;

  /// The task description.
  @override
  final String? description;

  @override
  String toString() {
    return 'Task(id: $id, title: $title, isCompleted: $isCompleted, createdAt: $createdAt, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, isCompleted, createdAt, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);
}

abstract class _Task implements Task {
  const factory _Task(
      {required final int id,
      required final String title,
      required final bool isCompleted,
      required final DateTime createdAt,
      final String? description}) = _$TaskImpl;

  @override

  /// The task ID.
  int get id;
  @override

  /// The task title.
  String get title;
  @override

  /// Whether the task is completed.
  bool get isCompleted;
  @override

  /// The task creation date.
  DateTime get createdAt;
  @override

  /// The task description.
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NewTask {
  /// The new task title.
  String get title => throw _privateConstructorUsedError;

  /// Whether the new task is completed.
  bool get isCompleted => throw _privateConstructorUsedError;

  /// The new task description.
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewTaskCopyWith<NewTask> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewTaskCopyWith<$Res> {
  factory $NewTaskCopyWith(NewTask value, $Res Function(NewTask) then) =
      _$NewTaskCopyWithImpl<$Res, NewTask>;
  @useResult
  $Res call({String title, bool isCompleted, String? description});
}

/// @nodoc
class _$NewTaskCopyWithImpl<$Res, $Val extends NewTask>
    implements $NewTaskCopyWith<$Res> {
  _$NewTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? isCompleted = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewTaskImplCopyWith<$Res> implements $NewTaskCopyWith<$Res> {
  factory _$$NewTaskImplCopyWith(
          _$NewTaskImpl value, $Res Function(_$NewTaskImpl) then) =
      __$$NewTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, bool isCompleted, String? description});
}

/// @nodoc
class __$$NewTaskImplCopyWithImpl<$Res>
    extends _$NewTaskCopyWithImpl<$Res, _$NewTaskImpl>
    implements _$$NewTaskImplCopyWith<$Res> {
  __$$NewTaskImplCopyWithImpl(
      _$NewTaskImpl _value, $Res Function(_$NewTaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? isCompleted = null,
    Object? description = freezed,
  }) {
    return _then(_$NewTaskImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NewTaskImpl implements _NewTask {
  const _$NewTaskImpl(
      {required this.title, this.isCompleted = false, this.description});

  /// The new task title.
  @override
  final String title;

  /// Whether the new task is completed.
  @override
  @JsonKey()
  final bool isCompleted;

  /// The new task description.
  @override
  final String? description;

  @override
  String toString() {
    return 'NewTask(title: $title, isCompleted: $isCompleted, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewTaskImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, isCompleted, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewTaskImplCopyWith<_$NewTaskImpl> get copyWith =>
      __$$NewTaskImplCopyWithImpl<_$NewTaskImpl>(this, _$identity);
}

abstract class _NewTask implements NewTask {
  const factory _NewTask(
      {required final String title,
      final bool isCompleted,
      final String? description}) = _$NewTaskImpl;

  @override

  /// The new task title.
  String get title;
  @override

  /// Whether the new task is completed.
  bool get isCompleted;
  @override

  /// The new task description.
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$NewTaskImplCopyWith<_$NewTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PartialTask {
  /// The optional task title setter.
  PartialSetter<String>? get title => throw _privateConstructorUsedError;

  /// The optional task completed setter.
  PartialSetter<bool>? get isCompleted => throw _privateConstructorUsedError;

  /// The optional task description setter.
  PartialSetter<String?>? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PartialTaskCopyWith<PartialTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartialTaskCopyWith<$Res> {
  factory $PartialTaskCopyWith(
          PartialTask value, $Res Function(PartialTask) then) =
      _$PartialTaskCopyWithImpl<$Res, PartialTask>;
  @useResult
  $Res call(
      {PartialSetter<String>? title,
      PartialSetter<bool>? isCompleted,
      PartialSetter<String?>? description});
}

/// @nodoc
class _$PartialTaskCopyWithImpl<$Res, $Val extends PartialTask>
    implements $PartialTaskCopyWith<$Res> {
  _$PartialTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? isCompleted = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as PartialSetter<String>?,
      isCompleted: freezed == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as PartialSetter<bool>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as PartialSetter<String?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartialTaskImplCopyWith<$Res>
    implements $PartialTaskCopyWith<$Res> {
  factory _$$PartialTaskImplCopyWith(
          _$PartialTaskImpl value, $Res Function(_$PartialTaskImpl) then) =
      __$$PartialTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PartialSetter<String>? title,
      PartialSetter<bool>? isCompleted,
      PartialSetter<String?>? description});
}

/// @nodoc
class __$$PartialTaskImplCopyWithImpl<$Res>
    extends _$PartialTaskCopyWithImpl<$Res, _$PartialTaskImpl>
    implements _$$PartialTaskImplCopyWith<$Res> {
  __$$PartialTaskImplCopyWithImpl(
      _$PartialTaskImpl _value, $Res Function(_$PartialTaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? isCompleted = freezed,
    Object? description = freezed,
  }) {
    return _then(_$PartialTaskImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as PartialSetter<String>?,
      isCompleted: freezed == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as PartialSetter<bool>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as PartialSetter<String?>?,
    ));
  }
}

/// @nodoc

class _$PartialTaskImpl implements _PartialTask {
  const _$PartialTaskImpl({this.title, this.isCompleted, this.description});

  /// The optional task title setter.
  @override
  final PartialSetter<String>? title;

  /// The optional task completed setter.
  @override
  final PartialSetter<bool>? isCompleted;

  /// The optional task description setter.
  @override
  final PartialSetter<String?>? description;

  @override
  String toString() {
    return 'PartialTask(title: $title, isCompleted: $isCompleted, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartialTaskImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, isCompleted, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PartialTaskImplCopyWith<_$PartialTaskImpl> get copyWith =>
      __$$PartialTaskImplCopyWithImpl<_$PartialTaskImpl>(this, _$identity);
}

abstract class _PartialTask implements PartialTask {
  const factory _PartialTask(
      {final PartialSetter<String>? title,
      final PartialSetter<bool>? isCompleted,
      final PartialSetter<String?>? description}) = _$PartialTaskImpl;

  @override

  /// The optional task title setter.
  PartialSetter<String>? get title;
  @override

  /// The optional task completed setter.
  PartialSetter<bool>? get isCompleted;
  @override

  /// The optional task description setter.
  PartialSetter<String?>? get description;
  @override
  @JsonKey(ignore: true)
  _$$PartialTaskImplCopyWith<_$PartialTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
