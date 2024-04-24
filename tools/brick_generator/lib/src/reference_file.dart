import 'dart:convert';
import 'dart:io';

import 'package:brick_generator/src/brick_gen_data.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

/// Regexp patterns to parametrize the template.
@visibleForTesting
abstract class AltokeRegexp {
  /// Regexp to identify blocks to be removed from the contents of a file.
  @visibleForTesting
  static final remotionRegexp = RegExp(
    r'(((\/)|(#)|(<!--))\*drop\*((\/)|(#)|(-->)).*)|((\s+)?((\/)|(#)|(<!--))\*remove-start\*((\/)|(#)|(-->))([\s\S]*?)((\/)|(#)|(<!--))\*remove-end\*((\/)|(#)|(-->))(\s+)?)',
    dotAll: true,
  );

  /// Regexp to identify a conditional file to be resolved within its path.
  static final conditionalFileRegexp = RegExp(
    r'_cf(n?)___([^;\s]*)___([^;\s]*)',
    dotAll: true,
  );

  /// Regexp to identify a conditional directory to be resolved within its path.
  static final conditionalDirRegexp = RegExp(
    r'_cd(n?)___([^;\s\\\/]*)___([^;\s\\\/]*)',
    dotAll: true,
  );

  /// Regexp to identify variables to be resolved within the contents of a file.
  @visibleForTesting
  static final variableRegexp = RegExp(
    r'(\s+)?((#)|(\/\*)|(<!--)){{(.*?)}}((#)|(\*\/)|(-->))(\s+)?',
    dotAll: true,
  );

  /// Regexp to identify whitespace actions to be resolved within the contents
  /// of a file.
  @visibleForTesting
  static final spacingGroupsRegexp = RegExp(
    r'(\s+)?((\/)|(#)|(<!--))\*w ((?:\d+[v>]\s*)+) w\*((\/)|(#)|(-->))(\s+)?',
    dotAll: true,
  );

  /// Regexp to identify a single whitespace action to be resolved within the
  /// contents of a file.
  @visibleForTesting
  static final spacingGroupDataRegexp = RegExp(
    r'(\d+)([v>])',
    dotAll: true,
  );

  /// Regexp to identify a block to be replaced within the contents of a file.
  @visibleForTesting
  static final replacementRegexp = RegExp(
    r'((?:\/\*)|(?:#\*)|(?:<!--))replace-start(?:(?:\*\/)|(?:\*#)|(?:-->))(?:[\s\S]*?)(?:(?:\/\*)|(?:#\*)|(?:<!--))with\s*(?:i(\d+))?(?:(?:\*\/)|(?:\*#)|(?:-->))\s*([\s\S]*?)\s*(?:(?:\/\*)|(?:#\*)|(?:<!--))replace-end(?:(?:\*\/)|(?:\*#)|(?:-->))',
    dotAll: true,
  );
}

/// Extension methods for a reference [File] to be parametrized.
extension ReferenceFile on File {
  /// Parametrizes the reference file.
  Future<void> parametrize({
    required BrickGenData brickGenData,
  }) async {
    try {
      if (isGitIgnored) {
        await delete(recursive: true);
        return;
      }
      final resolvedPath = await resolvePath(brickGenData: brickGenData);
      final resultingFile = await () async {
        if (p.equals(resolvedPath, path)) return this;
        final dir = Directory(p.dirname(resolvedPath));
        if (!dir.existsSync()) await dir.create(recursive: true);
        return rename(resolvedPath);
      }();
      await resultingFile.resolveContents(brickGenData: brickGenData);
    } catch (e) {
      stderr.writeln(e);
    }
  }

  /// Checks if the reference file is git ignored.
  @visibleForTesting
  bool get isGitIgnored {
    final result = Process.runSync(
      'git',
      ['check-ignore', path, '--quiet'],
    );
    return result.exitCode == 0;
  }

  /// Resolves the parametrized contents of the reference [File].
  @visibleForTesting
  Future<void> resolveContents({
    required BrickGenData brickGenData,
  }) async {
    final resolvedContents = brickGenData.replacements
        .apply(await readAsString())
        .replaceAll(
          AltokeRegexp.remotionRegexp,
          '',
        )
        .replaceAllMapped(
          AltokeRegexp.replacementRegexp,
          transformReplacementMatchForFileContents,
        )
        .replaceAllMapped(
          AltokeRegexp.conditionalFileRegexp,
          transformConditionalFileMatchForFileContents,
        )
        .replaceAllMapped(
          AltokeRegexp.conditionalDirRegexp,
          transformConditionalDirMatchForFileContents,
        )
        .replaceAllMapped(
          AltokeRegexp.variableRegexp,
          transformVariableMatchForFileContents,
        )
        .replaceAllMapped(
          AltokeRegexp.spacingGroupsRegexp,
          transformWhitespaceActionsMatchForFileContents,
        );
    await writeAsString(resolvedContents);
  }

