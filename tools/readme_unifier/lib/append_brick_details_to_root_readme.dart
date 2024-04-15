import 'dart:io';

import 'package:readme_unifier/src/files.dart';

Future<void> main(List<String> args) async {
  final brickReadmeFile = Files.brickReadme;
  final brickReadmeContent = brickReadmeFile.readAsStringSync();
  final brickDetails = brickReadmeContent
      .split('---')
      .last
      .trim()
      .withIncreasedHeadlineLevels
      .withLeadingAndTrailingNewlines;
  final rootReadmeFile = Files.rootReadme;
  await rootReadmeFile.writeAsString(
    brickDetails,
    mode: FileMode.append,
  );
}

extension on String {
  static final headlinePattern = RegExp(r'^#+\s', multiLine: true);

  static String increaseHeadlineLevel(Match match) {
    return '#${match.group(0)}';
  }

  String get withIncreasedHeadlineLevels => replaceAllMapped(
        headlinePattern,
        increaseHeadlineLevel,
      );

  String get withLeadingAndTrailingNewlines => '\n$this\n';
}
