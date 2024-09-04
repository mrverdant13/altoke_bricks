import 'dart:collection';
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
  final pubspecRawContent = pubspecFile.readAsStringSync();
  final dependenciesObjectRegex = RegExp(
    r'^dependencies:[\s\S]*?(?:\r\n|\r|\n)(?:\r\n|\r|\n)',
    multiLine: true,
  );
  final dependencyRegex = RegExp(
    r'(?<dep_obj>^  (?<dep_name>\w+):(?:(?: (?:\^)?[^\n]+)|(?:\n    path: [^\n]+)|(?:\n    hosted: [^\n]+\n    version: [^\n]+)))',
    multiLine: true,
  );
  final pubspecContent = pubspecRawContent.replaceAllMapped(
    dependenciesObjectRegex,
    (match) {
      final buf = StringBuffer('dependencies:')..writeln();
      final deps = match.group(0) ?? '';
      final dep = dependencyRegex.allMatches(deps);
      final depsMap = SplayTreeMap<String, String>();
      for (final match in dep) {
        final depName = match.namedGroup('dep_name') ?? '';
        final depObj = match.namedGroup('dep_obj') ?? '';
        depsMap[depName] = depObj;
      }
      depsMap.values.forEach(buf.writeln);
      return buf.toString();
    },
  );
  pubspecFile.writeAsStringSync(pubspecContent);
}
