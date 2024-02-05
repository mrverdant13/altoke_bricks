import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';
import 'package:element_in_memory_cache/element_in_memory_cache.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasks/tasks.dart';

import '../../helpers/helpers.dart';

void main() {
  test(
    '''

GIVEN an injected cache for the latest deleted task
WHEN the pod is read
THEN the pod should return the cache

''',
    () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final cache = container.read(latestDeletedTaskCachePod);
      expect(
        cache,
        isA<ElementInMemoryCache<Task>>(),
      );
    },
  );

  test(
    '''

GIVEN an injected cache for the latest deleted task
WHEN the pod is disposed
THEN the cache should be disposed

''',
    () async {
      final mockLatestDeletedTaskCache = MockLatestDeletedTaskCache();
      when(mockLatestDeletedTaskCache.dispose).thenAnswer((_) async {});
      buildLatestDeletedTaskCache = () => mockLatestDeletedTaskCache;
      final container = ProviderContainer();
      final cache = container.read(latestDeletedTaskCachePod);
      expect(cache, mockLatestDeletedTaskCache);
      container.dispose();
      verify(mockLatestDeletedTaskCache.dispose).called(1);
      verifyNoMoreInteractions(mockLatestDeletedTaskCache);
    },
  );
}
