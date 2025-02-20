import 'dart:io';

import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/app/app.dart';import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';void main() {
  test(
    '''

GIVEN an async initializer sequence
WHEN the async initializer sequence is run
THEN the async initializer sequence should complete
''',
    () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final subscription = container.listen(
        asyncInitializationPod.future,
        (_, __) {},
      );
      addTearDown(subscription.close);
      final future = container.read(asyncInitializationPod.future);
      await expectLater(future, completes);},
  );
}
