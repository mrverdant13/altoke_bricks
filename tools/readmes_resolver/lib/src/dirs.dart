import 'dart:io';

import 'package:readmes_resolver/src/exceptions.dart';
import 'package:readmes_resolver/src/vars.dart';

abstract final class Dirs {
  static final root = () {
    final dir = Directory(Vars.rootPath);
    if (!dir.existsSync()) {
      throw RootDirNotFoundError(
        rootPath: dir.path,
      );
    }
    return dir;
  }();

  static final package = () {
    final dir = Directory(Vars.packagePath);
    if (!dir.existsSync()) {
      throw PackageDirNotFoundError(
        packagePath: dir.path,
      );
    }
    return dir;
  }();

  static final scope = () {
    final dir = Directory(Vars.scopePath);
    if (!dir.existsSync()) {
      throw BrickScopeDirNotFoundError(
        scopePath: dir.path,
      );
    }
    return dir;
  }();

  static final hooks = () {
    final dir = Directory(Vars.hooksPath);
    if (!dir.existsSync()) {
      throw BrickHooksDirNotFoundError(
        hooksPath: dir.path,
      );
    }
    return dir;
  }();

  static final brick = () {
    final dir = Directory(Vars.brickPath);
    if (!dir.existsSync()) {
      throw BrickDirNotFoundError(
        brickPath: dir.path,
      );
    }
    return dir;
  }();
}
