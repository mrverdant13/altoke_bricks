import 'package:common/common.dart';
import 'package:{{#preconditions_met}}local_database{{/preconditions_met}}/{{#preconditions_met}}local_database{{/preconditions_met}}.dart';
import 'package:meta/meta.dart';

/// {@template {{#preconditions_met}}local_database{{/preconditions_met}}.new_task}
/// A new task data.
/// {@endtemplate}
class NewTask {
  /// {@macro {{#preconditions_met}}local_database{{/preconditions_met}}.new_task}
  const NewTask({
    required this.title,
    required this.priority,
    this.description,
  });

  /// {@macro {{#preconditions_met}}local_database{{/preconditions_met}}.task.title}
  final String title;

  /// {@macro {{#preconditions_met}}local_database{{/preconditions_met}}.task.priority}
  final TaskPriority priority;

  /// {@macro {{#preconditions_met}}local_database{{/preconditions_met}}.task.description}
  final String? description;
}

/// {@template {{#preconditions_met}}local_database{{/preconditions_met}}.task}
/// A task.
/// {@endtemplate}
@immutable
class Task {
  /// {@macro {{#preconditions_met}}local_database{{/preconditions_met}}.task}
  const Task({
    required this.id,
    required this.title,
    required this.priority,
    required this.completed,
    this.description,
  });

  /// The task id.
  final int id;

  /// {@template {{#preconditions_met}}local_database{{/preconditions_met}}.task.title}
  /// The task title.
  /// {@endtemplate}
  final String title;

  /// {@template {{#preconditions_met}}local_database{{/preconditions_met}}.task.priority}
  /// The task priority.
  /// {@endtemplate}
  final TaskPriority priority;

  /// {@template {{#preconditions_met}}local_database{{/preconditions_met}}.task.completed}
  /// Whether the task is completed.
  /// {@endtemplate}
  final bool completed;

  /// {@template {{#preconditions_met}}local_database{{/preconditions_met}}.task.description}
  /// The task description.
  /// {@endtemplate}
  final String? description;

  @override
  String toString() {
    return 'Task('
        'id: $id, '
        'title: $title, '
        'priority: $priority, '
        'completed: $completed, '
        'description: $description'
        ')';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;
    return other.id == id &&
        other.title == title &&
        other.priority == priority &&
        other.completed == completed &&
        other.description == description;
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      id.hashCode ^
      title.hashCode ^
      priority.hashCode ^
      completed.hashCode ^
      description.hashCode;
}

/// {@template {{#preconditions_met}}local_database{{/preconditions_met}}.partial_task}
/// A partial task data.
/// {@endtemplate}
class PartialTask {
  /// {@macro {{#preconditions_met}}local_database{{/preconditions_met}}.partial_task}
  const PartialTask({
    this.title = const Optional.none(),
    this.priority = const Optional.none(),
    this.completed = const Optional.none(),
    this.description = const Optional.none(),
  });

  /// {@macro {{#preconditions_met}}local_database{{/preconditions_met}}.task.title}
  final Optional<String> title;

  /// {@macro {{#preconditions_met}}local_database{{/preconditions_met}}.task.priority}
  final Optional<TaskPriority> priority;

  /// {@macro {{#preconditions_met}}local_database{{/preconditions_met}}.task.completed}
  final Optional<bool> completed;

  /// {@macro {{#preconditions_met}}local_database{{/preconditions_met}}.task.description}
  final Optional<String?> description;
}
