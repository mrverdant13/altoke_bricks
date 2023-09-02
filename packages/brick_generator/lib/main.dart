import 'dart:io';

import 'package:brick_generator/src/placeholders.dart';
import 'package:brick_generator/src/reference_file.dart';
import 'package:brick_generator/src/shell.dart';
import 'package:path/path.dart' as path;

/// Path to the reference app.
///
/// This path is relative to the root of the Melos workspace.
final referenceAppPath = path.joinAll([
  'packages',
  'reference_app',
]);

/// Reference app directory.
final referenceAppDir = Directory(referenceAppPath);

/// Path to the brick template.
///
/// This path is relative to the root of the Melos workspace.
final brickTemplatePath = path.joinAll([
  'packages',
  'brick',
  '__brick__',
  Placeholder.appPackageName.parameter,
]);

/// Brick template directory.
final brickTemplateDir = Directory(brickTemplatePath);

Future<void> main(List<String> args) async {
  final rootPath = Platform.environment['MELOS_ROOT_PATH'];
  if (rootPath == null) {
    throw Exception(
      'MELOS_ROOT_PATH environment variable not found. '
      'Please run this script from a Melos workspace.',
    );
  }
  Directory.current = Directory(rootPath);

  // Remove target directory
  if (brickTemplateDir.existsSync()) {
    await Shell.removeDirectory(brickTemplateDir);
  }

  // Copy reference project
  await Shell.copyDirectory(
    source: referenceAppDir,
    destination: brickTemplateDir,
  );

  // Parametrize template
  final fsEntities = brickTemplateDir.listSync(recursive: true);
  await Future.wait<void>([
    for (final fsEntity in fsEntities)
      if (fsEntity is File) fsEntity.parametrize(),
  ]);
}
