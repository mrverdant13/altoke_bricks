/// Validation errors for a task title.
enum TaskTitleValidationError {
  /// Validation error for an empty task title.
  empty
  ;

  const TaskTitleValidationError();
}

/// Complex validation errors for a task data.
enum TaskComplexValidationError {
  /// Validation error for a task with a high priority but no description.
  highPriorityWithNoDescription
  ;

  const TaskComplexValidationError();
}
