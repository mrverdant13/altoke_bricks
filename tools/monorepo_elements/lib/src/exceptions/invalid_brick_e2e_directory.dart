/// {@template invalid_brick_e2e_dir_error}
/// Error thrown when the brick E2E directory is invalid.
/// {@endtemplate}
sealed class InvalidBrickE2eDirError implements Exception {
  const InvalidBrickE2eDirError(this.reason);

  /// Reason for the error.
  final String reason;

  @override
  String toString() {
    return 'Invalid brick E2E directory.\n$reason';
  }
}

/// {@template invalid_brick_e2e_name_error}
/// Error thrown when the brick E2E name is invalid.
/// {@endtemplate}
class InvalidBrickE2eNameError extends InvalidBrickE2eDirError {
  /// {@macro invalid_brick_e2e_name_error}
  const InvalidBrickE2eNameError({required String description})
    : super(description);
}

/// {@template brick_e2e_dir_not_found_error}
/// Error thrown when the brick E2E directory is not found.
/// {@endtemplate}
class BrickE2eDirNotFoundError extends InvalidBrickE2eDirError {
  /// {@macro brick_e2e_dir_not_found_error}
  const BrickE2eDirNotFoundError({required String e2ePath})
    : super('Brick E2E directory not found ($e2ePath).');
}
