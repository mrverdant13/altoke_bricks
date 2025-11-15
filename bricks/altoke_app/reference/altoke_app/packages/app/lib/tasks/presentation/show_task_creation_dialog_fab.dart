import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([
  localTasksDao,
])
class ShowTaskCreationDialogFab extends ConsumerWidget {
  const ShowTaskCreationDialogFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return FloatingActionButton(
      onPressed: () async {
        await showDialog<void>(
          context: context,
          builder: (context) => const TaskCreationDialog(),
        );
      },
      tooltip: l10n.createTaskButtonTooltip,
      child: const Icon(Icons.add),
    );
  }
}
