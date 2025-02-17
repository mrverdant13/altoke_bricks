/// {@template invalid_brick_hooks_dir_error}
/// Error thrown when the brick hooks directory is invalid.
/// {@endtemplate}
sealed class InvalidBrickHooksDirError implements Exception {
  const InvalidBrickHooksDirError(this.reason);

  /// Reason for the error.
  final String reason;

  @override
  String toString() {
    return 'Invalid brick hooks directory.\n$reason';
  }
}

/// {@template invalid_brick_hooks_name_error}
/// Error thrown when the brick hooks name is invalid.
/// {@endtemplate}
class InvalidBrickHooksNameError extends InvalidBrickHooksDirError {
  /// {@macro invalid_brick_hooks_name_error}
  const InvalidBrickHooksNameError({required String description})
    : super(description);
}

/// {@template brick_hooks_dir_not_found_error}
/// Error thrown when the brick hooks directory is not found.
/// {@endtemplate}
class BrickHooksDirNotFoundError extends InvalidBrickHooksDirError {
  /// {@macro brick_hooks_dir_not_found_error}
  const BrickHooksDirNotFoundError({required String hooksPath})
    : super('Brick hooks directory not found ($hooksPath).');
}
