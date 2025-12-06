/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end*/
/*x{{#use_riverpod}}x*/
import 'package:altoke_app/counter/counter.dart';
/*x{{/use_riverpod}}x*/
/*remove-start*/
import 'package:altoke_app/external/external.dart';
/*remove-end*/
import 'package:altoke_app/routing/routing.dart';
/*remove-start*/
import 'package:altoke_app/tasks/tasks.dart';
/*remove-end*/
import 'package:flutter_test/flutter_test.dart';
/*x{{#use_riverpod}}x*/
import 'package:riverpod_annotation/experimental/scope.dart';

/*x{{/use_riverpod}}x*/

import '../../../helpers/helpers.dart';

@Dependencies([
  Counter,
  /*remove-start*/
  asyncTasks,
  localTasksDao,
  SelectedLocalDatabasePackage,
  SelectedRouterPackage,
  SelectedStateManagementPackage,
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
