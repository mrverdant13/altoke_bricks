import 'package:altoke_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CounterFab extends StatelessWidget {
  const CounterFab({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FloatingActionButton(
      onPressed: onTap,
      tooltip: l10n.counterIncrementButtonTooltip,
      child: const Icon(Icons.add),
    );
  }
}
