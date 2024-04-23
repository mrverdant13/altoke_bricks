import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:readmes_resolver/src/exceptions.dart';
import 'package:readmes_resolver/src/vars.dart';

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

  static final brickManifest = () {
    final file = File(
      path.join(
        Vars.brickPath,
        'brick.yaml',
      ),
    );
    if (!file.existsSync()) {
      throw BrickManifestNotFoundError(
        manifestPath: file.path,
      );
    }
    return file;
  }();
}
