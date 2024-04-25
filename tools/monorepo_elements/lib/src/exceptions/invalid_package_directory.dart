/// {@template invalid_package_directory_error}
/// Error thrown when the package directory is invalid.
/// {@endtemplate}
sealed class InvalidPackageDirectoryError implements Exception {
  const InvalidPackageDirectoryError(
    this.reason,
  );

  /// Reason for the error.
  final String reason;

  @override
  String toString() {
    return 'Invalid package directory.\n$reason';
  }
}

/// {@template package_dir_not_found_error}
/// Error thrown when the package directory is not found.
/// {@endtemplate}
class PackageDirNotFoundError extends InvalidPackageDirectoryError {
  /// {@macro package_dir_not_found_error}
  const PackageDirNotFoundError({
    required String packagePath,
  }) : super('Package directory not found ($packagePath).');
}
