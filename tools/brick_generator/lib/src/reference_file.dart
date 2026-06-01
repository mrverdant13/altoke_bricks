import 'dart:io';

import 'package:brick_generator/src/models/models.dart';
import 'package:brick_generator/src/resolve_reference_content.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:shell/git.dart';

/// Extension methods for a reference [File] to be parametrized.
extension ReferenceFile on File {
  /// Parametrizes the reference file.
  Future<void> parametrize({required BrickGenData brickGenData}) async {
    if (await isGitIgnored) {
      await delete(recursive: true);
      return;
    }
    final resolvedPath = _resolvePath(brickGenData: brickGenData);
    final resultingFile = await () async {
      if (p.equals(resolvedPath, path)) return this;
      final dir = Directory(p.dirname(resolvedPath));
      if (!dir.existsSync()) await dir.create(recursive: true);
      return rename(resolvedPath);
    }();
    await resultingFile._resolveContents(brickGenData: brickGenData);
  }

  /// Checks if the reference file is git ignored.
  @visibleForTesting
  Future<bool> get isGitIgnored async {
    try {
      await Git.ignores(this);
      return true;
    } on Object {
      return false;
    }
  }

  /// Resolves the parametrized contents of the reference [File].
  Future<void> _resolveContents({required BrickGenData brickGenData}) async {
    const ignoredExtensions = {
      '.png',
      '.webp', // cspell:disable-line
    };
    if (ignoredExtensions.contains(p.extension(path))) return;
    final referenceContent = await readAsString();
    final resolvedContents = resolveReferenceContent(
      content: referenceContent,
      targetRelativePath: p.relative(
        path,
        from: brickGenData.targetAbsolutePath,
      ),
      brickGenData: brickGenData,
    );
    await writeAsString(resolvedContents);
  }

  /// Resolves the parametrized path of the reference [File].
  String _resolvePath({required BrickGenData brickGenData}) {
    return brickGenData.applyReplacementsToTargetRelativeDescendant(path);
  }
}
