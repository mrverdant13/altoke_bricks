/// {@template create_{{object.snakeCase()}}_failure}
/// Exception thrown when an {{object.lowerCase()}} fails to be created.
/// {@endtemplate}
sealed class Create{{object.pascalCase()}}Failure implements Exception {
  /// {@macro create_{{object.snakeCase()}}_failure}
  const Create{{object.pascalCase()}}Failure();
}

/// {@template create_{{object.snakeCase()}}_failure_empty_name}
/// Exception thrown when an {{object.lowerCase()}} fails to be created due to an empty
/// name.
/// {@endtemplate}
class Create{{object.pascalCase()}}FailureEmptyName extends Create{{object.pascalCase()}}Failure {
  /// {@macro create_{{object.snakeCase()}}_failure_empty_name}
  const Create{{object.pascalCase()}}FailureEmptyName();
}
