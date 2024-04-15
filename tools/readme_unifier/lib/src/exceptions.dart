sealed class InvalidRootDirectoryError implements Exception {
  const InvalidRootDirectoryError(
    this.reason,
  );

  final String reason;

  @override
  String toString() {
    return 'Invalid root directory.\n$reason';
  }
}

class RootDirNotFoundError extends InvalidRootDirectoryError {
  const RootDirNotFoundError({
    required String rootPath,
  }) : super('Root directory not found ($rootPath).');
}

class RootReadmeNotFoundError extends InvalidRootDirectoryError {
  const RootReadmeNotFoundError({
    required String readmePath,
  }) : super('Root README file not found ($readmePath).');
}

/* ========================================================================== */

sealed class InvalidPackageDirectoryError implements Exception {
  const InvalidPackageDirectoryError(
    this.reason,
  );

  final String reason;

  @override
  String toString() {
    return 'Invalid package directory.\n$reason';
  }
}

class PackageDirNotFoundError extends InvalidPackageDirectoryError {
  const PackageDirNotFoundError({
    required String packagePath,
  }) : super('Package directory not found ($packagePath).');
}

/* ========================================================================== */

sealed class InvalidBrickScopeDirError implements Exception {
  const InvalidBrickScopeDirError(
    this.reason,
  );

  final String reason;

  @override
  String toString() {
    return 'Invalid brick scope directory.\n$reason';
  }
}

class InvalidBrickScopeNameError extends InvalidBrickScopeDirError {
  const InvalidBrickScopeNameError({
    required String description,
  }) : super(description);
}

class BrickScopeDirNotFoundError extends InvalidBrickScopeDirError {
  const BrickScopeDirNotFoundError({
    required String scopePath,
  }) : super('Brick scope directory not found ($scopePath).');
}

class BrickScopeGenDataNotFoundError extends InvalidBrickScopeDirError {
  const BrickScopeGenDataNotFoundError({
    required String brickGenDataPath,
  }) : super('Brick generation data file not found ($brickGenDataPath).');
}

/* ========================================================================== */

sealed class InvalidBrickHooksDirError implements Exception {
  const InvalidBrickHooksDirError(
    this.reason,
  );

  final String reason;

  @override
  String toString() {
    return 'Invalid brick hooks directory.\n$reason';
  }
}

class InvalidBrickHooksNameError extends InvalidBrickHooksDirError {
  const InvalidBrickHooksNameError({
    required String description,
  }) : super(description);
}

class BrickHooksDirNotFoundError extends InvalidBrickHooksDirError {
  const BrickHooksDirNotFoundError({
    required String hooksPath,
  }) : super('Brick hooks directory not found ($hooksPath).');
}

/* ========================================================================== */

sealed class InvalidBrickDirError implements Exception {
  const InvalidBrickDirError(
    this.reason,
  );

  final String reason;

  @override
  String toString() {
    return 'Invalid brick directory.\n$reason';
  }
}

class AbsentBrickReferencePaths extends InvalidBrickDirError {
  const AbsentBrickReferencePaths()
      : super(
          'Missing brick reference paths. '
          'For this brick to be identified, '
          'the calling script must be run for a hooks or scope package.',
        );
}

class BrickDirNotFoundError extends InvalidBrickDirError {
  const BrickDirNotFoundError({
    required String brickPath,
  }) : super('Brick directory not found ($brickPath).');
}

class BrickReadmeNotFoundError extends InvalidBrickDirError {
  const BrickReadmeNotFoundError({
    required String readmePath,
  }) : super('Brick README file not found ($readmePath).');
}
