import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

import '../../../helpers/helpers.dart';

@Dependencies([
  Counter,
])
void main() {
  {{#use_auto_route}}group('$CounterRoute', () {
      testWidgets(
        'shows the $CounterScreen',
        (tester) async {
          await tester.pumpAutoRouteAppWithInitialRoute(
            const CounterRoute(),
          );
          await tester.pumpUntilFound(
            find.byType(CounterScreen),
          );
        },
      );
    });{{/use_auto_route}}{{#use_go_router}}group('$CounterRouteData', () {
      testWidgets(
        'shows the $CounterScreen',
        (tester) async {
          await tester.pumpGoRouterAppWithInitialRoute(
            const CounterRouteData(),
          );
          await tester.pumpUntilFound(
            find.byType(CounterScreen),
          );
        },
      );
    });{{/use_go_router}}
}
