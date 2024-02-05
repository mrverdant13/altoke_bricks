import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks/tasks.dart';

part 'selected_tasks_status_filter.pod.g.dart';

@Riverpod(dependencies: [])
class SelectedTasksStatusFilter extends _$SelectedTasksStatusFilter {
  @override
  TasksStatusFilter build() {
    return TasksStatusFilter.all;
  }

  // ignore: avoid_setters_without_getters
  set filter(TasksStatusFilter filter) {
    state = filter;
  }
}
