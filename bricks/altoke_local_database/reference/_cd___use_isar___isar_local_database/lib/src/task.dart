import 'package:isar/isar.dart';

part 'task.g.dart';

/// An Isar representation of a task.
@Collection(accessor: 'tasks')
class Task {
  /// The task ID.
  late Id id = Isar.autoIncrement;

  /// The task title.
  late String title;

  /// The task priority.
  late String priority;

  /// Whether the task is completed.
  late bool completed;

  /// The task description.
  late String? description;
}
