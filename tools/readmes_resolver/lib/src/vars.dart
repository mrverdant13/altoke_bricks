import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:readmes_resolver/src/exceptions.dart';

abstract final class Vars {
  static final _notInMonoRepoError = StateError(
    'Invalid environment. '
    'This operation must be run under a mono-repo managed by Melos. ',
  );

  static const scopeNameSuffix = '_brick_scope';
  static const hooksNameSuffix = '_brick_hooks';

  static final rootPath = () {
    final rootPath = Platform.environment['MELOS_ROOT_PATH'] ?? '';
    if (rootPath.isEmpty) throw _notInMonoRepoError;
    return rootPath;
  }();

  static final packagePath = () {
    final packagePath = Platform.environment['MELOS_PACKAGE_PATH'] ?? '';
    if (packagePath.isEmpty) throw _notInMonoRepoError;
    return packagePath;
  }();

  static final packageName = () {
    final packageName = Platform.environment['MELOS_PACKAGE_NAME'] ?? '';
    if (packageName.isEmpty) throw _notInMonoRepoError;
    return packageName;
  }();

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

  static final scopePath = () {
    // ignore: unnecessary_statements
    scopeName; // Ensure the scope name is valid.
    return packagePath;
  }();

  static final scopeBrickGenDataPath = path.join(
    scopePath,
    'brick-gen.json',
  );

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

  static final hooksPath = () {
    // ignore: unnecessary_statements
    hooksName; // Ensure the hooks name is valid.
    return packagePath;
  }();

  static final brickPath = () {
    try {
      return path.join(scopePath, 'brick');
    } catch (_) {}
    try {
      return path.normalize(path.join(hooksPath, '..'));
    } catch (_) {}
    throw const AbsentBrickReferencePaths();
  }();
}

extension on String {
  bool get isValidScopeName => endsWith(Vars.scopeNameSuffix);
  bool get isValidHooksName => endsWith(Vars.hooksNameSuffix);
}
