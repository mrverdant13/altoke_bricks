import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncrementCounterFab extends ConsumerWidget {
  const IncrementCounterFab({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return FloatingActionButton(
      onPressed: () => ref.read(counterPod.notifier).increment(),
      tooltip: l10n.counterIncrementButtonTooltip,
      child: const Icon(Icons.add),
    );
  }
}
