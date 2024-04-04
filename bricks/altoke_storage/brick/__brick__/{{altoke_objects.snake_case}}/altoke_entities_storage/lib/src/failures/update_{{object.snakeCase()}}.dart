/// {@template update_{{object.snakeCase()}}_failure}
/// Exception thrown when a altoke entity fails to be updated.
/// {@endtemplate}
sealed class UpdateAltokeEntityFailure implements Exception {
  /// {@macro update_{{object.snakeCase()}}_failure}
  const UpdateAltokeEntityFailure();
}

/// {@template update_{{object.snakeCase()}}_failure_empty_name}
/// Exception thrown when a altoke entity fails to be updated due to an empty
/// name.
/// {@endtemplate}
class UpdateAltokeEntityFailureEmptyName extends UpdateAltokeEntityFailure {
  /// {@macro update_{{object.snakeCase()}}_failure_empty_name}
  const UpdateAltokeEntityFailureEmptyName();
}
