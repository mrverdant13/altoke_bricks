import 'package:readmes_resolver/src/files.dart';

Future<void> main(List<String> args) async {
  final rootReadmeFile = Files.rootReadme;
  final rootReadmeContent = rootReadmeFile.readAsStringSync();

  const featuresToken = '<!-- FEATURES -->';
  final featuresRegex = RegExp(
    '$featuresToken(.*?)$featuresToken',
    dotAll: true,
  );
  final rootFeatures =
      featuresRegex.firstMatch(rootReadmeContent)?.group(1)?.trim();
  if (rootFeatures == null) {
    throw StateError('Features not found in brick readme');
  }

  const bricksLinksToken = '<!-- BRICK LINKS -->';
  final bricksLinksRegex = RegExp(
    '$bricksLinksToken(.*?)$bricksLinksToken',
    dotAll: true,
  );
  final rootBricksLinks =
      bricksLinksRegex.firstMatch(rootReadmeContent)?.group(1)?.trim();
  if (rootBricksLinks == null) {
    throw StateError('Bricks links not found in root readme');
  }

  final clearedRootReadme = rootReadmeContent
      .replaceAll(
        featuresRegex,
        '$featuresToken\n\n$featuresToken',
      )
      .replaceAll(
        bricksLinksRegex,
        '$bricksLinksToken\n\n$bricksLinksToken',
      );
  rootReadmeFile.writeAsStringSync(clearedRootReadme);
}
