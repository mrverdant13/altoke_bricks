import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';
import 'package:meta/meta.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks/tasks.dart';

part 'tasks_mutator.pod.g.dart';

@Riverpod(
  dependencies: [
    tasksRepository,
  ],
)
class TasksMutator extends _$TasksMutator {
  @override
  TasksMutationState build() {
    return const TasksMutationIdle();
  }

  Future<void> updateTask({
    required int taskId,
    required PartialTask partialTask,
  }) async {
    if (state.isLoading) return;
    state = const TasksUpdatingTask();
    final tasksRepository = ref.read(tasksRepositoryPod);
    state = await TasksMutationState.guard(
      () async => tasksRepository.updateTask(
        taskId: taskId,
        partialTask: partialTask,
      ),
    );
  }

  Future<void> deleteTask({
    required int taskId,
  }) async {
    if (state.isLoading) return;
    state = const TasksDeletingTask();
    final tasksRepository = ref.read(tasksRepositoryPod);
    state = await TasksMutationState.guard(
      () async => tasksRepository.deleteTask(
        taskId: taskId,
      ),
    );
  }

  Future<void> markAllAsCompleted() async {
    if (state.isLoading) return;
    state = const TasksMarkingAllAsCompleted();
    final tasksRepository = ref.read(tasksRepositoryPod);
    state = await TasksMutationState.guard(
      () async => tasksRepository.markAllTasksAsCompleted(),
    );
  }

  Future<void> deleteAllCompletedTasks() async {
    if (state.isLoading) return;
    state = const TasksDeletingAllCompleted();
    final tasksRepository = ref.read(tasksRepositoryPod);
    state = await TasksMutationState.guard(
      () async => tasksRepository.deleteAllTasks(
        referenceTask: PartialTask(
          isCompleted: () => true,
        ),
      ),
    );
  }
}

sealed class TasksMutationState {
  const TasksMutationState();

  @visibleForTesting
  static Future<TasksMutationState> guard(
    Future<void> Function() callback,
  ) async {
    try {
      await callback();
      return const TasksMutationIdle();
    } catch (error, stackTrace) {
      return TasksMutationFailure(
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  bool get isLoading => this is TasksMutating;
}

class TasksMutationIdle extends TasksMutationState {
  const TasksMutationIdle();
}

sealed class TasksMutating extends TasksMutationState {
  const TasksMutating();
}

class TasksUpdatingTask extends TasksMutating {
  const TasksUpdatingTask();
}

class TasksDeletingTask extends TasksMutating {
  const TasksDeletingTask();
}

class TasksMarkingAllAsCompleted extends TasksMutating {
  const TasksMarkingAllAsCompleted();
}

class TasksDeletingAllCompleted extends TasksMutating {
  const TasksDeletingAllCompleted();
}

class TasksMutationFailure extends TasksMutationState {
  const TasksMutationFailure({
    required this.error,
    required this.stackTrace,
  });

  final Object error;
  final StackTrace stackTrace;
}

@visibleForTesting
typedef TestableTasksMutator = _$TasksMutator;
