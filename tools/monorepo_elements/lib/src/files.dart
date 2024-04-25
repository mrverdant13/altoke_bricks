import 'dart:io';

import 'package:monorepo_elements/monorepo_elements.dart';
import 'package:path/path.dart' as path;

/// Files related to a monorepo environment.
abstract final class Files {
  /// Root README file of the monorepo.
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

  /// Brick generation data file of a brick scope managed by the monorepo.
  static final brickGenData = () {
    final file = File(Vars.scopeBrickGenDataPath);
    if (!file.existsSync()) {
      throw BrickScopeGenDataNotFoundError(
        brickGenDataPath: file.path,
      );
    }
    return file;
  }();

  /// README file of a brick scope managed by the monorepo.
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

  /// Manifest file of a brick managed by the monorepo.
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
