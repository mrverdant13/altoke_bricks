import 'package:{{project_name.snakeCase()}}/counter/counter.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CounterAppBar extends AppBar {
  CounterAppBar({super.key})
      : super(
          title: const CounterAppBarTitle(),
          actions: const [
            ResetCounterIconButton(),
          ],
        );
}

@visibleForTesting
class CounterAppBarTitle extends StatelessWidget {
  const CounterAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Text(
      l10n.counterAppBarTitle,
      key: const Key('<counter::counter-app-bar::title>'),
    );
  }
}