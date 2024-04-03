/// {@template create_{{object.snakeCase()}}_failure}
/// Exception thrown when an altoke entity fails to be created.
/// {@endtemplate}
sealed class CreateAltokeEntityFailure implements Exception {
  /// {@macro create_{{object.snakeCase()}}_failure}
  const CreateAltokeEntityFailure();
}

/// {@template create_{{object.snakeCase()}}_failure_empty_name}
/// Exception thrown when an altoke entity fails to be created due to an empty
/// name.
/// {@endtemplate}
class CreateAltokeEntityFailureEmptyName extends CreateAltokeEntityFailure {
  /// {@macro create_{{object.snakeCase()}}_failure_empty_name}
  const CreateAltokeEntityFailureEmptyName();
}
