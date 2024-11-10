import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TasksList extends ConsumerWidget {
  const TasksList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTasks = ref.watch(asyncTasksPod);
    return asyncTasks.when(
      data: (tasks) => const LoadedTasksList(),
      error: (error, stackTrace) => const FailedTasks(),
      loading: () => const LoadingTasksList(),
    );
  }
}

@visibleForTesting
class LoadedTasksList extends ConsumerWidget {
  const LoadedTasksList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(
      asyncTasksPod.select(
        (asyncTasks) => asyncTasks.requireValue,
      ),
    );
    if (tasks.isEmpty) {
      return Builder(
        builder: (context) {
          final l10n = context.l10n;
          return Center(
            child: Text(
              l10n.noTasksFoundMessage,
              key: const Key(
                '''<tasks::loaded-tasks-list::no-tasks-found-message>''',
              ),
            ),
          );
        },
      );
    }
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks.elementAt(index);
        return TaskListTile(
          task: task,
        );
      },
    );
  }
}

@visibleForTesting
class FailedTasks extends ConsumerWidget {
  const FailedTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Center(
      child: ElevatedButton(
        onPressed: () {
          ref.invalidate(asyncTasksPod);
        },
        child: Text(l10n.genericRetryButtonLabel),
      ),
    );
  }
}

@visibleForTesting
class LoadingTasksList extends StatelessWidget {
  const LoadingTasksList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
