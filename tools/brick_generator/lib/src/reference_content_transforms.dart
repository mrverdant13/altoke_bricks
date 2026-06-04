import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

/// Annotation-marker transforms applied to reference file contents.
extension ReferenceContentTransforms on String {
  /// Applies the remotion transformations to the content.
  String get withResolvedRemotions {
    final blockDropPatterns = [r'\/\*drop\*\/.*', '#drop#.*', '<!--drop-->.*'];
    final blockDropPattern = blockDropPatterns
        .map((pattern) => '(?:$pattern)')
        .join('|');
    final blockDropRegex = RegExp(blockDropPattern, dotAll: true);
    final afterDropContent = replaceAll(blockDropRegex, '');
    final blockRemotionPatterns = [
      r'(?<leading>\s*)\/\*(?<dropLeading>x-)?remove-start\*\/.*?\/\*remove-end(?<dropTrailing>-x)?\*\/(?<trailing>\s*)',
      r'(?<leading>\s*)#(?<dropLeading>x-)?remove-start#.*?#remove-end(?<dropTrailing>-x)?#(?<trailing>\s*)',
      r'(?<leading>\s*)<!--(?<dropLeading>x-)?remove-start-->.*?<!--remove-end(?<dropTrailing>-x)?-->(?<trailing>\s*)',
    ];
    return blockRemotionPatterns.fold(afterDropContent, (content, pattern) {
      final regex = RegExp(pattern, dotAll: true);
      return content.replaceAllMapped(regex, (match) {
        match as RegExpMatch;
        final keepLeading = (match.namedGroup('dropLeading') ?? '').isEmpty;
        final keepTrailing = (match.namedGroup('dropTrailing') ?? '').isEmpty;
        final leading = match.namedGroup('leading') ?? '';
        final trailing = match.namedGroup('trailing') ?? '';
        return [if (keepLeading) leading, if (keepTrailing) trailing].join();
      });
    });
  }

  /// Applies the replacement transformations to the content.
  String get withResolveReplacements {
    final patternGroups = [
      (
        r'\/\*replace-start\*\/ *\n*.*?\n* *\/\*with(?: +i(?<indentation>\d+))?\*\/ *\n(?<replacement>.*?)\n *\/\*replace-end\*\/',
        r'\/\/ (?<line>.*)',
      ),
      (
        r'#replace-start# *\n*.*?\n* *#with(?: +i(?<indentation>\d+))?# *\n(?<replacement>.*?)\n *#replace-end#',
        '# (?<line>.*)',
      ),
      (
        r'<!--replace-start--> *\n*.*?\n* *<!--with(?: +i(?<indentation>\d+))?--> *\n(?<replacement>.*?)\n *<!--replace-end-->',
        '<!-- (?<line>.*)-->',
      ),
    ];
    return patternGroups.fold(this, (content, patternGroup) {
      final (replacementPattern, linePattern) = patternGroup;
      final replacementRegex = RegExp(replacementPattern, dotAll: true);
      final lineRegex = RegExp(linePattern, dotAll: true);
      return content.replaceAllMapped(replacementRegex, (match) {
        match as RegExpMatch;
        final indentation =
            int.tryParse(match.namedGroup('indentation') ?? '') ?? 0;
        final replacement = match.namedGroup('replacement') ?? '';
        final lines = LineSplitter.split(replacement);
        return lines
            .map((line) {
              final lineMatch = lineRegex.allMatches(line).single;
              final lineContent = lineMatch.namedGroup('line') ?? '';
              return ' ' * indentation + lineContent;
            })
            .join('\n');
      });
    });
  }

  /// Applies the insertion transformations to the content.
  String get withResolvedInsertions {
    final patternGroups = [
      (
        r'\/\*insert-start\*\/ *\n(?<insertion>.*?)\n *\/\*insert-end\*\/',
        r'\/\/ (?<line>.*)',
      ),
      (r'#insert-start# *\n(?<insertion>.*?)\n *#insert-end#', '# (?<line>.*)'),
      (
        r'<!--insert-start--> *\n(?<insertion>.*?)\n *<!--insert-end-->',
        '<!-- (?<line>.*)-->',
      ),
    ];
    return patternGroups.fold(this, (content, patternGroup) {
      final (insertionPattern, linePattern) = patternGroup;
      final insertionRegex = RegExp(insertionPattern, dotAll: true);
      final lineRegex = RegExp(linePattern, dotAll: true);
      return content.replaceAllMapped(insertionRegex, (match) {
        match as RegExpMatch;
        final insertion = match.namedGroup('insertion') ?? '';
        final lines = LineSplitter.split(insertion);
        return lines
            .map((line) {
              final lineMatch = lineRegex.allMatches(line).single;
              final lineContent = lineMatch.namedGroup('line') ?? '';
              return lineContent;
            })
            .join('\n');
      });
    });
  }

