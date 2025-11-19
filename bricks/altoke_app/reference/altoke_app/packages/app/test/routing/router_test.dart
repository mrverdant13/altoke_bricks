/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end*/
import 'package:altoke_app/counter/counter.dart';
/*remove-start*/
import 'package:altoke_app/external/external.dart';
/*remove-end-x*/
import 'package:altoke_app/routing/routing.dart';
/*remove-start*/
import 'package:altoke_app/tasks/tasks.dart';
/*remove-end*/
/*x{{#use_auto_route}}*/
import 'package:auto_route/auto_route.dart';
/*x{{/use_auto_route}}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
/*x{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
/*x{{/use_go_router}}*/
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/experimental/scope.dart';

import '../helpers/helpers.dart';

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
  TestWidgetsFlutterBinding.ensureInitialized();

  /*{{#use_auto_route}}x*/
  group('$AppRouter', () {
    test(
      'defaultRouteType is $AdaptiveRouteType',
      () {
        final router = AppRouter();
        addTearDown(router.dispose);
        expect(router.defaultRouteType, isA<AdaptiveRouteType>());
      },
    );

    testWidgets(
      '["/"] path mounts the $HomeRoute',
      (tester) async {
        await tester.pumpAutoRouteAppWithInitialPath(
          p.joinAll([
            '/',
          ]),
        );
        final routerDelegate = tester.autoRouterDelegate;
        expect(
          routerDelegate.controller.topRoute.name,
          HomeRoute.name,
        );
      },
    );

    testWidgets(
      '["/", "counter"] path mounts the $CounterRoute',
      (tester) async {
        await tester.pumpAutoRouteAppWithInitialPath(
          p.joinAll([
            '/',
            'counter',
          ]),
        );
        final routerDelegate = tester.autoRouterDelegate;
        expect(
          routerDelegate.controller.topRoute.name,
          CounterRoute.name,
        );
      },
    );

    /*remove-start*/
    testWidgets(
      '["/", "tasks"] path mounts the $TasksRoute',
      (tester) async {
        await tester.pumpAutoRouteAppWithInitialPath(
          '/tasks',
          wrapper: (child) => ProviderScope(
            overrides: [
              asyncTasksPod.overrideWith((ref) => Stream.value([])),
            ],
            child: child,
          ),
        );
        final routerDelegate = tester.autoRouterDelegate;
        expect(
          routerDelegate.controller.topRoute.name,
          TasksRoute.name,
        );
      },
    );
    /*remove-end*/
  });
  /*x{{/use_auto_route}}x*/

  /*x{{#use_go_router}}x*/
  group('$GoRouter', () {
    testWidgets(
      '["/"] path mounts the $HomeRouteData',
      (tester) async {
        await tester.pumpGoRouterAppWithInitialPath(
          p.joinAll([
            '/',
          ]),
        );
        final routerDelegate = tester.goRouterDelegate;
        expect(
          routerDelegate.state.name,
          HomeRouteData.name,
        );
      },
    );

    testWidgets(
      '["/", "counter"] path mounts the $CounterRouteData',
      (tester) async {
        await tester.pumpGoRouterAppWithInitialPath(
          p.joinAll([
            '/',
            'counter',
          ]),
        );
        final routerDelegate = tester.goRouterDelegate;
        expect(
          routerDelegate.state.name,
          CounterRouteData.name,
        );
      },
    );

    /*remove-start*/
    testWidgets(
      '["/", "tasks"] path mounts the $TasksRouteData',
      (tester) async {
        await tester.pumpGoRouterAppWithInitialPath(
          p.joinAll([
            '/',
            'tasks',
          ]),
          wrapper: (child) => ProviderScope(
            overrides: [
              asyncTasksPod.overrideWith((ref) => Stream.value([])),
            ],
            child: child,
          ),
        );
        final routerDelegate = tester.goRouterDelegate;
        expect(
          routerDelegate.state.name,
          TasksRouteData.name,
        );
      },
    );
    /*remove-end*/
  });
  /*x{{/use_go_router}}*/
}
