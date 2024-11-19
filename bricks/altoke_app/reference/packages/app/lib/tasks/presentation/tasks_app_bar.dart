import 'package:altoke_app/external/external.dart';
import 'package:altoke_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// coverage:ignore-start
class TasksAppBar extends AppBar {
  TasksAppBar({
    super.key,
  }) : super(
          title: const TasksAppBarTitle(),
          actions: [
            const SwitchDbPackageAction(),
          ],
        );
}

@visibleForTesting
class TasksAppBarTitle extends ConsumerWidget {
  const TasksAppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocalDatabasePackage = ref.watch(
      selectedLocalDatabasePackagePod.select((package) => package.displayName),
    );
    return Text(
      '${context.l10n.tasksAppBarTitle} - $selectedLocalDatabasePackage',
      key: const Key('<tasks::tasks-app-bar::title>'),
    );
  }
}

@visibleForTesting
class SwitchDbPackageAction extends ConsumerWidget {
  const SwitchDbPackageAction({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.storage),
      onPressed: () {
        final selectedLocalDatabasePackageIndex =
            ref.read(selectedLocalDatabasePackagePod).index;
        final newLocalDatabasePackageIndex =
            (selectedLocalDatabasePackageIndex + 1) %
                LocalDatabasePackage.values.length;
        ref.read(selectedLocalDatabasePackagePod.notifier).value =
            LocalDatabasePackage.values[newLocalDatabasePackageIndex];
      },
    );
  }
}
// coverage:ignore-end
