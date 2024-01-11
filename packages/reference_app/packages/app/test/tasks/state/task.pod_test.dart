import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    '''

GIVEN a scoped tasks pod
WHEN the pod is invoked
THEN the pod should throw an error

''',
    () async {
      final container = ProviderContainer();

      void action() => container.read(taskPod);

      expect(
        action,
        throwsA(
          isA<UnimplementedError>().having(
            (error) => error.message,
            'message',
            '`taskPod` was not initialized.',
          ),
        ),
      );
    },
  );
}
