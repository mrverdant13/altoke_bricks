import 'dart:convert';

import 'package:altoke_monorepo_environment/altoke_monorepo_environment.dart';

void main(List<String> args) {
  final rootReadmeFile = Files.rootReadme;
  final initialRootReadmeContent = rootReadmeFile.readAsStringSync();
  final brickReadmeFile = Files.brickReadme;
  final initialBrickReadmeContent = brickReadmeFile.readAsStringSync();

  const featuresToken = '<!-- FEATURES -->';
  final featuresRegex = RegExp(
    '$featuresToken(.*?)$featuresToken',
    dotAll: true,
  );
  final headlineRegex = RegExp(r'^#+\s', multiLine: true);
  final brickFeatures =
      featuresRegex.firstMatch(initialBrickReadmeContent)?.group(1)?.trim();
  if (brickFeatures == null) {
    throw StateError('Features not found in brick readme');
  }

  const bricksLinksToken = '<!-- BRICK LINKS -->';
  final bricksLinksRegex = RegExp(
    '$bricksLinksToken(.*?)$bricksLinksToken',
    dotAll: true,
  );
  final rawRootBricksLinks =
      bricksLinksRegex.firstMatch(initialRootReadmeContent)?.group(1)?.trim();
  if (rawRootBricksLinks == null) {
    throw StateError('Bricks links not found in root readme');
  }
  final rawBricksLinks =
      bricksLinksRegex.firstMatch(initialBrickReadmeContent)?.group(1)?.trim();
  if (rawBricksLinks == null) {
    throw StateError('Bricks links not found in brick readme');
  }
  final rootBricksLinks =
      LineSplitter.split('$rawRootBricksLinks\n$rawBricksLinks')
          .map((line) => line.trim())
          .where((line) => line.isNotEmpty)
          .toSet()
          .join('\n')
          .trim();

  final resolvedRootReadme = initialRootReadmeContent.replaceAllMapped(
    featuresRegex,
    (match) {
      final features = match.group(1)?.trim();
      final buf = StringBuffer()..writeln(featuresToken);
      if (features != null) {
        buf
          ..writeln(features)
          ..writeln();
      }
      buf
        ..writeln(
          brickFeatures.replaceAllMapped(
            headlineRegex,
            (match) {
              final buf = StringBuffer();
              final current = match.group(0) ?? '';
              buf
                ..write('#')
                ..write(current);
              if (current.trim().length == 2) buf.write('🧱 ');
              return buf.toString();
            },
          ),
        )
        ..writeln(featuresToken);
      return buf.toString().trim();
    },
  ).replaceAll(
    bricksLinksRegex,
    '$bricksLinksToken\n$rootBricksLinks\n$bricksLinksToken',
  );
  rootReadmeFile.writeAsStringSync(resolvedRootReadme);
}
