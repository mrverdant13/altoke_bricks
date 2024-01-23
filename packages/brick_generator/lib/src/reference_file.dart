import 'dart:io';

import 'package:brick_generator/src/placeholders.dart';
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

  /// Regexp to identify a conditional file to be resolved within its path.
  static final conditionalFileRegexp = RegExp(
    '_conditional_file___([a-zA-Z0-9_-]+)___([a-zA-Z0-9_.-]+)',
    dotAll: true,
  );

  /// Regexp to identify a conditional directory to be resolved within its path.
  static final conditionalDirRegexp = RegExp(
    '_conditional_dir___([a-zA-Z0-9_-]+)___([a-zA-Z0-9_.-]+)',
    dotAll: true,
  );
}

/// Extension methods for a reference [File] to be parametrized.
extension ReferenceFile on File {
  /// Parametrizes the reference file.
  Future<void> parametrize() async {
    try {
      if (isGitIgnored) {
        await delete(recursive: true);
        return;
      }
      final resolvedPath = await resolvePath();
      final resultingFile = await () async {
        if (p.equals(resolvedPath, path)) return this;
        final dir = Directory(p.dirname(resolvedPath));
        if (!dir.existsSync()) await dir.create(recursive: true);
        return rename(resolvedPath);
      }();
      await resultingFile.resolveContents();
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
  Future<void> resolveContents() async {
    var resolvedContents = (await readAsString())
        .replaceAll(
          AltokeRegexp.remotionRegexp,
          '',
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
    for (final placeholder in Placeholder.values) {
      resolvedContents = resolvedContents.replaceAll(
        placeholder.literal,
        placeholder.parameter,
      );
    }
    await writeAsString(resolvedContents);
  }

  /// Resolves the parametrized path of the reference [File].
  @visibleForTesting
  Future<String> resolvePath() async {
    return path
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

/// Transforms a conditional file match into a parametrized conditional
/// filename, in the path of a file.
@visibleForTesting
String transformConditionalFileMatchForFilePath(Match match) {
  final variable = match.group(1);
  final pathSegment = match.group(2);
  return '{{#$variable}}$pathSegment{{${p.separator}$variable}}';
}

/// Transforms a conditional file match into an filename, in the contents of a
/// file.
@visibleForTesting
String transformConditionalFileMatchForFileContents(Match match) {
  final pathSegment = match.group(2);
  return '$pathSegment';
}

/// Transforms a conditional directory match into a parametrized conditional
/// directory path segment, in the path of a file.
@visibleForTesting
String transformConditionalDirMatchForFilePath(Match match) {
  final variable = match.group(1);
  final pathSegment = match.group(2);
  return '{{#$variable}}$pathSegment{{${p.separator}$variable}}';
}

/// Transforms a conditional directory match into an directory path segment, in
/// the contents of a file.
@visibleForTesting
String transformConditionalDirMatchForFileContents(Match match) {
  final pathSegment = match.group(2);
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
