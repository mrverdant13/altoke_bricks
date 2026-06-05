import 'dart:io';

import 'package:brick_generator/src/preview_options.dart';
import 'package:brick_generator/src/preview_reference.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('previewReference', () {
    late Directory tempDir;
    late String rootPath;
    late String referenceFilePath;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('brick_preview_test_');
      rootPath = tempDir.path;

      final scopeDir = Directory(p.join(rootPath, 'bricks', 'sample'));
      final referenceDir = Directory(p.join(scopeDir.path, 'reference'))
        ..createSync(recursive: true);
      await File(p.join(scopeDir.path, 'brick-gen.json')).writeAsString('''
{
  "replacements": [
    {
      "from": "Widget",
      "to": "{{#use_riverpod}}ConsumerWidget{{/use_riverpod}}{{^use_riverpod}}StatelessWidget{{/use_riverpod}}"
    }
  ]
}
''');

      referenceFilePath = p.join(referenceDir.path, 'widget.dart');
      await File(referenceFilePath).writeAsString('''
class App extends Widget {
  /*remove-start*/
  // scaffold
  /*remove-end*/
}
''');
    });

    tearDown(() async {
      await tempDir.delete(recursive: true);
    });

    test('writes transformed content to the output sink', () async {
      final output = StringBuffer();
      await previewReference(
        PreviewOptions(
          filePath: referenceFilePath,
          brickScope: 'sample',
          vars: PreviewVars.parse('use_riverpod=true'),
          rootPath: rootPath,
        ),
        write: output.write,
      );

      final result = output.toString();
      expect(result, contains('class App extends ConsumerWidget'));
      expect(result, isNot(contains('remove-start')));
      expect(result, isNot(contains('scaffold')));
    });

    test('keeps mustache tags when templateOnly is true', () async {
      final output = StringBuffer();
      await previewReference(
        PreviewOptions(
          filePath: referenceFilePath,
          brickScope: 'sample',
          vars: PreviewVars.parse('use_riverpod=true'),
          rootPath: rootPath,
          templateOnly: true,
        ),
        write: output.write,
      );

      final result = output.toString();
      expect(
        result,
        contains('{{#use_riverpod}}ConsumerWidget{{/use_riverpod}}'),
      );
      expect(
        result,
        contains('{{^use_riverpod}}StatelessWidget{{/use_riverpod}}'),
      );
      expect(result, isNot(contains('class App extends ConsumerWidget')));
      expect(result, isNot(contains('remove-start')));
    });

    test('selects the stateless branch when use_riverpod is false', () async {
      final output = StringBuffer();
      await previewReference(
        PreviewOptions(
          filePath: referenceFilePath,
          brickScope: 'sample',
          vars: PreviewVars.parse('use_riverpod=false'),
          rootPath: rootPath,
        ),
        write: output.write,
      );

      expect(output.toString(), contains('class App extends StatelessWidget'));
    });

    test('writes to stdout when no custom sink is provided', () async {
      await previewReference(
        PreviewOptions(
          filePath: referenceFilePath,
          brickScope: 'sample',
          vars: PreviewVars.parse('use_riverpod=true'),
          rootPath: rootPath,
        ),
      );
    });

    test('throws when the reference file does not exist', () async {
      expect(
        () => previewReference(
          PreviewOptions(
            filePath: p.join(rootPath, 'missing.dart'),
            brickScope: 'sample',
            vars: const {},
            rootPath: rootPath,
          ),
        ),
        throwsArgumentError,
      );
    });

    test('throws when the reference directory is missing', () async {
      final scopeWithoutReference = Directory(
        p.join(rootPath, 'bricks', 'empty'),
      )..createSync(recursive: true);
      await File(
        p.join(scopeWithoutReference.path, 'brick-gen.json'),
      ).writeAsString(
        '{"replacements":[]}',
      );

      expect(
        () => previewReference(
          PreviewOptions(
            filePath: referenceFilePath,
            brickScope: 'empty',
            vars: const {},
            rootPath: rootPath,
          ),
        ),
        throwsArgumentError,
      );
    });

    test('throws when the file is outside the reference directory', () async {
      final outsideFile = File(p.join(rootPath, 'outside.dart'))
        ..createSync()
        ..writeAsStringSync('class Outside {}');

      expect(
        () => previewReference(
          PreviewOptions(
            filePath: outsideFile.path,
            brickScope: 'sample',
            vars: const {},
            rootPath: rootPath,
          ),
        ),
        throwsArgumentError,
      );
    });

    test('throws when brick-gen.json is missing', () async {
      final scopeDir = Directory(p.join(rootPath, 'bricks', 'no_config'))
        ..createSync(recursive: true);
      final referenceDir = Directory(p.join(scopeDir.path, 'reference'))
        ..createSync(recursive: true);
      final filePath = p.join(referenceDir.path, 'widget.dart');
      await File(filePath).writeAsString('class Widget {}');

      expect(
        () => previewReference(
          PreviewOptions(
            filePath: filePath,
            brickScope: 'no_config',
            vars: const {},
            rootPath: rootPath,
          ),
        ),
        throwsArgumentError,
      );
    });

    test('loads partial files created during transformation', () async {
      await File(referenceFilePath).writeAsString('''
class App extends Widget {
  /*partial v footer*/
  // footer line
  /*partial ^ footer*/
}
''');
      final output = StringBuffer();
      await previewReference(
        PreviewOptions(
          filePath: referenceFilePath,
          brickScope: 'sample',
          vars: PreviewVars.parse('use_riverpod=true'),
          rootPath: rootPath,
        ),
        write: output.write,
      );

      expect(output.toString(), contains('footer line'));
    });
  });
}
