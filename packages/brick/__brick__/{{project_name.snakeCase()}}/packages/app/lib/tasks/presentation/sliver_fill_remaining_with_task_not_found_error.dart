import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SliverFillRemainingWithTaskNotFoundError extends ConsumerWidget {
  const SliverFillRemainingWithTaskNotFoundError({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 75,
            ),
            const SizedBox(height: 10),
            Text(
              key: const Key(
                '''<tasks:sliver-fill-remaining-with-task-not-found-error:message>''',
              ),
              l10n.tasksNoTaskFoundByIdMessage,
            ),
          ],
        ),
      ),
    );
  }
}
