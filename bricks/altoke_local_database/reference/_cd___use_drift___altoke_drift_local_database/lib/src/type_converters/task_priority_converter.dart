import 'package:altoke_local_database/altoke_local_database.dart';
import 'package:drift/drift.dart';

/// {@template altoke_drift_local_database.task_priority_converter}
/// A type converter for [TaskPriority].
/// {@endtemplate}
class TaskPriorityConverter extends TypeConverter<TaskPriority, String> {
  /// {@macro altoke_drift_local_database.task_priority_converter}
  const TaskPriorityConverter();

  static const _map = {
    'low': TaskPriority.low,
    'medium': TaskPriority.medium,
    'high': TaskPriority.high,
  };

  @override
  TaskPriority fromSql(String fromDb) {
    return _map[fromDb]!;
  }

  @override
  String toSql(TaskPriority value) {
    final entry = _map.entries.firstWhere(
      (entry) => entry.value == value,
    );
    return entry.key;
  }
}
