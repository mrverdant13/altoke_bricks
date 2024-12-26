import 'dart:io';

import 'package:monorepo_elements/monorepo_elements.dart';

/// Directories related to a monorepo environment.
abstract final class Dirs {
  /// Root directory of the monorepo.
  static final root = () {
    final dir = Directory(Vars.rootPath);
    if (!dir.existsSync()) {
      throw RootDirNotFoundError(
        rootPath: dir.path,
      );
    }
    return dir;
  }();

  /// Directory of a package managed by the monorepo.
  static final package = () {
    final dir = Directory(Vars.packagePath);
    if (!dir.existsSync()) {
      throw PackageDirNotFoundError(
        packagePath: dir.path,
      );
    }
    return dir;
  }();

  /// Directory of a brick scope managed by the monorepo.
  static final scope = () {
    final dir = Directory(Vars.scopePath);
    if (!dir.existsSync()) {
      throw BrickScopeDirNotFoundError(
        scopePath: dir.path,
      );
    }
    return dir;
  }();

  /// Directory of a brick hooks managed by the monorepo.
  static final hooks = () {
    final dir = Directory(Vars.hooksPath);
    if (!dir.existsSync()) {
      throw BrickHooksDirNotFoundError(
        hooksPath: dir.path,
      );
    }
    return dir;
  }();

  /// Directory of a brick E2E test managed by the monorepo.
  static final e2eTest = () {
    final dir = Directory(Vars.e2eTestPath);
    if (!dir.existsSync()) {
      throw BrickE2eDirNotFoundError(
        e2ePath: dir.path,
      );
    }
    return dir;
  }();

  /// Directory of a brick managed by the monorepo.
  static final brick = () {
    final dir = Directory(Vars.brickPath);
    if (!dir.existsSync()) {
      throw BrickDirNotFoundError(
        brickPath: dir.path,
      );
    }
    return dir;
  }();

  /// Directory of a brick template managed by the monorepo.
  static final brickTemplate = () {
    final dir = Directory(Vars.brickTemplatePath);
    if (dir.existsSync()) return dir;
    throw BrickTemplateDirNotFoundError(templatePath: dir.path);
  }();
}
