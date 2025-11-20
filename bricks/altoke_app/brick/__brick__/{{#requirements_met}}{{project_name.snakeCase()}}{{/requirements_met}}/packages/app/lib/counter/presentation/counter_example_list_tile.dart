
{{#use_riverpod}}
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
{{/use_riverpod}}
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/l10n/l10n.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';
import 'package:flutter/material.dart';
{{#use_riverpod}}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
{{/use_riverpod}}

{{#use_riverpod}}@Dependencies([
  Counter,
]){{/use_riverpod}}
class CounterExampleListTile extends {{#use_riverpod}}ConsumerWidget{{/use_riverpod}}{{^use_riverpod}}StatelessWidget{{/use_riverpod}} {
  const CounterExampleListTile({super.key});

  @override
  Widget build(BuildContext context{{#use_riverpod}}, WidgetRef ref{{/use_riverpod}}) {
    final l10n = context.l10n;
    return ListTile(
      title: Text(l10n.counterExampleListTileTitle),
      onTap: () async {
        {{#use_auto_route}}await const CounterRoute().navigate(context);{{/use_auto_route}}{{#use_go_router}}const CounterRouteData().go(context);{{/use_go_router}}
      },
    );
  }
}
