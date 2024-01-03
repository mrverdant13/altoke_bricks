import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/routing/routing.dart';
/*{{#use_auto_route_router}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route_router}}*/
import 'package:flutter/material.dart';
/*remove-start*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
/*remove-end*/

class TasksExampleTile extends StatelessWidget {
  const TasksExampleTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListTile(
      title: Text(
        l10n.tasksExampleLabel,
        key: const Key('<tasks::example-tile::title>'),
      ),
      onTap: () {
        /*w 1v w*/
        /*remove-start*/
        final container = ProviderScope.containerOf(context, listen: false);
        final routerPackage = container.read(routerPod);
        switch (routerPackage) {
          case RouterPackage.autoRoute:
            /*remove-end*/
            /*{{#use_auto_route_router}}*/
            context.navigateTo(const TasksRoute());
          /*{{/use_auto_route_router}}*/
          /*remove-start*/
          case RouterPackage.goRouter: /*remove-end*/
            /*{{#use_go_router_router}}*/
            const TasksRouteData().go(context);
          /*{{/use_go_router_router}}*/
          /*remove-start*/
        } /*remove-end*/
        /*w 1v w*/
      },
    );
  }
}
