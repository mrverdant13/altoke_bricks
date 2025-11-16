import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';{{#use_auto_route}}
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';{{/use_auto_route}}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';{{#use_go_router}}
import 'package:go_router/go_router.dart';{{/use_go_router}}
import 'package:path/path.dart' as path;
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../helpers/helpers.dart';

@Dependencies([
  routerConfig,
  Counter,
  ])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  {{#use_auto_route}}test(
    '''

GIVEN a router config pod
WHEN the pod is built
THEN the config is injected
''',
    () {
      final container = ProviderContainer();
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
        deepLinkBuilder: (_) => DeepLink.path(path.joinAll(['/'])),
      );
      await tester.pumpRoutedApp(
        overrides: [routerConfigPod.overrideWithValue(config)],
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
        deepLinkBuilder: (_) => DeepLink.path(path.joinAll(['/', 'counter'])),
      );
      await tester.pumpRoutedApp(
        overrides: [routerConfigPod.overrideWithValue(config)],
      );
      await tester.pumpAndSettle();
      expect(find.byType(CounterScreen), findsOneWidget);
    },
  );{{/use_auto_route}}{{#use_go_router}}test(
    '''

GIVEN a router config pod
WHEN the pod is built
THEN the config is injected
''',
    () {
      final container = ProviderContainer();
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
        initialLocation: path.joinAll(['/']),
      );
      addTearDown(router.dispose);
      final config = router;
      await tester.pumpRoutedApp(
        overrides: [routerConfigPod.overrideWithValue(config)],
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
        initialLocation: path.joinAll(['/', 'counter']),
      );
      addTearDown(router.dispose);
      final config = router;
      await tester.pumpRoutedApp(
        overrides: [routerConfigPod.overrideWithValue(config)],
      );
      await tester.pumpAndSettle();
      expect(find.byType(CounterScreen), findsOneWidget);
    },
  );{{/use_go_router}}
}
