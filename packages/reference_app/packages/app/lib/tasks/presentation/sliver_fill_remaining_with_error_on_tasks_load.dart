import 'package:altoke_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SliverFillRemainingWithErrorOnTasksLoad extends ConsumerWidget {
  const SliverFillRemainingWithErrorOnTasksLoad({
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
            l10n.tasksUnexpectedTasksLoadErrorMessage,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
