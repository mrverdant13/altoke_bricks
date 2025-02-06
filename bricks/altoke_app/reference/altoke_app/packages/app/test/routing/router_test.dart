import 'package:altoke_app/routing/routing.dart';
/*remove-start*/
import 'package:altoke_app/tasks/tasks.dart';
/*remove-end*/
/*{{#use_auto_route}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route}}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
/*{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
/*{{/use_go_router}}*/
import 'package:path/path.dart' as path;

import '../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

/*w 1v w*/
/*{{#use_auto_route}}*/
  test(
    '''

GIVEN a router config pod
WHEN the pod is built
THEN the config is injected
''',
    () {
      final container = ProviderContainer(
        /*remove-start*/
        overrides: [
          selectedRouterPackagePod.overrideWith(
            () => FakeSelectedRouterPackage(
              initialValue: RouterPackage.autoRoute,
            ),
          ),
        ],
        /*remove-end*/
      );
      addTearDown(container.dispose);
      final routerConfig = container.read(routerConfigPod);
      expect(routerConfig, isA<RouterConfig<UrlState>>());
    },
  );

  test(
    '''

GIVEN a router
WHEN the router is built
THEN the router uses an adaptive route type
''',
    () {
      final router = AppRouter();
      addTearDown(router.dispose);
      expect(router.defaultRouteType, isA<AdaptiveRouteType>());
    },
  );

  testWidgets(
    '''
GIVEN a router
WHEN the ["/"] path is visited
THEN the home screen should be shown
''',
    (tester) async {
      final router = AppRouter();
      addTearDown(router.dispose);
      final config = router.config(
        deepLinkBuilder: (_) => DeepLink.path(
          path.joinAll([
            '/',
          ]),
        ),
      );
      await tester.pumpRoutedApp(
        overrides: [
          routerConfigPod.overrideWithValue(config),
        ],
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    },
  );

  testWidgets(
    '''
GIVEN a router
WHEN the ["/", "counter"] path is visited
THEN the counter screen should be shown
''',
    (tester) async {
      final router = AppRouter();
      addTearDown(router.dispose);
      final config = router.config(
        deepLinkBuilder: (_) => DeepLink.path(
          path.joinAll([
            '/',
            'counter',
          ]),
        ),
      );
      await tester.pumpRoutedApp(
        overrides: [
          routerConfigPod.overrideWithValue(config),
        ],
      );
      await tester.pumpAndSettle();
      expect(find.byType(CounterScreen), findsOneWidget);
    },
  );

  /*remove-start*/
  testWidgets(
    '''
GIVEN a router
WHEN the ["/", "tasks"] path is visited
THEN the tasks screen should be shown
''',
    (tester) async {
      final router = AppRouter();
      addTearDown(router.dispose);
      final config = router.config(
        deepLinkBuilder: (_) => DeepLink.path(
          path.joinAll([
            '/',
            'tasks',
          ]),
        ),
      );
      await tester.pumpRoutedApp(
        overrides: [
          routerConfigPod.overrideWithValue(config),
          asyncTasksPod.overrideWith((ref) => Stream.value([])),
        ],
      );
      await tester.pumpAndSettle();
      expect(find.byType(TasksScreen), findsOneWidget);
    },
  );
  /*remove-end*/
/*{{/use_auto_route}}*/
/*{{#use_go_router}}*/
  test(
    '''

GIVEN a router config pod
WHEN the pod is built
THEN the config is injected
''',
    () {
      final container = ProviderContainer(
        /*remove-start*/
        overrides: [
          selectedRouterPackagePod.overrideWith(
            () => FakeSelectedRouterPackage(
              initialValue: RouterPackage.goRouter,
            ),
          ),
        ],
        /*remove-end*/
      );
      addTearDown(container.dispose);
      final routerConfig = container.read(routerConfigPod);
      expect(routerConfig, isA<GoRouter>());
    },
  );

  testWidgets(
    '''
GIVEN a router
WHEN the ["/"] path is visited
THEN the home screen should be shown
''',
    (tester) async {
      final router = GoRouter(
        routes: $appRoutes,
        initialLocation: path.joinAll([
          '/',
        ]),
      );
      addTearDown(router.dispose);
      final config = router;
      await tester.pumpRoutedApp(
        overrides: [
          routerConfigPod.overrideWithValue(config),
        ],
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    },
  );

  testWidgets(
    '''
GIVEN a router
WHEN the ["/", "counter"] path is visited
THEN the counter screen should be shown
''',
    (tester) async {
      final router = GoRouter(
        routes: $appRoutes,
        initialLocation: path.joinAll([
          '/',
          'counter',
        ]),
      );
      addTearDown(router.dispose);
      final config = router;
      await tester.pumpRoutedApp(
        overrides: [
          routerConfigPod.overrideWithValue(config),
        ],
      );
      await tester.pumpAndSettle();
      expect(find.byType(CounterScreen), findsOneWidget);
    },
  );

  /*remove-start*/
  testWidgets(
    '''
GIVEN a router
WHEN the ["/", "tasks"] path is visited
THEN the tasks screen should be shown
''',
    (tester) async {
      final router = GoRouter(
        routes: $appRoutes,
        initialLocation: path.joinAll([
          '/',
          'tasks',
        ]),
      );
      addTearDown(router.dispose);
      final config = router;
      await tester.pumpRoutedApp(
        overrides: [
          routerConfigPod.overrideWithValue(config),
          asyncTasksPod.overrideWith((ref) => Stream.value([])),
        ],
      );
      await tester.pumpAndSettle();
      expect(find.byType(TasksScreen), findsOneWidget);
    },
  );
  /*remove-end*/
/*{{/use_go_router}}*/
/*w 1v w*/
}
