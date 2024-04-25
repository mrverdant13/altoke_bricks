/// {@template invalid_root_directory_error}
/// Error thrown when the root directory of the monorepo is invalid.
/// {@endtemplate}
sealed class InvalidRootDirectoryError implements Exception {
  const InvalidRootDirectoryError(
    this.reason,
  );

  /// Reason for the error.
  final String reason;

  @override
  String toString() {
    return 'Invalid root directory.\n$reason';
  }
}

/// {@template root_dir_not_found_error}
/// Error thrown when the root directory of the monorepo is not found.
/// {@endtemplate}
class RootDirNotFoundError extends InvalidRootDirectoryError {
  /// {@macro root_dir_not_found_error}
  const RootDirNotFoundError({
    required String rootPath,
  }) : super('Root directory not found ($rootPath).');
}

/// {@template root_readme_not_found_error}
/// Error thrown when the root README file is not found.
/// {@endtemplate}
class RootReadmeNotFoundError extends InvalidRootDirectoryError {
  /// {@macro root_readme_not_found_error}
  const RootReadmeNotFoundError({
    required String readmePath,
  }) : super('Root README file not found ($readmePath).');
}
