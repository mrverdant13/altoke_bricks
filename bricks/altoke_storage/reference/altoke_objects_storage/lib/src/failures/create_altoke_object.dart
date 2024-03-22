/// {@template create_altoke_object_failure}
/// Exception thrown when an altoke object fails to be created.
/// {@endtemplate}
sealed class CreateAltokeObjectFailure implements Exception {
  /// {@macro create_altoke_object_failure}
  const CreateAltokeObjectFailure();
}

/// {@template create_altoke_object_failure_empty_name}
/// Exception thrown when an altoke object fails to be created due to an empty name.
/// {@endtemplate}
class CreateAltokeObjectFailureEmptyName extends CreateAltokeObjectFailure {
  /// {@macro create_altoke_object_failure_empty_name}
  const CreateAltokeObjectFailureEmptyName();
}
