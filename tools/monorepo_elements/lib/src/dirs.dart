import 'dart:io';

import 'package:monorepo_elements/monorepo_elements.dart';
import 'package:path/path.dart' as path;

/// Directories related to a monorepo environment.
abstract final class Dirs {
  /// Root directory of the monorepo.
  static final root = () {
    final dir = Directory(Vars.rootPath);
    if (dir.existsSync()) return dir;
    throw RootDirNotFoundError(rootPath: dir.path);
  }();

  /// Directory of a package managed by the monorepo.
  static final package = () {
    final dir = Directory(Vars.packagePath);
    if (dir.existsSync()) return dir;
    throw PackageDirNotFoundError(packagePath: dir.path);
  }();

  /// Directory of a brick scope managed by the monorepo.
  static final scope = () {
    final dir = Directory(Vars.scopePath);
    if (dir.existsSync()) return dir;
    throw BrickScopeDirNotFoundError(scopePath: dir.path);
  }();

  /// Directory of a brick hooks managed by the monorepo.
  static final hooks = () {
    final dir = Directory(Vars.hooksPath);
    if (dir.existsSync()) return dir;
    throw BrickHooksDirNotFoundError(hooksPath: dir.path);
  }();

  /// Directory of a brick E2E test managed by the monorepo.
  static final e2eTest = () {
    final dir = Directory(Vars.e2eTestPath);
    if (dir.existsSync()) return dir;
    throw BrickE2eDirNotFoundError(e2ePath: dir.path);
  }();

  /// Directory of a brick managed by the monorepo.
  static final brick = () {
    final dir = Directory(Vars.brickPath);
    if (dir.existsSync()) return dir;
    throw BrickDirNotFoundError(brickPath: dir.path);
  }();

  /// Directory of a brick template managed by the monorepo.
  static final brickTemplate = () {
    final dir = Directory(Vars.brickTemplatePath);
    if (dir.existsSync()) return dir;
    throw BrickTemplateDirNotFoundError(templatePath: dir.path);
  }();
}

/// A set of additional utilities for [Directory].
extension ExtendedDirectory on Directory {
  /// Returns a descendant [Directory] of the current [Directory].
  Directory descendantDir(String descendantPath) {
    return Directory(path.join(this.path, descendantPath));
  }

  /// Returns a descendant [File] of the current [Directory].
  File descendantFile(String descendantPath) {
    return File(path.join(this.path, descendantPath));
  }
}
