import 'package:common/common.dart';
{{#use_dart_mappable}}import 'package:dart_mappable/dart_mappable.dart';{{/use_dart_mappable}}{{#use_equatable}}import 'package:equatable/equatable.dart';{{/use_equatable}}{{#use_freezed}}import 'package:freezed_annotation/freezed_annotation.dart';{{/use_freezed}}
{{#use_meta}}import 'package:meta/meta.dart';{{/use_meta}}

{{#use_freezed}}part 'task.freezed.dart';{{/use_freezed}}{{#use_dart_mappable}}part 'task.mapper.dart';{{/use_dart_mappable}}

{{#use_dart_mappable}}/// {@template {{package_name}}.task}
/// Task.
/// {@endtemplate}
@MappableClass()
@immutable
class Task with TaskMappable {
  /// {@macro {{package_name}}.task}
  const Task({required this.id, required this.name, this.description});

  /// The ID of this task.
  final int id;

  /// The name of this task.
  final String name;

  /// The description of this task.
  final String? description;
}

/// {@template {{package_name}}.new_task}
/// A new task.
/// {@endtemplate}
@MappableClass()
@immutable
class NewTask with NewTaskMappable {
  /// {@macro {{package_name}}.new_task}
  const NewTask({required this.name, this.description});

  /// The name of the new task.
  final String name;

  /// The description of the new task.
  final String? description;
}

/// {@template {{package_name}}.partial_task}
/// A partial task.
/// {@endtemplate}
@MappableClass()
@immutable
class PartialTask with PartialTaskMappable {
  /// {@macro {{package_name}}.partial_task}
  const PartialTask({
    this.name = const Optional.none(),
    this.description = const Optional.none(),
  });

  /// The optional name for the task.
  final Optional<String> name;

  /// The optional description for the task.
  final Optional<String?> description;
}{{/use_dart_mappable}}{{#use_equatable}}/// {@template {{package_name}}.task}
/// Task.
/// {@endtemplate}
class Task extends Equatable {
  /// {@macro {{package_name}}.task}
  const Task({required this.id, required this.name, this.description});

  /// The ID of this task.
  final int id;

  /// The name of this task.
  final String name;

  /// The description of this task.
  final String? description;

  @override
  List<Object?> get props => [id, name, description];

  /// Returns a copy of this [Task] with the given fields replaced by
  /// the new values.
  Task copyWith({int? id, String? name, String? Function()? description}) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      description: (description ?? () => this.description)(),
    );
  }
}

/// {@template {{package_name}}.new_task}
/// A new task.
/// {@endtemplate}
class NewTask extends Equatable {
  /// {@macro {{package_name}}.new_task}
  const NewTask({required this.name, this.description});

  /// The name of the new task.
  final String name;

  /// The description of the new task.
  final String? description;

  @override
  List<Object?> get props => [name, description];

  /// Returns a copy of this [NewTask] with the given fields replaced
  /// by the new values.
  NewTask copyWith({String? name, String? Function()? description}) {
    return NewTask(
      name: name ?? this.name,
      description: (description ?? () => this.description)(),
    );
  }
}

/// {@template {{package_name}}.partial_task}
/// A partial task.
/// {@endtemplate}
class PartialTask extends Equatable {
  /// {@macro {{package_name}}.partial_task}
  const PartialTask({
    this.name = const Optional.none(),
    this.description = const Optional.none(),
  });

  /// The optional name for the task.
  final Optional<String> name;

  /// The optional description for the task.
  final Optional<String?> description;

  @override
  List<Object> get props => [name, description];

  /// Returns a copy of this [PartialTask] with the given fields
  /// replaced by the new values.
  PartialTask copyWith({
    Optional<String>? name,
    Optional<String?>? description,
  }) {
    return PartialTask(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}{{/use_equatable}}{{#use_freezed}}/// {@template {{package_name}}.task}
/// Task.
/// {@endtemplate}
@freezed
class Task with _$Task {
  /// {@macro {{package_name}}.task}
  const factory Task({
    /// The ID of this task.
    required int id,

    /// The name of this task.
    required String name,

    /// The description of this task.
    String? description,
  }) = _Task;
}

/// {@template {{package_name}}.new_task}
/// A new task.
/// {@endtemplate}
@freezed
class NewTask with _$NewTask {
  /// {@macro {{package_name}}.new_task}
  const factory NewTask({
    /// The name of the new task.
    required String name,

    /// The description of the new task.
    String? description,
  }) = _NewTask;
}

/// {@template {{package_name}}.partial_task}
/// A partial task.
/// {@endtemplate}
@freezed
class PartialTask with _$PartialTask {
  /// {@macro {{package_name}}.partial_task}
  const factory PartialTask({
    /// The optional name for the task.
    @Default(Optional<String>.none()) Optional<String> name,

    /// The optional description for the task.
    @Default(Optional<String?>.none()) Optional<String?> description,
  }) = _PartialTask;
}{{/use_freezed}}{{#use_overrides}}/// {@template {{package_name}}.task}
/// Task.
/// {@endtemplate}
@immutable
class Task {
  /// {@macro {{package_name}}.task}
  const Task({required this.id, required this.name, this.description});

  /// The ID of this task.
  final int id;

  /// The name of this task.
  final String name;

  /// The description of this task.
  final String? description;

  @override
  String toString() => 'Task(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;
    return other.id == id &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ id.hashCode ^ name.hashCode ^ description.hashCode;

  /// Returns a copy of this [Task] with the given fields replaced by
  /// the new values.
  Task copyWith({int? id, String? name, String? Function()? description}) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      description: (description ?? () => this.description)(),
    );
  }
}

/// {@template {{package_name}}.new_task}
/// A new task.
/// {@endtemplate}
@immutable
class NewTask {
  /// {@macro {{package_name}}.new_task}
  const NewTask({required this.name, this.description});

  /// The name of the new task.
  final String name;

  /// The description of the new task.
  final String? description;

  @override
  String toString() => 'NewTask(name: $name, description: $description)';

  @override
  bool operator ==(covariant NewTask other) {
    if (identical(this, other)) return true;
    return other.name == name && other.description == description;
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ name.hashCode ^ description.hashCode;

  /// Returns a copy of this [NewTask] with the given fields replaced
  /// by the new values.
  NewTask copyWith({String? name, String? Function()? description}) {
    return NewTask(
      name: name ?? this.name,
      description: (description ?? () => this.description)(),
    );
  }
}

/// {@template {{package_name}}.partial_task}
/// A partial task.
/// {@endtemplate}
@immutable
class PartialTask {
  /// {@macro {{package_name}}.partial_task}
  const PartialTask({
    this.name = const Optional.none(),
    this.description = const Optional.none(),
  });

  /// The optional name for the task.
  final Optional<String> name;

  /// The optional description for the task.
  final Optional<String?> description;

  @override
  String toString() => 'PartialTask(name: $name, description: $description)';

  @override
  bool operator ==(covariant PartialTask other) {
    if (identical(this, other)) return true;
    return other.name == name && other.description == description;
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ name.hashCode ^ description.hashCode;

  /// Returns a copy of this [PartialTask] with the given fields
  /// replaced by the new values.
  PartialTask copyWith({
    Optional<String>? name,
    Optional<String?>? description,
  }) {
    return PartialTask(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}{{/use_overrides}}
