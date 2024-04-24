/// {@template invalid_brick_dir_error}
/// Error thrown when the brick directory is invalid.
/// {@endtemplate}
sealed class InvalidBrickDirError implements Exception {
  const InvalidBrickDirError(
    this.reason,
  );

  /// Reason for the error.
  final String reason;

  @override
  String toString() {
    return 'Invalid brick directory.\n$reason';
  }
}

/// {@template absent_brick_reference_paths}
/// Error thrown when the brick reference paths are absent.
/// {@endtemplate}
class AbsentBrickReferencePaths extends InvalidBrickDirError {
  /// {@macro absent_brick_reference_paths}
  const AbsentBrickReferencePaths()
      : super(
          'Missing brick reference paths. '
          'For this brick to be identified, '
          'the calling script must be run for a hooks or scope package.',
        );
}

/// {@template brick_dir_not_found_error}
/// Error thrown when the brick directory is not found.
/// {@endtemplate}
class BrickDirNotFoundError extends InvalidBrickDirError {
  /// {@macro brick_dir_not_found_error}
  const BrickDirNotFoundError({
    required String brickPath,
  }) : super('Brick directory not found ($brickPath).');
}

/// {@template brick_readme_not_found_error}
/// Error thrown when the brick README file is not found.
/// {@endtemplate}
class BrickReadmeNotFoundError extends InvalidBrickDirError {
  /// {@macro brick_readme_not_found_error}
  const BrickReadmeNotFoundError({
    required String readmePath,
  }) : super('Brick README file not found ($readmePath).');
}

/// {@template brick_manifest_not_found_error}
/// Error thrown when the brick manifest file is not found.
/// {@endtemplate}
class BrickManifestNotFoundError extends InvalidBrickDirError {
  /// {@macro brick_manifest_not_found_error}
  const BrickManifestNotFoundError({
    required String manifestPath,
  }) : super('Brick manifest file not found ($manifestPath).');
}