  /// Resolves the parametrized path of the reference [File].
  @visibleForTesting
  Future<String> resolvePath({
    required BrickGenData brickGenData,
  }) async {
    return brickGenData
        .applyReplacementsToTargetRelativeDescendant(path)
        .replaceAllMapped(
          AltokeRegexp.conditionalFileRegexp,
          transformConditionalFileMatchForFilePath,
        )
        .replaceAllMapped(
          AltokeRegexp.conditionalDirRegexp,
          transformConditionalDirMatchForFilePath,
        );
  }
}

/// Transforms a replacement match into the actual replacement block, in the
/// contents of a file.
@visibleForTesting
String transformReplacementMatchForFileContents(Match match) {
  final type = match.group(1);
  final indentation = int.tryParse(match.group(2) ?? '') ?? 0;
  final rawLines = LineSplitter.split((match.group(3) ?? '').trim());

  String computeSlashBasedReplacement() {
    final buf = StringBuffer();
    final lines = rawLines.map(
      (line) => line.replaceFirst(
        RegExp(r'\s*\/\/ '),
        ' ' * indentation,
      ),
    );
    for (final line in lines) {
      buf.writeln(line);
    }
    return buf.toString().trim();
  }

  String computeHashBasedReplacement() {
    final buf = StringBuffer();
    final lines = rawLines.map(
      (line) => line.replaceFirst(
        RegExp(r'\s*#* '),
        ' ' * indentation,
      ),
    );
    for (final line in lines) {
      buf.writeln(line);
    }
    return buf.toString().trim();
  }

  String computeHtmlBasedReplacement() {
    final buf = StringBuffer();
    final lines = rawLines.map(
      (line) => line.replaceFirst(
        RegExp(r'\s*<!-- '),
        ' ' * indentation,
      ),
    );
    for (final line in lines) {
      buf.writeln(line.substring(0, line.length - 3).trim());
    }
    return buf.toString().trim();
  }

  switch (type) {
    case '/*':
      return computeSlashBasedReplacement();
    case '#*':
      return computeHashBasedReplacement();
    case '<!--':
      return computeHtmlBasedReplacement();
    case _:
      return '';
  }
}

/// Transforms a conditional file match into a parametrized conditional
/// filename, in the path of a file.
@visibleForTesting
String transformConditionalFileMatchForFilePath(Match match) {
  final logicCharacter = switch (match.group(1)) {
    'n' => '^',
    _ => '#',
  };
  final variable = match.group(2);
  final pathSegment = match.group(3);
  return '{{$logicCharacter$variable}}$pathSegment{{${p.separator}$variable}}';
}

/// Transforms a conditional file match into an filename, in the contents of a
/// file.
@visibleForTesting
String transformConditionalFileMatchForFileContents(Match match) {
  final pathSegment = match.group(3);
  return '$pathSegment';
}

/// Transforms a conditional directory match into a parametrized conditional
/// directory path segment, in the path of a file.
@visibleForTesting
String transformConditionalDirMatchForFilePath(Match match) {
  final logicCharacter = switch (match.group(1)) {
    'n' => '^',
    _ => '#',
  };
  final variable = match.group(2);
  final pathSegment = match.group(3);
  return '{{$logicCharacter$variable}}$pathSegment{{${p.separator}$variable}}';
}

/// Transforms a conditional directory match into an directory path segment, in
/// the contents of a file.
@visibleForTesting
String transformConditionalDirMatchForFileContents(Match match) {
  final pathSegment = match.group(3);
  return '$pathSegment';
}

/// Transforms a variable match into an actual mustache variable, in the
/// contents of a file.
@visibleForTesting
String transformVariableMatchForFileContents(Match match) {
  final variable = match.group(6);
  return '{{$variable}}';
}

/// Transforms a whitespace actions match into an actual set of spacing actions,
/// such as new lines and spaces, in the contents of a file.
@visibleForTesting
String transformWhitespaceActionsMatchForFileContents(Match match) {
  final buf = StringBuffer();
  final candidates =
      AltokeRegexp.spacingGroupDataRegexp.allMatches(match.group(6) ?? '');
  for (final candidate in candidates) {
    final count = int.tryParse(candidate.group(1) ?? '') ?? 0;
    final action = () {
      final actionChar = candidate.group(2);
      switch (actionChar) {
        case 'v':
          return '\n';
        case '>':
          return ' ';
        default:
          return '';
      }
    }();
    buf.write(action * count);
  }
  return buf.toString();
}
