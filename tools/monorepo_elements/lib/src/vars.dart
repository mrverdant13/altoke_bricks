import 'dart:io';

import 'package:monorepo_elements/monorepo_elements.dart';
import 'package:path/path.dart' as path;

/// Variables related to a monorepo environment.
abstract final class Vars {
  /// Suffix of a brick scope name.
  static const scopeNameSuffix = '_brick_scope';

  /// Suffix of a brick hooks name.
  static const hooksNameSuffix = '_brick_hooks';

  /// Suffix of a brick E2E test name.
  static const e2eTestNameSuffix = '_e2e';

  /// Path to the root directory of the monorepo.
  static final String rootPath = () {
    final rootPath = Platform.environment['MELOS_ROOT_PATH'] ?? '';
    if (rootPath.isEmpty) throw const InvalidRuntimeError();
    return rootPath;
  }();

  /// Path to the directory of a package managed by the monorepo.
  static final String packagePath = () {
    final packagePath = Platform.environment['MELOS_PACKAGE_PATH'] ?? '';
    if (packagePath.isEmpty) throw const InvalidRuntimeError();
    return packagePath;
  }();

  /// Name of a package managed by the monorepo.
  static final String packageName = () {
    final packageName = Platform.environment['MELOS_PACKAGE_NAME'] ?? '';
    if (packageName.isEmpty) throw const InvalidRuntimeError();
    return packageName;
  }();

  /// Name of a brick scope managed by the monorepo.
  static final String scopeName = () {
    final scopeName = packageName;
    if (!scopeName.isValidScopeName) {
      throw InvalidBrickScopeNameError(
        description:
            'The package name must end with "$scopeNameSuffix" '
            '($scopeName).',
      );
    }
    return scopeName;
  }();

  /// Path to the directory of a brick scope managed by the monorepo.
  static final String scopePath = () {
    // Required to ensure the scope name is valid.
    // ignore: unnecessary_statements
    scopeName; // Ensure the scope name is valid.
    return packagePath;
  }();

  /// Path to the brick generation data file of a brick scope managed by the
  /// monorepo.
  static final String scopeBrickGenDataPath = path.join(
    scopePath,
    'brick-gen.json',
  );

  /// Name of a brick hooks managed by the monorepo.
  static final String hooksName = () {
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
  static final String hooksPath = () {
    // Required to ensure the hooks name is valid.
    // ignore: unnecessary_statements
    hooksName; // Ensure the hooks name is valid.
    return packagePath;
  }();

  /// Name of a brick E2E test managed by the monorepo.
  static final String e2eTestName = () {
    final e2eTestName = packageName;
    if (!e2eTestName.endsWith(e2eTestNameSuffix)) {
      throw InvalidBrickE2eNameError(
        description:
            'The package name must end with '
            '"$e2eTestNameSuffix" ($e2eTestName).',
      );
    }
    return e2eTestName;
  }();

  /// Path to the directory of a brick E2E test managed by the monorepo.
  static final String e2eTestPath = () {
    // Required to ensure the E2E test name is valid.
    // ignore: unnecessary_statements
    e2eTestName; // Ensure the E2E test name is valid.
    return packagePath;
  }();

  /// Path to the brick directory of a brick managed by the monorepo.
  static final String brickPath = () {
    try {
      return path.join(scopePath, 'brick');
    } on Object {
      // Ignoring the error to continue.
    }
    try {
      return path.normalize(path.join(hooksPath, '..'));
    } on Object {
      // Ignoring the error to continue.
    }
    try {
      return path.normalize(path.join(e2eTestPath, '..', 'brick'));
    } on Object {
      // Ignoring the error to continue.
    }
    throw const AbsentBrickReferencePaths();
  }();

  /// Path to the template directory of a brick managed by the monorepo.
  static final String brickTemplatePath = path.joinAll([
    scopePath,
    'brick',
    '__brick__',
  ]);

  /// Name of a brick managed by the monorepo.
  static final String brickName = path.basename(path.dirname(brickPath));
}

extension on String {
  bool get isValidScopeName => endsWith(Vars.scopeNameSuffix);
  bool get isValidHooksName => endsWith(Vars.hooksNameSuffix);
}
