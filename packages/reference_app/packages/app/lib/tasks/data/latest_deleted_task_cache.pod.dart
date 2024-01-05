import 'package:element_in_memory_cache/element_in_memory_cache.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks/tasks.dart';

part 'latest_deleted_task_cache.pod.g.dart';

@Riverpod(dependencies: [])
ElementInMemoryCache<Task> latestDeletedTaskCache(
  LatestDeletedTaskCacheRef ref,
) {
  final cache = ElementInMemoryCache<Task>();
  ref.onDispose(
    () async {
      await cache.dispose();
    },
  );
  return cache;
}
