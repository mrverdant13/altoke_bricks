import 'package:{{projectName.snakeCase()}}/counter/counter.dart';
import 'package:{{projectName.snakeCase()}}/l10n/l10n.dart';
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
