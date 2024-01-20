import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskDeletionSnackbarWrapper extends ConsumerStatefulWidget {
  const TaskDeletionSnackbarWrapper({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  ConsumerState<TaskDeletionSnackbarWrapper> createState() =>
      _TaskDeletionSnackbarWrapperState();
}

class _TaskDeletionSnackbarWrapperState
    extends ConsumerState<TaskDeletionSnackbarWrapper> {
  late bool snackbarIsVisible;
  late ScaffoldMessengerState scaffoldMessengerState;

  @override
  void initState() {
    super.initState();
    snackbarIsVisible = false;
  }

  @override
  void dispose() {
    if (snackbarIsVisible) scaffoldMessengerState.hideCurrentSnackBar();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scaffoldMessengerState = ScaffoldMessenger.of(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    ref.listen(
      latestDeletedTaskPod.select(
        (asyncDeletedTask) => asyncDeletedTask.valueOrNull,
      ),
      (previousDeletedTask, deletedTask) {
        if (!mounted) return;
        if (previousDeletedTask == deletedTask) return;
        if (deletedTask == null) return;
        final snackbar = SnackBar(
          content: Text(
            l10n.tasksTaskDeletedSnackbarMessage,
            key: const Key(
              '<tasks::task-deletion-snackbar-wrapper::snackbar-content>',
            ),
          ),
          onVisible: () => snackbarIsVisible = true,
          action: SnackBarAction(
            label: l10n.tasksRestoreDeletedTaskSnackbarActionLabel,
            onPressed: ref.read(latestDeletedTaskPod.notifier).restore,
          ),
        );
        scaffoldMessengerState.hideCurrentSnackBar();
        final controller = scaffoldMessengerState.showSnackBar(snackbar);
        controller.closed.then((_) => snackbarIsVisible = false);
      },
    );
    return widget.child;
  }
}
