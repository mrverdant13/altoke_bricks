{{#use_riverpod}}import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';{{/use_riverpod}}import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';

import 'package:flutter_test/flutter_test.dart';{{#use_riverpod}}import 'package:riverpod_annotation/experimental/scope.dart';{{/use_riverpod}}import '../../../helpers/helpers.dart';

{{#use_riverpod}}@Dependencies([
  Counter,
  ]){{/use_riverpod}}
void main() {
  {{#use_auto_route}}group('$HomeRoute', () {
      testWidgets(
        'shows the $HomeScreen',
        (tester) async {
          await tester.pumpAutoRouteAppWithInitialRoute(
            const HomeRoute(),
          );
          await tester.pumpUntilFound(
            find.byType(HomeScreen),
          );
        },
      );
    });{{/use_auto_route}}{{#use_go_router}}group('$HomeRouteData', () {
      testWidgets(
        'shows the $HomeScreen',
        (tester) async {
          await tester.pumpGoRouterAppWithInitialRoute(
            const HomeRouteData(),
          );
          await tester.pumpUntilFound(
            find.byType(HomeScreen),
          );
        },
      );
    });{{/use_go_router}}}
