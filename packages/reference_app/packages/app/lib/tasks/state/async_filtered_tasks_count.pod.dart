import 'package:altoke_app/tasks/tasks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_filtered_tasks_count.pod.g.dart';

@Riverpod(
  dependencies: [
    tasksStorage,
    SelectedTasksStatusFilter,
    TaskSearchTerm,
  ],
)
Stream<int> asyncFilteredTasksCount(
  AsyncFilteredTasksCountRef ref,
) {
  final statusFilter = ref.watch(selectedTasksStatusFilterPod);
  final searchTerm = ref.watch(taskSearchTermPod);
  final tasksStorage = ref.watch(tasksStoragePod);
  return tasksStorage.watchCount(
    statusFilter: statusFilter,
    searchTerm: searchTerm,
  );
}
