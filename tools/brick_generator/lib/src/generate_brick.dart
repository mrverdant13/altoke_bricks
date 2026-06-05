import 'dart:convert';
import 'dart:io';

import 'package:brick_generator/src/models/brick_gen_data.dart';
import 'package:brick_generator/src/models/brick_gen_options.dart';
import 'package:brick_generator/src/reference_file.dart';
import 'package:meta/meta.dart';
import 'package:monorepo_elements/monorepo_elements.dart';
import 'package:path/path.dart' as p;
import 'package:shell/git.dart';
import 'package:shell/shell.dart';

/// Resolved paths for a brick scope used during generation.
@visibleForTesting
class ResolvedBrickScope {
  /// Creates [ResolvedBrickScope].
  const ResolvedBrickScope({
    required this.scopeDir,
    required this.brickGenDataFile,
    required this.brickTemplateDir,
  });

  /// Brick scope root directory.
  final Directory scopeDir;

  /// Brick generation configuration file.
  final File brickGenDataFile;

  /// Brick template output directory (`brick/__brick__`).
  final Directory brickTemplateDir;
}

/// Resolves brick scope paths from [scopePath] or the active Melos scope.
@visibleForTesting
ResolvedBrickScope resolveBrickScope({String? scopePath}) {
  if (scopePath != null) {
    return ResolvedBrickScope(
      scopeDir: Directory(scopePath),
      brickGenDataFile: File(p.join(scopePath, 'brick-gen.json')),
      brickTemplateDir: Directory(p.join(scopePath, 'brick', '__brick__')),
    );
  }
  return ResolvedBrickScope( // coverage:ignore-line
    scopeDir: Dirs.scope, // coverage:ignore-line
    brickGenDataFile: Files.brickGenData, // coverage:ignore-line
    brickTemplateDir: Dirs.brickTemplate, // coverage:ignore-line
  ); // coverage:ignore-line
}

/// Generates a brick template from the current scope's reference project.
///
/// When [scopePath] is provided (tests only), it is used instead of
/// [Dirs.scope] and [Files.brickGenData].
Future<void> generateBrick({
  @visibleForTesting String? scopePath,
  @visibleForTesting bool? cleanWithGit,
}) async {
  final shouldCleanWithGit = cleanWithGit ?? scopePath == null;
  final resolved = resolveBrickScope(scopePath: scopePath);
  final scopeDir = resolved.scopeDir;
  final brickGenDataFile = resolved.brickGenDataFile;
  stdout.writeln('Brick generation data file: ${brickGenDataFile.path}');
  late final BrickGenOptions brickGenOptions;
  try {
    final rawBrickGenData = await brickGenDataFile.readAsString();
    final brickGenDataJson =
        jsonDecode(rawBrickGenData) as Map<String, dynamic>;
    brickGenOptions = BrickGenOptions.fromJson(brickGenDataJson);
  } catch (e) {
    throw Exception(
      'Invalid brick generation data file. '
      'Error: $e',
    );
  }
  final referenceDir = scopeDir.descendantDir('reference');
  if (!referenceDir.existsSync()) {
    throw Exception('Reference directory not found (${referenceDir.path}).');
  }
  stdout.writeln('Reference directory: ${referenceDir.path}');
  final brickTemplateDir = resolved.brickTemplateDir;
  stdout.writeln('Brick template directory: ${brickTemplateDir.path}');
  final brickGenData = BrickGenData.fromOptions(
    referenceAbsolutePath: referenceDir.path,
    targetAbsolutePath: brickTemplateDir.path,
    options: brickGenOptions,
  );
  stdout.writeln('Generating brick template...');

  if (brickTemplateDir.existsSync()) {
    await Shell.removeDirectory(brickTemplateDir);
  }

  if (shouldCleanWithGit) {
    await Git.cleanDirectory(referenceDir); // coverage:ignore-line
  }

  await Shell.copyDirectory(
    source: referenceDir,
    destination: brickTemplateDir,
  );

  if (shouldCleanWithGit) {
    await Git.cleanDirectory(brickTemplateDir); // coverage:ignore-line
  }

  final fsEntities = brickTemplateDir.listSync(recursive: true);
  await Future.wait<void>([
    for (final fsEntity in fsEntities)
      if (fsEntity is File) fsEntity.parametrize(brickGenData: brickGenData),
  ]);

  stdout.writeln('Brick template successfully generated.');
}
