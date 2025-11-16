// Allow non-const constructors for testing
// ignore_for_file: prefer_const_constructors

import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/app/app.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/flavors/flavors.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';{{#use_auto_route}}
import 'package:auto_route/auto_route.dart';{{/use_auto_route}}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';{{#use_go_router}}
import 'package:go_router/go_router.dart';{{/use_go_router}}
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([
  asyncInitialization,
])
void main() {
  {{#use_auto_route}}testWidgets(
    '''

GIVEN an app
WHEN the app is built
THEN the flavor banner should be displayed
''',
    (tester) async {
      debugFlavor = AppFlavor.dev;
      addTearDown(() => debugFlavor = null);
      final router = AppRouter(
        testRoutes: [
          AutoRoute(
            path: '/',
            page: PageInfo(
              'FakeRoute',
              builder: (data) =>
                  const Scaffold(body: Center(child: Text('Fake Screen'))),
            ),
          ),
        ],
      );
      addTearDown(router.dispose);
      final routerConfig = router.config();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            asyncInitializationPod.overrideWith((_) async {}),
            routerConfigPod.overrideWithValue(routerConfig),
          ],
          child: MyApp(),
        ),
      );
      expect(find.byType(FlavorBanner), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Fake Screen'), findsOneWidget);
    },
  );

  testWidgets(
    '''

GIVEN an app
WHEN the app is built
AND the initialization process is completed
THEN the initialized router content should be shown
''',
    (tester) async {
      debugFlavor = AppFlavor.dev;
      addTearDown(() => debugFlavor = null);
      final router = AppRouter(
        testRoutes: [
          AutoRoute(
            path: '/',
            page: PageInfo(
              'FakeRoute',
              builder: (data) =>
                  const Scaffold(body: Center(child: Text('Fake Screen'))),
            ),
          ),
        ],
      );
      addTearDown(router.dispose);
      final routerConfig = router.config();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            asyncInitializationPod.overrideWith((_) async {}),
            routerConfigPod.overrideWithValue(routerConfig),
          ],
          child: MyApp(),
        ),
      );
      expect(find.byType(InitializingScreen), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Fake Screen'), findsOneWidget);
    },
  );

  testWidgets(
    '''

GIVEN an app
WHEN the app is built
AND the initialization process fails
THEN the errored initialization screen should be shown
├─ THAT allows the user to retry the initialization process
''',
    (tester) async {
      debugFlavor = AppFlavor.dev;
      addTearDown(() => debugFlavor = null);
      final router = AppRouter(
        testRoutes: [
          AutoRoute(
            path: '/',
            page: PageInfo(
              'FakeRoute',
              builder: (data) =>
                  const Scaffold(body: Center(child: Text('Fake Screen'))),
            ),
          ),
        ],
      );
      addTearDown(router.dispose);
      final routerConfig = router.config();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            asyncInitializationPod.overrideWith((ref) async {
              if (!ref.isRefresh) {
                throw Exception('error');
              }
            }),
            routerConfigPod.overrideWithValue(routerConfig),
          ],
          child: MyApp(),
        ),
      );
      expect(find.byType(InitializingScreen), findsOneWidget);
      await tester.pump();
      expect(find.byType(ErroredInitializationScreen), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.byType(InitializingScreen), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Fake Screen'), findsOneWidget);
    },
    skip: true, // Riverpod 3.0 behaves differently in test mode
  );{{/use_auto_route}}{{#use_go_router}}testWidgets(
    '''

GIVEN an app
WHEN the app is built
THEN the flavor banner should be displayed
''',
    (tester) async {
      debugFlavor = AppFlavor.dev;
      addTearDown(() => debugFlavor = null);
      final routerConfig = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            name: 'FakeRoute',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Fake Screen'))),
          ),
        ],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            asyncInitializationPod.overrideWith((_) async {}),
            routerConfigPod.overrideWithValue(routerConfig),
          ],
          child: MyApp(),
        ),
      );
      expect(find.byType(FlavorBanner), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Fake Screen'), findsOneWidget);
    },
  );

  testWidgets(
    '''

GIVEN an app
WHEN the app is built
AND the initialization process is completed
THEN the initialized router content should be shown
''',
    (tester) async {
      debugFlavor = AppFlavor.dev;
      addTearDown(() => debugFlavor = null);
      final routerConfig = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            name: 'FakeRoute',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Fake Screen'))),
          ),
        ],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            asyncInitializationPod.overrideWith((_) async {}),
            routerConfigPod.overrideWithValue(routerConfig),
          ],
          child: MyApp(),
        ),
      );
      expect(find.byType(InitializingScreen), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Fake Screen'), findsOneWidget);
    },
  );

  testWidgets(
    '''

  GIVEN an app
  WHEN the app is built
  AND the initialization process fails
  THEN the errored initialization screen should be shown
  ├─ THAT allows the user to retry the initialization process
  ''',
    (tester) async {
      debugFlavor = AppFlavor.dev;
      addTearDown(() => debugFlavor = null);
      final routerConfig = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            name: 'FakeRoute',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Fake Screen'))),
          ),
        ],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            asyncInitializationPod.overrideWith((ref) async {
              if (!ref.isRefresh) {
                throw Exception('error');
              }
            }),
            routerConfigPod.overrideWithValue(routerConfig),
          ],
          child: MyApp(),
        ),
      );
      expect(find.byType(InitializingScreen), findsOneWidget);
      await tester.pump();
      expect(find.byType(ErroredInitializationScreen), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.byType(InitializingScreen), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Fake Screen'), findsOneWidget);
    },
    skip: true, // Riverpod 3.0 behaves differently in test mode
  );{{/use_go_router}}
}
