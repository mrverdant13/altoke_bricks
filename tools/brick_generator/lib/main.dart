import 'dart:convert';
import 'dart:io';

import 'package:altoke_monorepo_environment/altoke_monorepo_environment.dart';
import 'package:brick_generator/src/brick_gen_data.dart';
import 'package:brick_generator/src/brick_gen_options.dart';
import 'package:brick_generator/src/reference_file.dart';
import 'package:brick_generator/src/shell.dart';
import 'package:path/path.dart' as path;

Future<void> main(List<String> args) async {
  final brickGenDataFile = Files.brickGenData;
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
  final scopeDir = Dirs.scope;
  final referenceDir = Directory(
    path.joinAll([
      scopeDir.path,
      'reference',
    ]),
  );
  if (!referenceDir.existsSync()) {
    throw Exception(
      'Reference directory not found (${referenceDir.path}).',
    );
  }
  stdout.writeln('Reference directory: ${referenceDir.path}');
  final brickTemplateDir = Directory(
    path.normalize(
      path.joinAll([
        scopeDir.path,
        brickGenOptions.targetRelativePath,
      ]),
    ),
  );
  stdout.writeln('Brick template directory: ${brickTemplateDir.path}');
  final brickGenData = BrickGenData.fromOptions(
    referenceAbsolutePath: referenceDir.path,
    targetAbsolutePath: brickTemplateDir.path,
    options: brickGenOptions,
  );
  stdout.writeln('Generating brick template...');

  // Remove target directory.
  if (brickTemplateDir.existsSync()) {
    await Shell.removeDirectory(brickTemplateDir);
  }

  // Remove untracked files from reference directory.
  await Shell.gitCleanDirectory(referenceDir);

  // Copy reference project.
  await Shell.copyDirectory(
    source: referenceDir,
    destination: brickTemplateDir,
  );

  // Remove untracked files from brick directory.
  await Shell.gitCleanDirectory(brickTemplateDir);

  // Parametrize template
  final fsEntities = brickTemplateDir.listSync(recursive: true);
  await Future.wait<void>([
    for (final fsEntity in fsEntities)
      if (fsEntity is File)
        fsEntity.parametrize(
          brickGenData: brickGenData,
        ),
  ]);

  stdout.writeln('Brick template successfully generated.');
}
