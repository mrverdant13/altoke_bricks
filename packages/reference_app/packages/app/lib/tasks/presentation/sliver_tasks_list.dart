import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@visibleForTesting
const tasksPerPage = 15;

class SliverTasksList extends ConsumerWidget {
  const SliverTasksList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTasksCount = ref.watch(asyncFilteredTasksCountPod);
    return TaskDeletionSnackbarWrapper(
      child: asyncTasksCount.when(
        data: (tasksCount) {
          if (tasksCount == 0) return const SliverFillRemainingNoTasksMessage();
          return const SliverNonEmptyTasksList();
        },
        error: (_, __) => const SliverFillRemainingWithErrorOnTasksLoad(),
        loading: () => const SliverSkeletonTasksList(),
      ),
    );
  }
}

@visibleForTesting
class SliverNonEmptyTasksList extends ConsumerWidget {
  const SliverNonEmptyTasksList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksCount = ref.watch(
      asyncFilteredTasksCountPod.select(
        (asyncCount) => asyncCount.valueOrNull,
      ),
    );
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 100),
      sliver: SliverList.builder(
        itemCount: tasksCount,
        itemBuilder: (context, index) {
          final offset = (index ~/ tasksPerPage) * tasksPerPage;
          final localIndex = index % tasksPerPage;
          final pod = asyncPaginatedFilteredTasksPod(
            offset: offset,
            limit: tasksPerPage,
          );
          final asyncTask = ref.watch(
            pod.select(
              (asyncPaginatedTasks) => asyncPaginatedTasks.whenData(
                (paginatedTasks) => paginatedTasks.elementAtOrNull(localIndex),
              ),
            ),
          );
          return asyncTask.when(
            skipLoadingOnRefresh: false,
            data: (task) => switch (task) {
              null =>
                localIndex == tasksPerPage - 1 ? null : const SizedBox.shrink(),
              _ => ProviderScope(
                  key: ValueKey(
                    '''<tasks:sliver-tasks-list:task-tile:id-${task.id}:idx-$index>''',
                  ),
                  overrides: [
                    taskPod.overrideWithValue(task),
                  ],
                  child: const TaskTile(),
                )
            },
            error: (_, __) {
              if (localIndex > 0) return const SizedBox.shrink();
              return TaskErrorItem(
                onRetry: () => ref.invalidate(pod),
              );
            },
            loading: () => const TaskTile.skeleton(),
          );
        },
      ),
    );
  }
}

@visibleForTesting
class SliverSkeletonTasksList extends ConsumerWidget {
  const SliverSkeletonTasksList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 100),
      sliver: SliverList.builder(
        itemCount: 100,
        itemBuilder: (context, index) => const TaskTile.skeleton(),
      ),
    );
  }
}

@visibleForTesting
class TaskErrorItem extends ConsumerWidget {
  const TaskErrorItem({
    super.key,
    this.onRetry,
  });

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            key: const Key('<tasks:task-error-item:message>'),
            l10n.tasksUnexpectedTasksLoadErrorMessage,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(
                key: const Key('<tasks:task-error-item:retry-button>'),
                l10n.genericRetryButtonLabel,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
