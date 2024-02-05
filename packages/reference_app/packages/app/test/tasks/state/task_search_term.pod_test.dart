import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    '''

GIVEN a tasks search term notifier''',
    () {
      late ProviderContainer container;

      setUp(
        () {
          container = ProviderContainer();
        },
      );

      tearDown(
        () {
          container.dispose();
        },
      );

      test(
        '''

WHEN the notifier is built
THEN the notifier should be initialized
AND the initial term should be an empty string

''',
        () {
          final initialSearchTerm = container.read(taskSearchTermPod);
          expect(initialSearchTerm, isA<String>());
          expect(initialSearchTerm, isEmpty);
        },
      );

      test(
        '''

AND a new search term
WHEN the new search term is set
THEN the new search term should be set

''',
        () {
          const newSearchTerm = 'newSearchTerm';
          container.read(taskSearchTermPod.notifier).searchTerm = newSearchTerm;
          expect(container.read(taskSearchTermPod), newSearchTerm);
        },
      );
    },
  );
}
