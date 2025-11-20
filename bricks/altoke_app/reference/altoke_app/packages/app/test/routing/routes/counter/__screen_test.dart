/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end*/
/*x{{#use_riverpod}}x*/
import 'package:altoke_app/counter/counter.dart';
/*x{{/use_riverpod}}x*/
import 'package:altoke_app/routing/routing.dart';
import 'package:flutter_test/flutter_test.dart';
/*x{{#use_riverpod}}x*/
import 'package:riverpod_annotation/experimental/scope.dart';

/*x{{/use_riverpod}}x*/

import '../../../helpers/helpers.dart';

@Dependencies([
  Counter,
  /*remove-start*/
  SelectedStateManagementPackage,
  /*remove-end*/
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
