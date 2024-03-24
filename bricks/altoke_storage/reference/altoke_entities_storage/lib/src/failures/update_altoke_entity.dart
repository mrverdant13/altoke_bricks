/// {@template update_altoke_entity_failure}
/// Exception thrown when a altoke entity fails to be updated.
/// {@endtemplate}
sealed class UpdateAltokeEntityFailure implements Exception {
  /// {@macro update_altoke_entity_failure}
  const UpdateAltokeEntityFailure();
}

/// {@template update_altoke_entity_failure_empty_name}
/// Exception thrown when a altoke entity fails to be updated due to an empty
/// name.
/// {@endtemplate}
class UpdateAltokeEntityFailureEmptyName extends UpdateAltokeEntityFailure {
  /// {@macro update_altoke_entity_failure_empty_name}
  const UpdateAltokeEntityFailureEmptyName();
}
