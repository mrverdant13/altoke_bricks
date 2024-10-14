import 'package:local_database/local_database.dart';

/// {@template local_database.create_task_failure}
/// An exception that is thrown when a task creation fails.
/// {@endtemplate}
sealed class CreateTaskFailure implements Exception {
  /// {@macro local_database.create_task_failure}
  const CreateTaskFailure();
}

/// {@template local_database.create_task_failure_invalid_data}
/// An exception that is thrown when the data provided for task creation is
/// invalid.
/// {@endtemplate}
class CreateTaskFailureInvalidData extends CreateTaskFailure {
  /// {@macro local_database.create_task_failure_invalid_data}
  const CreateTaskFailureInvalidData({
    required this.titleValidationErrors,
    required this.complexValidationErrors,
  });

  /// The validation errors for the task title.
  final Set<TaskTitleValidationError> titleValidationErrors;

  /// The complex validation errors for the task data.
  final Set<TaskComplexValidationError> complexValidationErrors;

  @override
  String toString() {
    final buf = StringBuffer('CreateTaskFailureInvalidData(');
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
