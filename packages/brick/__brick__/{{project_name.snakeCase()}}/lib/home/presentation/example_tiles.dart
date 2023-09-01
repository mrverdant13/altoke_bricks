import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:{{project_name.snakeCase()}}/routing/routing.dart';{{#use_auto_route_router}}import 'package:auto_route/auto_route.dart';{{/use_auto_route_router}}import 'package:flutter/material.dart';

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
{{#use_auto_route_router}}context.navigateTo(CounterRoute());{{/use_auto_route_router}}{{#use_go_router_router}}CounterRouteData().go(context);{{/use_go_router_router}}
},
    );
  }
}
