/// {@template create_altoke_entity_failure}
/// Exception thrown when an altoke entity fails to be created.
/// {@endtemplate}
sealed class CreateAltokeEntityFailure implements Exception {
  /// {@macro create_altoke_entity_failure}
  const CreateAltokeEntityFailure();
}

/// {@template create_altoke_entity_failure_empty_name}
/// Exception thrown when an altoke entity fails to be created due to an empty
/// name.
/// {@endtemplate}
class CreateAltokeEntityFailureEmptyName extends CreateAltokeEntityFailure {
  /// {@macro create_altoke_entity_failure_empty_name}
  const CreateAltokeEntityFailureEmptyName();
}
