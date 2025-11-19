import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';{{#use_auto_route}}
import 'package:auto_route/auto_route.dart';{{/use_auto_route}}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';{{#use_go_router}}
import 'package:go_router/go_router.dart';{{/use_go_router}}
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/experimental/scope.dart';

import '../helpers/helpers.dart';

@Dependencies([
  Counter,
  ])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  {{#use_auto_route}}group('$AppRouter', () {
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

    
  });{{/use_auto_route}}{{#use_go_router}}group('$GoRouter', () {
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

    
  });{{/use_go_router}}
}
