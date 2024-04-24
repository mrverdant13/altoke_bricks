/// {@template update_{{object.snakeCase()}}_failure}
/// Exception thrown when a {{object.lowerCase()}} fails to be updated.
/// {@endtemplate}
sealed class Update{{object.pascalCase()}}Failure implements Exception {
  /// {@macro update_{{object.snakeCase()}}_failure}
  const Update{{object.pascalCase()}}Failure();
}

/// {@template update_{{object.snakeCase()}}_failure_empty_name}
/// Exception thrown when a {{object.lowerCase()}} fails to be updated due to an empty
/// name.
/// {@endtemplate}
class Update{{object.pascalCase()}}FailureEmptyName extends Update{{object.pascalCase()}}Failure {
  /// {@macro update_{{object.snakeCase()}}_failure_empty_name}
  const Update{{object.pascalCase()}}FailureEmptyName();
}
