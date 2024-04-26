import 'dart:io';

import 'package:path/path.dart' as path;

void main(List<String> args) {
  final projectDirPath = args.firstOrNull ?? Directory.current.path;
  sortPubspecDependencies(projectDirPath);
}

/// Sorts the dependencies in a pubspec.
void sortPubspecDependencies(String workingDir) {
  final pubspecPath = path.join(workingDir, 'pubspec.yaml');
  final pubspecFile = File(pubspecPath);
  if (!pubspecFile.existsSync()) {
    throw Exception('pubspec.yaml not found in <$workingDir>');
  }
  final dependenciesObjectRegex = RegExp(
    r'^dependencies:[\s\S]*?(?:\r\n|\r|\n)(?:\r\n|\r|\n)',
    multiLine: true,
  );
  final dependencyRegex = RegExp(
    r'((?:  \w+):(?:(?:\s*(?:\S+)\s*$)|(?:\s*^\s*path:\s*(?:\S+)\s*$)))',
    multiLine: true,
  );
  final pubspecContent = pubspecFile.readAsStringSync().replaceAllMapped(
    dependenciesObjectRegex,
    (match) {
      final buf = StringBuffer('dependencies:')..writeln();
      final dependenciesObject = match.group(0) ?? '';
      final dependencies = dependencyRegex.allMatches(dependenciesObject).map(
        (match) {
          final dependency = (match.group(1) ?? '').trimRight();
          return dependency;
        },
      ).toList()
        ..sort();
      for (final dependency in dependencies) {
        buf.writeln(dependency);
      }
      buf.writeln();
      return buf.toString();
    },
  );
  pubspecFile.writeAsStringSync(pubspecContent);
}
