import 'dart:io';

import 'package:altoke_app/external/external.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../helpers/helpers.dart';

void main() {
  late PathProviderPlatform pathProviderPlatform;

  setUp(() {
    pathProviderPlatform = MockPathProviderPlatform();
    PathProviderPlatform.instance = pathProviderPlatform;
  });

  test(
    '''

GIVEN an async pod for the application documents directory
WHEN it is invoked
THEN it should return the application documents directory
''',
    () async {
      when(
        pathProviderPlatform.getApplicationDocumentsPath,
      ).thenAnswer((_) async => 'mock/app-docs-path');
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final asyncApplicationDocumentsDirectory = container.read(
        asyncApplicationDocumentsDirectoryPod.future,
      );
      await expectLater(
        asyncApplicationDocumentsDirectory,
        completion(
          isA<Directory>().having(
            (directory) => directory.path,
            'path',
            'mock/app-docs-path',
          ),
        ),
      );
    },
  );

  test(
    '''

GIVEN an async pod for the temporary directory
WHEN it is invoked
THEN it should return the temporary directory
''',
    () async {
      when(
        pathProviderPlatform.getTemporaryPath,
      ).thenAnswer((_) async => 'mock/temp-path');
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final asyncTemporaryDirectory = container.read(
        asyncTemporaryDirectoryPod.future,
      );
      await expectLater(
        asyncTemporaryDirectory,
        completion(
          isA<Directory>().having(
            (directory) => directory.path,
            'path',
            'mock/temp-path',
          ),
        ),
      );
    },
  );
}