  /// Applies the mustache tag transformations to the content.
  String get withResolveMustacheTags {
    final patterns = [
      r'(?<leading>\s*)\/\*(?<dropLeading>x)?(?<mustacheTag>{{.*?}})(?<dropTrailing>x)?\*\/(?<trailing>\s*)',
      r'(?<leading>\s*)#(?<dropLeading>x)?(?<mustacheTag>{{.*?}})(?<dropTrailing>x)?#(?<trailing>\s*)',
      r'(?<leading>\s*)<!--(?<dropLeading>x)?(?<mustacheTag>{{.*?}})(?<dropTrailing>x)?-->(?<trailing>\s*)',
    ];
    return patterns.fold(this, (content, pattern) {
      final regex = RegExp(pattern, dotAll: true);
      return content.replaceAllMapped(regex, (match) {
        match as RegExpMatch;
        final mustacheTag = match.namedGroup('mustacheTag') ?? '';
        final keepLeading = (match.namedGroup('dropLeading') ?? '').isEmpty;
        final keepTrailing = (match.namedGroup('dropTrailing') ?? '').isEmpty;
        final leading = match.namedGroup('leading') ?? '';
        final trailing = match.namedGroup('trailing') ?? '';
        return [
          if (keepLeading) leading,
          mustacheTag,
          if (keepTrailing) trailing,
        ].join();
      });
    });
  }

  /// Applies the spacing group transformations to the content.
  String get withResolveSpacingGroups {
    const groupPatterns = [
      r'\s*\/\*w ?(?<spacingGroups>(?:\d+[v>] ?)*) ?w\*\/\s*',
      r'\s*#w ?(?<spacingGroups>(?:\d+[v>] ?)*) ?w#\s*',
      r'\s*<!--w ?(?<spacingGroups>(?:\d+[v>] ?)*) ?w-->\s*',
    ];
    const actionPattern = r'(?<actionTimes>\d+)(?<actionType>[v>]) ?';
    return groupPatterns.fold(this, (content, groupPattern) {
      final groupRegex = RegExp(groupPattern, dotAll: true);
      final actionRegex = RegExp(actionPattern, dotAll: true);
      return content.replaceAllMapped(groupRegex, (match) {
        match as RegExpMatch;
        final spacingGroups = match.namedGroup('spacingGroups') ?? '';
        return spacingGroups.replaceAllMapped(actionRegex, (actionMatch) {
          actionMatch as RegExpMatch;
          final actionTimes =
              int.tryParse(actionMatch.namedGroup('actionTimes') ?? '') ?? 0;
          final actionType = actionMatch.namedGroup('actionType') ?? '';
          return switch (actionType) {
                'v' => '\n',
                '>' => ' ',
                _ => '',
              } *
              actionTimes;
        });
      });
    });
  }

  /// Applies the partial transformations to the content.
  String withResolvedPartials({required String targetAbsolutePath}) {
    final partialPatterns = [
      r'\/\*partial v (?<partialName>.*?)\*\/(?<partialPayload>.*?)\/\*partial \^ \k<partialName>\*\/',
      r'#partial v (?<partialName>.*?)#(?<partialPayload>.*?)#partial \^ \k<partialName>#',
      r'<!--partial v (?<partialName>.*?)-->(?<partialPayload>.*?)<!--partial \^ \k<partialName>-->',
    ];
    return partialPatterns.fold(this, (content, pattern) {
      final regex = RegExp(pattern, dotAll: true);
      return content.replaceAllMapped(regex, (match) {
        match as RegExpMatch;
        final partialName = match.namedGroup('partialName') ?? '';
        final partialPayload = match.namedGroup('partialPayload') ?? '';
        File(p.join(targetAbsolutePath, '{{~ $partialName.partial }}'))
          ..createSync(recursive: true)
          ..writeAsStringSync(partialPayload);
        return '{{> $partialName.partial }}';
      });
    });
  }
}
