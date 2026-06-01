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
  });
}
