import 'dart:io';

import 'package:monorepo_elements/monorepo_elements.dart';
import 'package:path/path.dart' as path;

/// Variables related to a monorepo environment.
abstract final class Vars {
  /// Suffix of a brick scope name.
  static const scopeNameSuffix = '_brick_scope';

  /// Suffix of a brick hooks name.
  static const hooksNameSuffix = '_brick_hooks';

  /// Path to the root directory of the monorepo.
  static final rootPath = () {
    final rootPath = Platform.environment['MELOS_ROOT_PATH'] ?? '';
    if (rootPath.isEmpty) throw const InvalidRuntimeError();
    return rootPath;
  }();

  /// Path to the directory of a package managed by the monorepo.
  static final packagePath = () {
    final packagePath = Platform.environment['MELOS_PACKAGE_PATH'] ?? '';
    if (packagePath.isEmpty) throw const InvalidRuntimeError();
    return packagePath;
  }();

  /// Name of a package managed by the monorepo.
  static final packageName = () {
    final packageName = Platform.environment['MELOS_PACKAGE_NAME'] ?? '';
    if (packageName.isEmpty) throw const InvalidRuntimeError();
    return packageName;
  }();

  /// Name of a brick scope managed by the monorepo.
  static final scopeName = () {
    final scopeName = packageName;
    if (!scopeName.isValidScopeName) {
      throw InvalidBrickScopeNameError(
        description: 'The package name must end with "$scopeNameSuffix" '
            '($scopeName).',
      );
    }
    return scopeName;
  }();

  /// Path to the directory of a brick scope managed by the monorepo.
  static final scopePath = () {
    // ignore: unnecessary_statements
    scopeName; // Ensure the scope name is valid.
    return packagePath;
  }();

  /// Path to the brick generation data file of a brick scope managed by the
  /// monorepo.
  static final scopeBrickGenDataPath = path.join(
    scopePath,
    'brick-gen.json',
  );

  /// Name of a brick hooks managed by the monorepo.
  static final hooksName = () {
    final hooksName = packageName;
    if (!hooksName.isValidHooksName) {
      throw InvalidBrickHooksNameError(
        description:
            'The package name must end with "$hooksNameSuffix" ($hooksName).',
      );
    }
    return hooksName;
  }();

  /// Path to the directory of a brick hooks managed by the monorepo.
  static final hooksPath = () {
    // ignore: unnecessary_statements
    hooksName; // Ensure the hooks name is valid.
    return packagePath;
  }();

  /// Path to the brick directory of a brick managed by the monorepo.
  static final brickPath = () {
    try {
      return path.join(scopePath, 'brick');
    } catch (_) {}
    try {
      return path.normalize(path.join(hooksPath, '..'));
    } catch (_) {}
    throw const AbsentBrickReferencePaths();
  }();

  /// Name of a brick managed by the monorepo.
  static final brickName = path.basename(path.dirname(brickPath));
}

extension on String {
  bool get isValidScopeName => endsWith(Vars.scopeNameSuffix);
  bool get isValidHooksName => endsWith(Vars.hooksNameSuffix);
}
