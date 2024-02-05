/// {@template create_task_failure}
/// Exception thrown when a task fails to be created.
/// {@endtemplate}
sealed class CreateTaskFailure implements Exception {
  /// {@macro create_task_failure}
  const CreateTaskFailure();
}

/// {@template create_task_failure_empty_title}
/// Exception thrown when a task fails to be created due to an empty title.
/// {@endtemplate}
class CreateTaskFailureEmptyTitle extends CreateTaskFailure {
  /// {@macro create_task_failure_empty_title}
  const CreateTaskFailureEmptyTitle();
}
