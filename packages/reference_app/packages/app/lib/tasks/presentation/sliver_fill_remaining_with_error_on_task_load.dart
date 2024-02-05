import 'package:altoke_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SliverFillRemainingWithErrorOnTaskLoad extends ConsumerWidget {
  const SliverFillRemainingWithErrorOnTaskLoad({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          key: const Key(
            '<tasks:sliver-fill-remaining-with-error-on-task-load:message>',
          ),
          l10n.tasksUnexpectedErrorWhenLoadingTaskDetailsMessage,
        ),
      ),
    );
  }
}
