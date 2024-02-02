import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    '''

GIVEN a scoped task ID pod
WHEN the pod is invoked
THEN the pod should throw an error

''',
    () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      void action() => container.read(scopedTaskIdPod);

      expect(
        action,
        throwsA(
          isA<UnimplementedError>().having(
            (error) => error.message,
            'message',
            '`scopedTaskIdPod` not initialized',
          ),
        ),
      );
    },
  );
}
