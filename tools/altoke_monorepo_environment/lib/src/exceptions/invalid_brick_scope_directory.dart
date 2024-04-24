/// {@template invalid_brick_scope_dir_error}
/// Error thrown when the brick scope directory is invalid.
/// {@endtemplate}
sealed class InvalidBrickScopeDirError implements Exception {
  const InvalidBrickScopeDirError(
    this.reason,
  );

  /// Reason for the error.
  final String reason;

  @override
  String toString() {
    return 'Invalid brick scope directory.\n$reason';
  }
}

/// {@template invalid_brick_scope_name_error}
/// Error thrown when the brick scope name is invalid.
/// {@endtemplate}
class InvalidBrickScopeNameError extends InvalidBrickScopeDirError {
  /// {@macro invalid_brick_scope_name_error}
  const InvalidBrickScopeNameError({
    required String description,
  }) : super(description);
}

/// {@template brick_scope_dir_not_found_error}
/// Error thrown when the brick scope directory is not found.
/// {@endtemplate}
class BrickScopeDirNotFoundError extends InvalidBrickScopeDirError {
  /// {@macro brick_scope_dir_not_found_error}
  const BrickScopeDirNotFoundError({
    required String scopePath,
  }) : super('Brick scope directory not found ($scopePath).');
}

/// {@template brick_scope_gen_data_not_found_error}
/// Error thrown when the brick scope generation data file is not found.
/// {@endtemplate}
class BrickScopeGenDataNotFoundError extends InvalidBrickScopeDirError {
  /// {@macro brick_scope_gen_data_not_found_error}
  const BrickScopeGenDataNotFoundError({
    required String brickGenDataPath,
  }) : super('Brick generation data file not found ($brickGenDataPath).');
}
