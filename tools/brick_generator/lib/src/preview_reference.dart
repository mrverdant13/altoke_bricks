import 'dart:convert';
import 'dart:io';

import 'package:brick_generator/src/models/brick_gen_data.dart';
import 'package:brick_generator/src/models/brick_gen_options.dart';
import 'package:brick_generator/src/preview_options.dart';
import 'package:brick_generator/src/resolve_reference_content.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as p;

/// Transforms a single reference file and writes the result via [write]
/// (stdout by default).
Future<void> previewReference(
  PreviewOptions options, {
  void Function(String content)? write,
}) async {
  final emit = write ?? stdout.write;
  final file = File(options.filePath);
  if (!file.existsSync()) {
    throw ArgumentError('File not found: ${options.filePath}');
  }

  final scopeDir = BrickScopePaths.scopeDirectory(
    rootPath: options.rootPath,
    brickScope: options.brickScope,
  );
  final referenceDir = Directory(p.join(scopeDir, 'reference'));
  if (!referenceDir.existsSync()) {
    throw ArgumentError('Reference directory not found: ${referenceDir.path}');
  }

  final referencePath = p.normalize(file.absolute.path);
  if (!p.isWithin(referenceDir.path, referencePath)) {
    throw ArgumentError(
      'File must be under the reference directory (${referenceDir.path}).',
    );
  }

  final brickGenDataFile = File(p.join(scopeDir, 'brick-gen.json'));
  if (!brickGenDataFile.existsSync()) {
    throw ArgumentError('brick-gen.json not found in $scopeDir');
  }

  final brickGenOptions = BrickGenOptions.fromJson(
    jsonDecode(await brickGenDataFile.readAsString()) as Map<String, dynamic>,
  );

  final tempTargetDir = await Directory.systemTemp.createTemp(
    'brick_generator_preview_',
  );
  try {
    final referenceRelativePath = p.relative(referencePath, from: referenceDir.path);
    final simulatedTargetPath = p.join(
      tempTargetDir.path,
      referenceRelativePath,
    );
    final brickGenData = BrickGenData.fromOptions(
      referenceAbsolutePath: referenceDir.path,
      targetAbsolutePath: tempTargetDir.path,
      options: brickGenOptions,
    );

    final resolvedTargetPath = brickGenData.applyReplacementsToTargetRelativeDescendant(
      simulatedTargetPath,
    );
    final targetRelativePath = p.relative(
      resolvedTargetPath,
      from: tempTargetDir.path,
    );

    final annotatedContent = resolveReferenceContent(
      content: await file.readAsString(),
      targetRelativePath: targetRelativePath,
      brickGenData: brickGenData,
    );

    final partials = _loadPartials(tempTargetDir);
    final rendered = annotatedContent.render(options.vars, partials);
    emit(rendered);
  } finally {
    await tempTargetDir.delete(recursive: true);
  }
}

Map<String, List<int>> _loadPartials(Directory targetDir) {
  if (!targetDir.existsSync()) return {};
  final partials = <String, List<int>>{};
  for (final entity in targetDir.listSync(recursive: true)) {
    if (entity is! File) continue;
    final name = p.basename(entity.path);
    if (!name.startsWith('{{~ ') || !name.endsWith(' }}')) continue;
    partials[name] = utf8.encode(entity.readAsStringSync());
  }
  return partials;
}
