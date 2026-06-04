import 'dart:io';

import 'package:path/path.dart' as p;

/// Temporary monorepo layout for commands that rely on Melos env vars.
class MelosScopeFixture {
  MelosScopeFixture._({
    required this.root,
    required this.scope,
    required this.reference,
    required this.template,
  });

  /// Monorepo root directory.
  final Directory root;

  /// Brick scope directory.
  final Directory scope;

  /// Reference directory inside the scope.
  final Directory reference;

  /// Brick template directory (`brick/__brick__`).
  final Directory template;

  /// Creates a disposable fixture under the system temp directory.
  static Future<MelosScopeFixture> create() async {
    final root = await Directory.systemTemp.createTemp('brick_gen_monorepo_');
    Directory(p.join(root.path, 'bricks')).createSync();
    File(p.join(root.path, 'pubspec.yaml')).writeAsStringSync('name: test\n');

    final scope = Directory(p.join(root.path, 'bricks', 'test_scope'))
      ..createSync(recursive: true);
    final reference = Directory(p.join(scope.path, 'reference'))
      ..createSync(recursive: true);
    final template = Directory(p.join(scope.path, 'brick', '__brick__'))
      ..createSync(recursive: true);

    File(p.join(scope.path, 'brick-gen.json')).writeAsStringSync('''
{
  "replacements": [],
  "lineDeletions": []
}
''');

    return MelosScopeFixture._(
      root: root,
      scope: scope,
      reference: reference,
      template: template,
    );
  }

  Future<void> dispose() async {
    if (root.existsSync()) await root.delete(recursive: true);
  }
}
