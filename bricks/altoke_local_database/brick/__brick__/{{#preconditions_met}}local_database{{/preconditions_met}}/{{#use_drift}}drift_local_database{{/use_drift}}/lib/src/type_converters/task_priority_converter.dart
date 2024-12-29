import 'package:drift/drift.dart';
import 'package:{{#preconditions_met}}local_database{{/preconditions_met}}/{{#preconditions_met}}local_database{{/preconditions_met}}.dart';

/// {@template {{#use_drift}}drift_local_database{{/use_drift}}.task_priority_converter}
/// A type converter for [TaskPriority].
/// {@endtemplate}
class TaskPriorityConverter extends TypeConverter<TaskPriority, String> {
  /// {@macro {{#use_drift}}drift_local_database{{/use_drift}}.task_priority_converter}
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
