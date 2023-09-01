import 'dart:io';

import 'package:brick_generator/src/placeholders.dart';
import 'package:meta/meta.dart';

abstract class AltokeRegexp {
  @visibleForTesting
  static final spacingGroupsRegexp = RegExp(
    r'(\s+)?[\/#]\*w ((?:\d+[v>]\s*)+) w\*[\/#](\s+)?',
    dotAll: true,
  );

  @visibleForTesting
  static final spacingGroupDataRegexp = RegExp(
    r'(\d+)([v>])',
    dotAll: true,
  );
}

@visibleForTesting
abstract class NumSignBasedRegexp {
  static final variable = RegExp(
    r'(\s+)?#{{(.*?)}}#(\s+)?',
    dotAll: true,
  );
}

@visibleForTesting
abstract class SlashBasedRegexp {
  static final variable = RegExp(
    r'(\s+)?\/\*{{(.*?)}}\*\/(\s+)?',
    dotAll: true,
  );
}

extension ReferenceFile on File {
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

  @visibleForTesting
  bool get isGitIgnored {
    final result = Process.runSync(
      'git',
      ['check-ignore', this.path, '--quiet'],
    );
    return result.exitCode == 0;
  }

  @visibleForTesting
  Future<void> resolveContents() async {
    var resolvedContents = (await readAsString())
        .replaceAllMapped(
          NumSignBasedRegexp.variable,
          transformaVariableMatch,
        )
        .replaceAllMapped(
          SlashBasedRegexp.variable,
          transformaVariableMatch,
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

@visibleForTesting
String transformaVariableMatch(Match match) {
  final variable = match.group(2);
  return '{{$variable}}';
}

@visibleForTesting
String transformWhitespaceActionsMatch(Match match) {
  final buf = StringBuffer();
  final candidates =
      AltokeRegexp.spacingGroupDataRegexp.allMatches(match.group(2) ?? '');
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
