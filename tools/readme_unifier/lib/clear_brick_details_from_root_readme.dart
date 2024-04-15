import 'package:readme_unifier/src/files.dart';

Future<void> main(List<String> args) async {
  final rootReadmeFile = Files.rootReadme;
  final rootReadmeContent = rootReadmeFile.readAsStringSync();
  await rootReadmeFile.writeAsString(
    rootReadmeContent.withEmptyBricksSection,
  );
}

extension on String {
  static final brickSectionPattern = RegExp('## Bricks(.*)', dotAll: true);

  static const brickReplacement = '## Bricks\n';

  String get withEmptyBricksSection => replaceAll(
        brickSectionPattern,
        brickReplacement,
      );
}
