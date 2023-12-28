import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@visibleForTesting
const tasksPerPage = 10;

class SliverTasksList extends ConsumerWidget {
  const SliverTasksList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return ref.watch(asyncFilteredTasksCountPod).when(
          data: (tasksCount) {
            if (tasksCount == 0) {
              return SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      l10n.tasksEmptyTasksMessage,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }
            return const SliverNonEmptyTasksList();
          },
          error: (error, stackTrace) => SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Text(
                  l10n.tasksUnexpectedErrorMessage,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          loading: () => SliverPadding(
            padding: EdgeInsets.zero,
            sliver: SliverList.builder(
              itemCount: 100,
              itemBuilder: (context, index) => const TaskTile.skeleton(),
            ),
          ),
        );
  }
}

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
        findChildIndexCallback: (key) {
          if (key is! ValueKey<String>) return null;
          final idxMatch = RegExp(r':idx-(\d+)>').firstMatch(key.value);
          if (idxMatch == null) return null;
          final idxCandidate = idxMatch.group(1);
          if (idxCandidate == null) return null;
          return int.tryParse(idxCandidate);
        },
        itemBuilder: (context, index) {
          final paginationOffset = (index ~/ tasksPerPage) * tasksPerPage;
          final localTaskOffset = index % tasksPerPage;
          final asyncTask = ref.watch(
            asyncPaginatedFilteredTasksPod(
              offset: paginationOffset,
              limit: tasksPerPage,
            ).select(
              (asyncPaginatedTasks) => asyncPaginatedTasks.whenData(
                (paginatedTasks) =>
                    paginatedTasks.elementAtOrNull(localTaskOffset),
              ),
            ),
          );
          return asyncTask.when(
            data: (task) => switch (task) {
              null => null,
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
            error: (error, stackTrace) => const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text('error'),
              ),
            ),
            loading: () => const TaskTile.skeleton(),
          );
        },
      ),
    );
  }
}
