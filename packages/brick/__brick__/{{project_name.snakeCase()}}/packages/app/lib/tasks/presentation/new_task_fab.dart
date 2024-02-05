import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:{{project_name.snakeCase()}}/routing/routing.dart';{{#use_auto_route_router}}import 'package:auto_route/auto_route.dart';{{/use_auto_route_router}}import 'package:flutter/material.dart';class NewTaskFab extends StatelessWidget {
  const NewTaskFab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FloatingActionButton(
      tooltip: l10n.tasksNewTaskButtonTooltip,
      onPressed: () {
{{#use_auto_route_router}}context.navigateTo(const NewTaskRoute());{{/use_auto_route_router}}{{#use_go_router_router}}const NewTaskRouteData().go(context);{{/use_go_router_router}}
},
      child: const Icon(Icons.add),
    );
  }
}
