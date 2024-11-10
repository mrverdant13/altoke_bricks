import 'package:local_database/local_database.dart';

/// {@template local_database.update_task_failure}
/// An exception that is thrown when a task update fails.
/// {@endtemplate}
sealed class UpdateTaskFailure implements Exception {
  /// {@macro local_database.update_task_failure}
  const UpdateTaskFailure();
}

/// {@template local_database.update_task_failure_not_found}
/// An exception that is thrown when the task to update is not found.
/// {@endtemplate}
class UpdateTaskFailureNotFound extends UpdateTaskFailure {
  /// {@macro local_database.update_task_failure_not_found}
  const UpdateTaskFailureNotFound({
    required this.taskId,
  });

  /// The id of the task that was not found.
  final int taskId;

  @override
  String toString() {
    return 'UpdateTaskFailureNotFound(taskId: $taskId)';
  }
}

/// {@template local_database.update_task_failure_invalid_data}
/// An exception that is thrown when the data provided for task update is
/// invalid.
/// {@endtemplate}
class UpdateTaskFailureInvalidData extends UpdateTaskFailure {
  /// {@macro local_database.update_task_failure_invalid_data}
  const UpdateTaskFailureInvalidData({
    required this.titleValidationErrors,
    required this.complexValidationErrors,
  });

  /// The validation errors for the task title.
  final Set<TaskTitleValidationError> titleValidationErrors;

  /// The complex validation errors for the task data.
  final Set<TaskComplexValidationError> complexValidationErrors;

  @override
  String toString() {
    final buf = StringBuffer('UpdateTaskFailureInvalidData(');
    if (titleValidationErrors.isNotEmpty) {
      buf.write('titleValidationErrors: $titleValidationErrors');
    }
    if (complexValidationErrors.isNotEmpty) {
      if (titleValidationErrors.isNotEmpty) {
        buf.write(', ');
      }
      buf.write('complexValidationErrors: $complexValidationErrors');
    }
    buf.write(')');
    return buf.toString();
  }
}
