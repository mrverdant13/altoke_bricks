import 'package:common/common.dart';
import 'package:{{#requirements_met}}local_database{{/requirements_met}}/{{#requirements_met}}local_database{{/requirements_met}}.dart';
import 'package:meta/meta.dart';

/// {@template {{#requirements_met}}local_database{{/requirements_met}}.new_task}
/// A new task data.
/// {@endtemplate}
class NewTask {
  /// {@macro {{#requirements_met}}local_database{{/requirements_met}}.new_task}
  const NewTask({
    required this.title,
    required this.priority,
    this.description,
  });

  /// {@macro {{#requirements_met}}local_database{{/requirements_met}}.task.title}
  final String title;

  /// {@macro {{#requirements_met}}local_database{{/requirements_met}}.task.priority}
  final TaskPriority priority;

  /// {@macro {{#requirements_met}}local_database{{/requirements_met}}.task.description}
  final String? description;
}

/// {@template {{#requirements_met}}local_database{{/requirements_met}}.task}
/// A task.
/// {@endtemplate}
@immutable
class Task {
  /// {@macro {{#requirements_met}}local_database{{/requirements_met}}.task}
  const Task({
    required this.id,
    required this.title,
    required this.priority,
    required this.completed,
    this.description,
  });

  /// The task id.
  final int id;

  /// {@template {{#requirements_met}}local_database{{/requirements_met}}.task.title}
  /// The task title.
  /// {@endtemplate}
  final String title;

  /// {@template {{#requirements_met}}local_database{{/requirements_met}}.task.priority}
  /// The task priority.
  /// {@endtemplate}
  final TaskPriority priority;

  /// {@template {{#requirements_met}}local_database{{/requirements_met}}.task.completed}
  /// Whether the task is completed.
  /// {@endtemplate}
  final bool completed;

  /// {@template {{#requirements_met}}local_database{{/requirements_met}}.task.description}
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

/// {@template {{#requirements_met}}local_database{{/requirements_met}}.partial_task}
/// A partial task data.
/// {@endtemplate}
class PartialTask {
  /// {@macro {{#requirements_met}}local_database{{/requirements_met}}.partial_task}
  const PartialTask({
    this.title = const Optional.none(),
    this.priority = const Optional.none(),
    this.completed = const Optional.none(),
    this.description = const Optional.none(),
  });

  /// {@macro {{#requirements_met}}local_database{{/requirements_met}}.task.title}
  final Optional<String> title;

  /// {@macro {{#requirements_met}}local_database{{/requirements_met}}.task.priority}
  final Optional<TaskPriority> priority;

  /// {@macro {{#requirements_met}}local_database{{/requirements_met}}.task.completed}
  final Optional<bool> completed;

  /// {@macro {{#requirements_met}}local_database{{/requirements_met}}.task.description}
  final Optional<String?> description;
}
