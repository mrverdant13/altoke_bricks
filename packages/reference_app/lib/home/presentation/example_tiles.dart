import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CounterExampleTile extends StatelessWidget {
  const CounterExampleTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListTile(
      title: Text(
        l10n.counterExampleLabel,
        key: const Key('<counter::example-tile::title>'),
      ),
      onTap: () {
        context.navigateTo(
          CounterRoute(),
        );
      },
    );
  }
}
