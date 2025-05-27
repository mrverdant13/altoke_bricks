import 'dart:io';

import 'package:monorepo_elements/monorepo_elements.dart';

/// Files related to a monorepo environment.
abstract final class Files {
  /// Root README file of the monorepo.
  static final File rootReadme = () {
    final file = Dirs.root.descendantFile('README.md');
    if (file.existsSync()) return file;
    throw RootReadmeNotFoundError(readmePath: file.path);
  }();

  /// Brick generation data file of a brick scope managed by the monorepo.
  static final File brickGenData = () {
    final file = File(Vars.scopeBrickGenDataPath);
    if (file.existsSync()) return file;
    throw BrickScopeGenDataNotFoundError(brickGenDataPath: file.path);
  }();

  /// README file of a brick scope managed by the monorepo.
  static final File brickReadme = () {
    final file = Dirs.brick.descendantFile('README.md');
    if (file.existsSync()) return file;
    throw BrickReadmeNotFoundError(readmePath: file.path);
  }();

  /// Manifest file of a brick managed by the monorepo.
  static final File brickManifest = () {
    final file = Dirs.brick.descendantFile('brick.yaml');
    if (file.existsSync()) return file;
    throw BrickManifestNotFoundError(manifestPath: file.path);
  }();
}
