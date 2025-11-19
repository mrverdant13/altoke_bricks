import 'package:altoke_app/counter/state/counter_pod.dart';
/*remove-start*/
import 'package:altoke_app/external/external.dart';
/*remove-end*/
import 'package:altoke_app/routing/routing.dart';
/*remove-start*/
import 'package:altoke_app/tasks/tasks.dart';
/*remove-end*/
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

import '../../../helpers/helpers.dart';

@Dependencies([
  Counter,
  /*remove-start*/
  SelectedRouterPackage,
  SelectedLocalDatabasePackage,
  asyncTasks,
  localTasksDao,
  /*remove-end-x*/
])
void main() {
  /*{{#use_auto_route}}x*/
  /*remove-start*/
  group('(with auto_route)', () {
    /*remove-end*/
    group('$HomeRoute', () {
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
    });
    /*remove-start*/
  });
  /*remove-end*/
  /*x{{/use_auto_route}}x*/

  /*x{{#use_go_router}}x*/
  /*remove-start*/
  group('(with go_router)', () {
    /*remove-end*/
    group('$HomeRouteData', () {
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
    });
    /*remove-start*/
  });
  /*remove-end*/
  /*x{{/use_go_router}}x*/
}
