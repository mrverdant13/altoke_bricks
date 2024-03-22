/// {@template update_altoke_object_failure}
/// Exception thrown when a altoke object fails to be updated.
/// {@endtemplate}
sealed class UpdateAltokeObjectFailure implements Exception {
  /// {@macro update_altoke_object_failure}
  const UpdateAltokeObjectFailure();
}

/// {@template update_altoke_object_failure_empty_name}
/// Exception thrown when a altoke object fails to be updated due to an empty name.
/// {@endtemplate}
class UpdateAltokeObjectFailureEmptyName extends UpdateAltokeObjectFailure {
  /// {@macro update_altoke_object_failure_empty_name}
  const UpdateAltokeObjectFailureEmptyName();
}
