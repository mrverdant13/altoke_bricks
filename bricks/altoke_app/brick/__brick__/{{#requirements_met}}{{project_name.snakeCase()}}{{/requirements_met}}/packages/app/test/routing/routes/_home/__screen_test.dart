import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/state/counter_pod.dart';

import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

import '../../../helpers/helpers.dart';

@Dependencies([
  Counter,
  ])
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
