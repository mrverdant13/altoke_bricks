import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:readme_unifier/src/exceptions.dart';
import 'package:readme_unifier/src/vars.dart';

abstract final class Files {
  static final rootReadme = () {
    final file = File(
      path.join(
        Vars.rootPath,
        'README.md',
      ),
    );
    if (!file.existsSync()) {
      throw RootReadmeNotFoundError(readmePath: file.path);
    }
    return file;
  }();

  static final brickGenData = () {
    final file = File(Vars.scopeBrickGenDataPath);
    if (!file.existsSync()) {
      throw BrickScopeGenDataNotFoundError(
        brickGenDataPath: file.path,
      );
    }
    return file;
  }();

  static final brickReadme = () {
    final file = File(
      path.join(
        Vars.brickPath,
        'README.md',
      ),
    );
    if (!file.existsSync()) {
      throw BrickReadmeNotFoundError(
        readmePath: file.path,
      );
    }
    return file;
  }();
}
