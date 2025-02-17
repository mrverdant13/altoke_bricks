import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/routing/routing.dart';
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
        /*w 1v w*/
        /*remove-start*/
        switch (ref.read(selectedRouterPackagePod)) {
          case RouterPackage.autoRoute:
            /*remove-end*/
            /*{{#use_auto_route}}*/
            const CounterRoute().navigate(context);
          /*{{/use_auto_route}}*/
          /*remove-start*/
          case RouterPackage.goRouter:
            /*remove-end*/
            /*{{#use_go_router}}*/
            const CounterRouteData().go(context);
          /*{{/use_go_router}}*/
          /*remove-start*/
        }
        /*remove-end*/
        /*w 1v w*/
      },
    );
  }
}
