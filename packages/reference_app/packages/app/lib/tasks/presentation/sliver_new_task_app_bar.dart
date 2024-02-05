import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SliverNewTaskAppBar extends ConsumerWidget {
  const SliverNewTaskAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return SliverResponsiveAppBar(
      title: Text(
        key: const Key('<tasks::sliver-new-task-app-bar::title>'),
        l10n.tasksNewTaskAppBarTitle,
      ),
    );
  }
}
