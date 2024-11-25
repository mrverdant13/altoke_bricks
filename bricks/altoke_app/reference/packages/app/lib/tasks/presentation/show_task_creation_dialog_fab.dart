import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// coverage:ignore-start
class ShowTaskCreationDialogFab extends ConsumerWidget {
  const ShowTaskCreationDialogFab({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return FloatingActionButton(
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (context) => const TaskCreationDialog(),
        );
      },
      tooltip: l10n.createTaskButtonTooltip,
      child: const Icon(Icons.add),
    );
  }
}
// coverage:ignore-end
