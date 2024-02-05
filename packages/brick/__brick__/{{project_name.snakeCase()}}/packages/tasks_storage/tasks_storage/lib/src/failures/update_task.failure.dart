/// {@template update_task_failure}
/// Exception thrown when a task fails to be updated.
/// {@endtemplate}
sealed class UpdateTaskFailure implements Exception {
  /// {@macro update_task_failure}
  const UpdateTaskFailure();
}

/// {@template update_task_failure_empty_title}
/// Exception thrown when a task fails to be updated due to an empty title.
/// {@endtemplate}
class UpdateTaskFailureEmptyTitle extends UpdateTaskFailure {
  /// {@macro update_task_failure_empty_title}
  const UpdateTaskFailureEmptyTitle();
}
