import 'package:altoke_app/counter/counter.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

import '../../../helpers/helpers.dart';

@Dependencies([
  Counter,
])
void main() {
  /*{{#use_auto_route}}x*/
  /*remove-start*/
  group('(with auto_route)', () {
    /*remove-end*/
    group('$CounterRoute', () {
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
    });
    /*remove-start*/
  });
  /*remove-end*/
  /*x{{/use_auto_route}}x*/

  /*x{{#use_go_router}}x*/
  /*remove-start*/
  group('(with go_router)', () {
    /*remove-end*/
    group('$CounterRouteData', () {
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
    });
    /*remove-start*/
  });
  /*remove-end*/
  /*x{{/use_go_router}}*/
}
