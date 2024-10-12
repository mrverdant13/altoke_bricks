import 'package:altoke_common/common.dart';
import 'package:altoke_local_database/altoke_local_database.dart';

/// {@template altoke_local_database.new_task}
/// A new task data.
/// {@endtemplate}
class NewTask {
  /// {@macro altoke_local_database.new_task}
  const NewTask({
    required this.title,
    required this.priority,
    this.description,
  });

  /// {@macro altoke_local_database.task.title}
  final String title;

  /// {@macro altoke_local_database.task.priority}
  final TaskPriority priority;

  /// {@macro altoke_local_database.task.description}
  final String? description;
}

/// {@template altoke_local_database.task}
/// A task.
/// {@endtemplate}
class Task {
  /// {@macro altoke_local_database.task}
  const Task({
    required this.id,
    required this.title,
    required this.priority,
    required this.completed,
    this.description,
  });

  /// The task id.
  final int id;

  /// {@template altoke_local_database.task.title}
  /// The task title.
  /// {@endtemplate}
  final String title;

  /// {@template altoke_local_database.task.priority}
  /// The task priority.
  /// {@endtemplate}
  final TaskPriority priority;

  /// {@template altoke_local_database.task.completed}
  /// Whether the task is completed.
  /// {@endtemplate}
  final bool completed;

  /// {@template altoke_local_database.task.description}
  /// The task description.
  /// {@endtemplate}
  final String? description;
}

/// {@template altoke_local_database.partial_task}
/// A partial task data.
/// {@endtemplate}
class PartialTask {
  /// {@macro altoke_local_database.partial_task}
  const PartialTask({
    this.title = const Optional.none(),
    this.priority = const Optional.none(),
    this.completed = const Optional.none(),
    this.description = const Optional.none(),
  });

  /// {@macro altoke_local_database.task.title}
  final Optional<String> title;

  /// {@macro altoke_local_database.task.priority}
  final Optional<TaskPriority> priority;

  /// {@macro altoke_local_database.task.completed}
  final Optional<bool> completed;

  /// {@macro altoke_local_database.task.description}
  final Optional<String?> description;
}
