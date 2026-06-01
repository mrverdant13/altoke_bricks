import 'dart:convert';
import 'dart:io';

import 'package:brick_generator/src/models/brick_gen_data.dart';
import 'package:brick_generator/src/models/brick_gen_options.dart';
import 'package:brick_generator/src/reference_file.dart';
import 'package:monorepo_elements/monorepo_elements.dart';
import 'package:shell/git.dart';
import 'package:shell/shell.dart';

/// Generates a brick template from the current scope's reference project.
Future<void> generateBrick() async {
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
  final referenceDir = scopeDir.descendantDir('reference');
  if (!referenceDir.existsSync()) {
    throw Exception('Reference directory not found (${referenceDir.path}).');
  }
  stdout.writeln('Reference directory: ${referenceDir.path}');
  final brickTemplateDir = Dirs.brickTemplate;
  stdout.writeln('Brick template directory: ${brickTemplateDir.path}');
  final brickGenData = BrickGenData.fromOptions(
    referenceAbsolutePath: referenceDir.path,
    targetAbsolutePath: brickTemplateDir.path,
    options: brickGenOptions,
  );
  stdout.writeln('Generating brick template...');

  if (Dirs.brickTemplate.existsSync()) {
    await Shell.removeDirectory(Dirs.brickTemplate);
  }

  await Git.cleanDirectory(referenceDir);

  await Shell.copyDirectory(
    source: referenceDir,
    destination: brickTemplateDir,
  );

  await Git.cleanDirectory(brickTemplateDir);

  final fsEntities = brickTemplateDir.listSync(recursive: true);
  await Future.wait<void>([
    for (final fsEntity in fsEntities)
      if (fsEntity is File) fsEntity.parametrize(brickGenData: brickGenData),
  ]);

  stdout.writeln('Brick template successfully generated.');
}
