import 'package:element_in_memory_cache/element_in_memory_cache.dart';
import 'package:meta/meta.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks/tasks.dart';

part 'latest_deleted_task_cache.pod.g.dart';

@visibleForTesting
typedef LatestDeletedTaskCacheBuilder = ElementInMemoryCache<Task> Function();

@visibleForTesting
LatestDeletedTaskCacheBuilder buildLatestDeletedTaskCache =
    ElementInMemoryCache<Task>.new;

@Riverpod(dependencies: [])
ElementInMemoryCache<Task> latestDeletedTaskCache(
  LatestDeletedTaskCacheRef ref,
) {
  final cache = buildLatestDeletedTaskCache();
  ref.onDispose(
    () async {
      await cache.dispose();
    },
  );
  return cache;
}
