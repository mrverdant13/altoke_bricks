import 'dart:io';

import 'package:brick_generator/src/preview_options.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('PreviewVars', () {
    test('parses booleans, numbers, and strings', () {
      expect(
        PreviewVars.parse(
          'requirements_met=true,use_drift=false,count=3,name=app',
        ),
        {
          'requirements_met': true,
          'use_drift': false,
          'count': 3,
          'name': 'app',
        },
      );
    });

    test('returns empty map for null input', () {
      expect(PreviewVars.parse(null), isEmpty);
    });

    test('strips surrounding quotes from string values', () {
      expect(PreviewVars.parse('title="My App"'), {'title': 'My App'});
      expect(PreviewVars.parse("title='My App'"), {'title': 'My App'});
    });

    test('throws for invalid pairs', () {
      expect(() => PreviewVars.parse('not-a-pair'), throwsArgumentError);
    });
  });

  group('resolveMonorepoRoot', () {
    late Directory tempDir;
    late Directory previousWorkingDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('brick_preview_root_');
      previousWorkingDir = Directory.current;
      Directory.current = tempDir;
    });

    tearDown(() async {
      Directory.current = previousWorkingDir;
      if (tempDir.existsSync()) await tempDir.delete(recursive: true);
    });

    test('uses MELOS_ROOT_PATH from the environment map', () {
      final melosRoot = p.join(tempDir.path, 'melos');
      Directory(melosRoot).createSync();

      expect(
        resolveMonorepoRoot(
          null,
          environment: {'MELOS_ROOT_PATH': melosRoot},
        ),
        p.normalize(melosRoot),
      );
    });

    test('uses an explicit --root argument', () {
      final explicitRoot = p.join(tempDir.path, 'explicit');
      Directory(explicitRoot).createSync();
      expect(resolveMonorepoRoot(explicitRoot), p.normalize(explicitRoot));
    });

    test('reads Platform.environment when no override is provided', () {
      final melosRoot = Platform.environment['MELOS_ROOT_PATH'];
      if (melosRoot != null && melosRoot.isNotEmpty) {
        expect(
          resolveMonorepoRoot(null),
          p.normalize(melosRoot),
        );
        return;
      }

      Directory(p.join(tempDir.path, 'bricks')).createSync();
      File(p.join(tempDir.path, 'pubspec.yaml')).writeAsStringSync('name: root\n');
      Directory.current = tempDir;

      expect(
        resolveMonorepoRoot(null),
        p.normalize(Directory.current.path),
      );
    });

    test('returns the current directory when it is the monorepo root', () {
      Directory(p.join(tempDir.path, 'bricks')).createSync();
      File(p.join(tempDir.path, 'pubspec.yaml')).writeAsStringSync('name: root\n');
      Directory.current = tempDir;
      final expectedRoot = p.normalize(Directory.current.path);

      expect(resolveMonorepoRoot(null, environment: {}), expectedRoot);
    });

    test('walks up from a nested directory to the monorepo root', () {
      Directory(p.join(tempDir.path, 'bricks')).createSync();
      File(p.join(tempDir.path, 'pubspec.yaml')).writeAsStringSync('name: root\n');
      Directory.current = tempDir;
      final expectedRoot = resolveMonorepoRoot(null, environment: {});

      Directory.current = Directory(
        p.join(tempDir.path, 'nested', 'deep'),
      )..createSync(recursive: true);

      expect(resolveMonorepoRoot(null, environment: {}), expectedRoot);
    });

    test('throws when the monorepo root cannot be resolved', () {
      expect(
        () => resolveMonorepoRoot(null, environment: {}),
        throwsArgumentError,
      );
    });
  });

  group('BrickScopePaths', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('brick_preview_scope_');
    });

    tearDown(() async {
      if (tempDir.existsSync()) await tempDir.delete(recursive: true);
    });

    test('strips the _brick_scope suffix', () {
      final scopeDir = Directory(
        p.join(tempDir.path, 'bricks', 'sample'),
      )..createSync(recursive: true);

      expect(
        BrickScopePaths.scopeDirectory(
          rootPath: tempDir.path,
          brickScope: 'sample_brick_scope',
        ),
        p.normalize(scopeDir.path),
      );
    });

    test('accepts an absolute scope directory under the root', () {
      final scopeDir = Directory(p.join(tempDir.path, 'custom_scope'))
        ..createSync(recursive: true);

      expect(
        BrickScopePaths.scopeDirectory(
          rootPath: tempDir.path,
          brickScope: scopeDir.path,
        ),
        p.normalize(scopeDir.path),
      );
    });

    test('throws when the scope cannot be resolved', () {
      expect(
        () => BrickScopePaths.scopeDirectory(
          rootPath: tempDir.path,
          brickScope: 'missing_scope',
        ),
        throwsArgumentError,
      );
    });
  });

  group('PreviewOptions.fromArgs', () {
    late Directory tempDir;
    late String referenceFilePath;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('brick_preview_args_');
      Directory(p.join(tempDir.path, 'bricks')).createSync();
      File(
        p.join(tempDir.path, 'pubspec.yaml'),
      ).writeAsStringSync('name: root\n');

      final scopeDir = Directory(p.join(tempDir.path, 'bricks', 'sample'))
        ..createSync(recursive: true);
      final referenceDir = Directory(p.join(scopeDir.path, 'reference'))
        ..createSync(recursive: true);
      referenceFilePath = p.join(referenceDir.path, 'widget.dart');
      await File(referenceFilePath).writeAsString('class Widget {}');
    });

    tearDown(() async {
      if (tempDir.existsSync()) await tempDir.delete(recursive: true);
    });

    test('parses preview arguments', () {
      final options = PreviewOptions.fromArgs([
        '--file',
        referenceFilePath,
        '--brick',
        'sample',
        '--vars',
        'use_riverpod=true',
        '--root',
        tempDir.path,
      ]);

      expect(options.brickScope, 'sample');
      expect(options.vars, {'use_riverpod': true});
      expect(options.rootPath, p.normalize(tempDir.path));
      expect(options.filePath, p.normalize(p.absolute(referenceFilePath)));
    });

    test('requires --file and --brick', () {
      expect(
        () => PreviewOptions.fromArgs(['--file', 'a.txt']),
        throwsArgumentError,
      );
      expect(
        () => PreviewOptions.fromArgs(['--brick', 'sample']),
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.message,
            'message',
            contains('Missing required --file'),
          ),
        ),
      );
    });

    test('throws for unknown arguments', () {
      expect(
        () => PreviewOptions.fromArgs(['--unknown']),
        throwsArgumentError,
      );
    });

    test('throws when a flag value is missing', () {
      expect(
        () => PreviewOptions.fromArgs(['--file']),
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.message,
            'message',
            contains('Missing value for --file'),
          ),
        ),
      );
    });
  });
}
