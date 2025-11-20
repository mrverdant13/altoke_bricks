/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end*/
/*{{#use_riverpod}}*/
import 'package:altoke_app/counter/counter.dart';
/*{{/use_riverpod}}*/
import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:flutter/material.dart';
/*{{#use_riverpod}}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
/*{{/use_riverpod}}*/

@Dependencies([
  /*remove-start*/
  SelectedRouterPackage,
  SelectedStateManagementPackage,
  /*remove-end-x*/
  Counter,
])
class CounterExampleListTile extends ConsumerWidget {
  const CounterExampleListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return ListTile(
      title: Text(l10n.counterExampleListTileTitle),
      onTap: () async {
        /*remove-start*/
        switch (ref.read(selectedRouterPackagePod)) {
          case RouterPackage.autoRoute:
            /*remove-end-x*/
            /*{{#use_auto_route}}x*/
            await const CounterRoute().navigate(context);
          /*x{{/use_auto_route}}x*/
          /*remove-start*/
          case RouterPackage.goRouter:
            /*remove-end*/
            /*x{{#use_go_router}}x*/
            const CounterRouteData().go(context);
          /*x{{/use_go_router}}*/
          /*x-remove-start*/
        }
        /*remove-end*/
      },
    );
  }
}
