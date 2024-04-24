import 'package:altoke_monorepo_environment/altoke_monorepo_environment.dart';
import 'package:checked_yaml/checked_yaml.dart';
import 'package:mason/mason.dart';

void main(List<String> args) {
  final rootReadmeFile = Files.rootReadme;
  final initialRootReadmeContent = rootReadmeFile.readAsStringSync();
  final brickReadmeFile = Files.brickReadme;
  final initialBrickReadmeContent = brickReadmeFile.readAsStringSync();
  final brickManifestFile = Files.brickManifest;
  final brickManifestContent = brickManifestFile.readAsStringSync();

  const bannersHeaderToken = '<!-- BANNERS HEADER -->';
  final bannersHeaderRegex = RegExp(
    '$bannersHeaderToken(.*?)$bannersHeaderToken',
    dotAll: true,
  );
  final rootBannersHeader =
      bannersHeaderRegex.firstMatch(initialRootReadmeContent)?.group(1)?.trim();
  if (rootBannersHeader == null) {
    throw StateError('Banners header not found in root readme');
  }

  const variablesToken = '<!-- VARIABLES -->';
  final variablesRegex = RegExp(
    '$variablesToken(.*?)$variablesToken',
    dotAll: true,
  );
  final varsBuf = StringBuffer();
  final brickManifest = checkedYamlDecode(
    brickManifestContent,
    (m) => BrickYaml.fromJson(m!),
  );
  final vars = brickManifest.vars;
  if (vars.isNotEmpty) {
    varsBuf
      ..writeln('### Variables')
      ..writeln()
      ..writeln('| Variable | Description | Default | Type |')
      ..writeln('| -------- | ----------- | ------- | ---- |');
    for (final MapEntry(key: varName, value: varData) in vars.entries) {
      //
      varsBuf.writeln(
        '| `$varName` '
        '| ${varData.description} '
        '| ${varData.defaultValue ?? '_None_'} '
        '| ${switch (varData.type) {
          BrickVariableType.array => 'Array',
          BrickVariableType.boolean => 'Boolean',
          BrickVariableType.enumeration => 'Enumeration',
          BrickVariableType.list => 'List',
          BrickVariableType.number => 'Number',
          BrickVariableType.string => 'String',
        }} '
        '|',
      );
    }
  }

  final resolvedBrickReadme = initialBrickReadmeContent.replaceAllMapped(
    bannersHeaderRegex,
    (match) {
      final buf = StringBuffer()
        ..writeln(bannersHeaderToken)
        ..writeln(rootBannersHeader)
        ..writeln(bannersHeaderToken);
      return buf.toString().trim();
    },
  ).replaceAllMapped(
    variablesRegex,
    (match) {
      final buf = StringBuffer()
        ..writeln(variablesToken)
        ..writeln(varsBuf.toString().trim())
        ..writeln(variablesToken);
      return buf.toString().trim();
    },
  );
  brickReadmeFile.writeAsStringSync(resolvedBrickReadme);
}
