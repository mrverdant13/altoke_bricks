import 'package:altoke_app/tasks/tasks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks/tasks.dart';

part 'async_paginated_filtered_tasks.pod.g.dart';

@Riverpod(
  dependencies: [
    tasksRepository,
    SelectedTasksStatusFilter,
    TaskSearchTerm,
  ],
)
Stream<List<Task>> asyncPaginatedFilteredTasks(
  AsyncPaginatedFilteredTasksRef ref, {
  required int offset,
  required int limit,
}) {
  final statusFilter = ref.watch(selectedTasksStatusFilterPod);
  final searchTerm = ref.watch(taskSearchTermPod);
  final tasksRepository = ref.watch(tasksRepositoryPod);
  return tasksRepository.watchPaginatedTasks(
    offset: offset,
    limit: limit,
    statusFilter: statusFilter,
    searchTerm: searchTerm,
  );
}
