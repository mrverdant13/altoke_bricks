import 'package:altoke_common/common.dart';
/*{{#use_dart_mappable}}x*/
import 'package:dart_mappable/dart_mappable.dart';
/*x{{/use_dart_mappable}}x*/
/*x{{#use_equatable}}x*/
import 'package:equatable/equatable.dart';
/*x{{/use_equatable}}x*/
/*x{{#use_freezed}}x*/
import 'package:freezed_annotation/freezed_annotation.dart';

/*x{{/use_freezed}}*/
/*{{#use_meta}}x*/
/*insert-start*/
// import 'package:meta/meta.dart';
/*insert-end*/
/*x{{/use_meta}}*/

/*{{#use_freezed}}x*/
part 'task.freezed.dart';
/*x{{/use_freezed}}x*/
/*x{{#use_dart_mappable}}x*/
part 'task.mapper.dart';
/*x{{/use_dart_mappable}}*/

/*{{#use_dart_mappable}}x*/
/// {@template altoke_entities.task}
/// Task.
/// {@endtemplate}
@MappableClass()
@immutable
class DmTask with DmTaskMappable {
  /// {@macro altoke_entities.task}
  const DmTask({required this.id, required this.name, this.description});

  /// The ID of this task.
  final int id;

  /// The name of this task.
  final String name;

  /// The description of this task.
  final String? description;
}

/// {@template altoke_entities.new_task}
/// A new task.
/// {@endtemplate}
@MappableClass()
@immutable
class DmNewTask with DmNewTaskMappable {
  /// {@macro altoke_entities.new_task}
  const DmNewTask({required this.name, this.description});

  /// The name of the new task.
  final String name;

  /// The description of the new task.
  final String? description;
}

/// {@template altoke_entities.partial_task}
/// A partial task.
/// {@endtemplate}
@MappableClass()
@immutable
class DmPartialTask with DmPartialTaskMappable {
  /// {@macro altoke_entities.partial_task}
  const DmPartialTask({
    this.name = const DmOptional.none(),
    this.description = const DmOptional.none(),
  });

  /// The optional name for the task.
  final DmOptional<String> name;

  /// The optional description for the task.
  final DmOptional<String?> description;
}

/*x{{/use_dart_mappable}}x*/

/*x{{#use_equatable}}x*/
/// {@template altoke_entities.task}
/// Task.
/// {@endtemplate}
class ETask extends Equatable {
  /// {@macro altoke_entities.task}
  const ETask({required this.id, required this.name, this.description});

  /// The ID of this task.
  final int id;

  /// The name of this task.
  final String name;

  /// The description of this task.
  final String? description;

  @override
  List<Object?> get props => [id, name, description];

  /// Returns a copy of this [ETask] with the given fields replaced by
  /// the new values.
  ETask copyWith({int? id, String? name, String? Function()? description}) {
    return ETask(
      id: id ?? this.id,
      name: name ?? this.name,
      description: (description ?? () => this.description)(),
    );
  }
}

/// {@template altoke_entities.new_task}
/// A new task.
/// {@endtemplate}
class ENewTask extends Equatable {
  /// {@macro altoke_entities.new_task}
  const ENewTask({required this.name, this.description});

  /// The name of the new task.
  final String name;

  /// The description of the new task.
  final String? description;

  @override
  List<Object?> get props => [name, description];

  /// Returns a copy of this [ENewTask] with the given fields replaced
  /// by the new values.
  ENewTask copyWith({String? name, String? Function()? description}) {
    return ENewTask(
      name: name ?? this.name,
      description: (description ?? () => this.description)(),
    );
  }
}

/// {@template altoke_entities.partial_task}
/// A partial task.
/// {@endtemplate}
class EPartialTask extends Equatable {
  /// {@macro altoke_entities.partial_task}
  const EPartialTask({
    this.name = const EOptional.none(),
    this.description = const EOptional.none(),
  });

  /// The optional name for the task.
  final EOptional<String> name;

  /// The optional description for the task.
  final EOptional<String?> description;

  @override
  List<Object> get props => [name, description];

  /// Returns a copy of this [EPartialTask] with the given fields
  /// replaced by the new values.
  EPartialTask copyWith({
    EOptional<String>? name,
    EOptional<String?>? description,
  }) {
    return EPartialTask(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
/*x{{/use_equatable}}x*/

/*x{{#use_freezed}}x*/
/// {@template altoke_entities.task}
/// Task.
/// {@endtemplate}
@freezed
class FTask with _$FTask {
  /// {@macro altoke_entities.task}
  const FTask({required this.id, required this.name, this.description});

  /// The ID of this task.
  @override
  final int id;

  /// The name of this task.
  @override
  final String name;

  /// The description of this task.
  @override
  final String? description;
}

/// {@template altoke_entities.new_task}
/// A new task.
/// {@endtemplate}
@freezed
class FNewTask with _$FNewTask {
  /// {@macro altoke_entities.new_task}
  const FNewTask({required this.name, this.description});

  /// The name of the new task.
  @override
  final String name;

  /// The description of the new task.
  @override
  final String? description;
}

/// {@template altoke_entities.partial_task}
/// A partial task.
/// {@endtemplate}
@freezed
class FPartialTask with _$FPartialTask {
  /// {@macro altoke_entities.partial_task}
  const FPartialTask({
    this.name = const FOptional.none(),
    this.description = const FOptional.none(),
  });

  /// The optional name for the task.
  @override
  final FOptional<String> name;

  /// The optional description for the task.
  @override
  final FOptional<String?> description;
}
/*x{{/use_freezed}}x*/

/*x{{#use_overrides}}x*/
/// {@template altoke_entities.task}
/// Task.
/// {@endtemplate}
@immutable
class Task {
  /// {@macro altoke_entities.task}
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

/// {@template altoke_entities.new_task}
/// A new task.
/// {@endtemplate}
@immutable
class NewTask {
  /// {@macro altoke_entities.new_task}
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

/// {@template altoke_entities.partial_task}
/// A partial task.
/// {@endtemplate}
@immutable
class PartialTask {
  /// {@macro altoke_entities.partial_task}
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
}

/*x{{/use_overrides}}*/
