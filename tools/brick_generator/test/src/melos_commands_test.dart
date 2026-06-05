import 'dart:io';

import 'package:brick_generator/main.dart' as cli;
import 'package:brick_generator/src/generate_brick.dart'
    show generateBrick, resolveBrickScope;
import 'package:brick_generator/src/validate_references.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'melos_scope_fixture.dart';

void main() {
  group('Melos-backed commands', () {
    late MelosScopeFixture fixture;
    late int originalExitCode;
    late String scopePath;

    setUpAll(() async {
      fixture = await MelosScopeFixture.create();
      scopePath = fixture.scope.path;
    });

    setUp(() {
      originalExitCode = exitCode;
    });

    tearDown(() async {
      exitCode = originalExitCode;
      if (!fixture.reference.existsSync()) {
        fixture.reference.createSync(recursive: true);
      }
      await File(p.join(fixture.scope.path, 'brick-gen.json')).writeAsString('''
{
  "replacements": [],
  "lineDeletions": []
}
''');
      if (fixture.template.existsSync()) {
        fixture.template.deleteSync(recursive: true);
      }
      fixture.template.createSync(recursive: true);
    });

    tearDownAll(() async {
      await fixture.dispose();
    });

    group('validateReferences', () {
      test('reports success when annotations are valid', () async {
        await File(p.join(fixture.reference.path, 'valid.dart')).writeAsString(
          '/*remove-start*/\n/*remove-end*/\n',
        );

        await validateReferences(scopePath: scopePath);

        expect(exitCode, 0);
      });

      test('sets a non-zero exit code when issues are found', () async {
        await File(
          p.join(fixture.reference.path, 'invalid.dart'),
        ).writeAsString(
          '/*remove-start*/\n',
        );

        await validateReferences(scopePath: scopePath);

        expect(exitCode, 1);
      });

      test('throws when the reference directory is missing', () async {
        fixture.reference.deleteSync(recursive: true);

        expect(
          () => validateReferences(scopePath: scopePath),
          throwsException,
        );
      });
    });

    group('resolveBrickScope', () {
      test('resolves explicit scope paths', () {
        final resolved = resolveBrickScope(scopePath: scopePath);

        expect(resolved.scopeDir.path, scopePath);
        expect(
          resolved.brickGenDataFile.path,
          p.join(scopePath, 'brick-gen.json'),
        );
        expect(
          resolved.brickTemplateDir.path,
          p.join(scopePath, 'brick', '__brick__'),
        );
      });

      test('requires a melos scope when scopePath is null', () {
        expect(resolveBrickScope, throwsA(isA<Object>()));
      });
    });

    group('generateBrick', () {
      test(
        'generates the brick template from the reference directory',
        () async {
          await File(
            p.join(fixture.reference.path, 'hello.txt'),
          ).writeAsString(
            'hello\n',
          );

          await generateBrick(scopePath: scopePath);

          expect(
            File(p.join(fixture.template.path, 'hello.txt')).existsSync(),
            isTrue,
          );
        },
      );

      test('throws when brick-gen.json is invalid', () async {
        await File(
          p.join(fixture.scope.path, 'brick-gen.json'),
        ).writeAsString('not-json');

        expect(
          () => generateBrick(scopePath: scopePath),
          throwsException,
        );
      });

      test('throws when the reference directory is missing', () async {
        fixture.reference.deleteSync(recursive: true);

        expect(
          () => generateBrick(scopePath: scopePath),
          throwsException,
        );
      });
    });

    group('cli.main', () {
      test('runs validate via subcommand', () async {
        await File(p.join(fixture.reference.path, 'valid.dart')).writeAsString(
          '/*remove-start*/\n/*remove-end*/\n',
        );

        await cli.main(const ['validate'], scopePath: scopePath);

        expect(exitCode, 0);
      });

      test('runs preview via subcommand', () async {
        final referenceFile =
            File(p.join(fixture.reference.path, 'widget.dart'))
              ..createSync()
              ..writeAsStringSync('class Widget {}');
        await File(p.join(fixture.scope.path, 'brick-gen.json')).writeAsString(
          '''
{
  "replacements": [
    {
      "from": "Widget",
      "to": "PreviewWidget"
    }
  ]
}
''',
        );

        await cli.main([
          'preview',
          '--file',
          referenceFile.path,
          '--brick',
          'test_scope_brick_scope',
          '--root',
          fixture.root.path,
        ]);

        expect(exitCode, 0);
      });

      test('runs gen via default subcommand', () async {
        await File(
          p.join(fixture.reference.path, 'generated.txt'),
        ).writeAsString(
          'content\n',
        );

        await cli.main(const [], scopePath: scopePath);

        expect(
          File(p.join(fixture.template.path, 'generated.txt')).existsSync(),
          isTrue,
        );
      });

      test('throws for unknown subcommands', () async {
        expect(
          () => cli.main(const ['unknown']),
          throwsArgumentError,
        );
      });
    });
  });
}
