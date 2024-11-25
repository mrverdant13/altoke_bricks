import 'package:common/common.dart';
import 'package:local_database/local_database.dart';
import 'package:meta/meta.dart';

/// {@template local_database.new_task}
/// A new task data.
/// {@endtemplate}
class NewTask {
  /// {@macro local_database.new_task}
  const NewTask({
    required this.title,
    required this.priority,
    this.description,
  });

  /// {@macro local_database.task.title}
  final String title;

  /// {@macro local_database.task.priority}
  final TaskPriority priority;

  /// {@macro local_database.task.description}
  final String? description;
}

/// {@template local_database.task}
/// A task.
/// {@endtemplate}
@immutable
class Task {
  /// {@macro local_database.task}
  const Task({
    required this.id,
    required this.title,
    required this.priority,
    required this.completed,
    this.description,
  });

  /// The task id.
  final int id;

  /// {@template local_database.task.title}
  /// The task title.
  /// {@endtemplate}
  final String title;

  /// {@template local_database.task.priority}
  /// The task priority.
  /// {@endtemplate}
  final TaskPriority priority;

  /// {@template local_database.task.completed}
  /// Whether the task is completed.
  /// {@endtemplate}
  final bool completed;

  /// {@template local_database.task.description}
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

/// {@template local_database.partial_task}
/// A partial task data.
/// {@endtemplate}
class PartialTask {
  /// {@macro local_database.partial_task}
  const PartialTask({
    this.title = const Optional.none(),
    this.priority = const Optional.none(),
    this.completed = const Optional.none(),
    this.description = const Optional.none(),
  });

  /// {@macro local_database.task.title}
  final Optional<String> title;

  /// {@macro local_database.task.priority}
  final Optional<TaskPriority> priority;

  /// {@macro local_database.task.completed}
  final Optional<bool> completed;

  /// {@macro local_database.task.description}
  final Optional<String?> description;
}
