import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/l10n/l10n.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterExampleListTile extends ConsumerWidget {
  const CounterExampleListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return ListTile(
      title: Text(l10n.counterExampleListTileTitle),
      onTap: () {
        {{#use_auto_route}}const CounterRoute().navigate(context);{{/use_auto_route}}{{#use_go_router}}const CounterRouteData().go(context);{{/use_go_router}}
      },
    );
  }
}
