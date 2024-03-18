import 'dart:convert';
import 'dart:io';

import 'package:brick_generator/src/brick_gen_data.dart';
import 'package:brick_generator/src/brick_gen_options.dart';
import 'package:brick_generator/src/reference_file.dart';
import 'package:brick_generator/src/shell.dart';
import 'package:path/path.dart' as path;

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    throw Exception(
      'Reference path not found. '
      'Provide it as the first argument.',
    );
  }
  final referenceDir = Directory(args.first);
  if (!referenceDir.existsSync()) {
    throw Exception(
      'Reference directory not found.',
    );
  }
  final brickGenDataFile = File(
    path.join(
      referenceDir.path,
      'brick-gen.json',
    ),
  );
  if (!brickGenDataFile.existsSync()) {
    throw Exception(
      'Invalid reference directory. '
      'Brick generation data file not found. ',
    );
  }
  final rawBrickGenData = await brickGenDataFile.readAsString();
  final brickGenDataJson = jsonDecode(rawBrickGenData) as Map<String, dynamic>;
  final brickGenOptions = BrickGenOptions.fromJson(brickGenDataJson);
  final brickTemplateDir = Directory(
    path.normalize(
      path.joinAll([
        referenceDir.path,
        brickGenOptions.targetRelativePath,
      ]),
    ),
  );
  final brickGenData = BrickGenData.fromOptions(
    referenceAbsolutePath: referenceDir.path,
    targetAbsolutePath: brickTemplateDir.path,
    options: brickGenOptions,
  );
  stdout
    ..writeln('Generating brick template...')
    ..writeln('Reference path: ${brickGenData.referenceAbsolutePath}')
    ..writeln('Brick path: ${brickGenData.targetAbsolutePath}');

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
