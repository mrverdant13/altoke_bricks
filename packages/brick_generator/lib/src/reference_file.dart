import 'dart:io';

import 'package:brick_generator/src/placeholders.dart';
import 'package:meta/meta.dart';

/// Regexp patterns to parametrize the template.
@visibleForTesting
abstract class AltokeRegexp {
  /// Regexp to identify blocks to be removed.
  @visibleForTesting
  static final remotionRegexp = RegExp(
    r'(((\/)|(#)|(<!--))\*drop\*((\/)|(#)|(-->)).*)|((\s+)?((\/)|(#)|(<!--))\*remove-start\*((\/)|(#)|(-->))([\s\S]*?)((\/)|(#)|(<!--))\*remove-end\*((\/)|(#)|(-->))(\s+)?)',
    dotAll: true,
  );

  /// Regexp to identify variables to be resolved.
  @visibleForTesting
  static final variableRegexp = RegExp(
    r'(\s+)?((#)|(\/\*)|(<!--)){{(.*?)}}((#)|(\*\/)|(-->))(\s+)?',
    dotAll: true,
  );

  /// Regexp to identify whitespace actions to be resolved.
  @visibleForTesting
  static final spacingGroupsRegexp = RegExp(
    r'(\s+)?((\/)|(#)|(<!--))\*w ((?:\d+[v>]\s*)+) w\*((\/)|(#)|(-->))(\s+)?',
    dotAll: true,
  );

  /// Regexp to identify a single whitespace action to be resolved.
  @visibleForTesting
  static final spacingGroupDataRegexp = RegExp(
    r'(\d+)([v>])',
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
      await resolveContents();
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
          AltokeRegexp.variableRegexp,
          transformVariableMatch,
        )
        .replaceAllMapped(
          AltokeRegexp.spacingGroupsRegexp,
          transformWhitespaceActionsMatch,
        );
    for (final placeholder in Placeholder.values) {
      resolvedContents = resolvedContents.replaceAll(
        placeholder.literal,
        placeholder.parameter,
      );
    }
    await writeAsString(resolvedContents);
  }
}

/// Transforms a variable match into an actual mustache variable.
@visibleForTesting
String transformVariableMatch(Match match) {
  final variable = match.group(6);
  return '{{$variable}}';
}

/// Transforms a whitespace actions match into an actual set of spacing actions,
/// such as new lines and spaces.
@visibleForTesting
String transformWhitespaceActionsMatch(Match match) {
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
