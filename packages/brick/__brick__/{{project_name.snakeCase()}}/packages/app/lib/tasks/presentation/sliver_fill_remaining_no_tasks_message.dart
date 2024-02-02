import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SliverFillRemainingNoTasksMessage extends ConsumerWidget {
  const SliverFillRemainingNoTasksMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
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
}
