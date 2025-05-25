import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/flavors/flavors.dart';
import 'package:altoke_app/routing/routing.dart';
/*x{{#use_auto_route}}*/
import 'package:auto_route/auto_route.dart';
/*x{{/use_auto_route}}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
/*x{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
/*x{{/use_go_router}}*/

void main() {
  /*{{#use_auto_route}}x*/
  testWidgets(
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
          child: const MyApp(),
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
          child: const MyApp(),
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
              final asyncValue = ref.state;
              if (!asyncValue.isRefreshing) {
                throw Exception('error');
              }
            }),
            routerConfigPod.overrideWithValue(routerConfig),
          ],
          child: const MyApp(),
        ),
      );
      expect(find.byType(InitializingScreen), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(ErroredInitializationScreen), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.byType(InitializingScreen), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Fake Screen'), findsOneWidget);
    },
  );

  /*x{{/use_auto_route}}x*/

  /*x{{#use_go_router}}x*/
  testWidgets(
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
          child: const MyApp(),
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
          child: const MyApp(),
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
              final asyncValue = ref.state;
              if (!asyncValue.isRefreshing) {
                throw Exception('error');
              }
            }),
            routerConfigPod.overrideWithValue(routerConfig),
          ],
          child: const MyApp(),
        ),
      );
      expect(find.byType(InitializingScreen), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(ErroredInitializationScreen), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.byType(InitializingScreen), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Fake Screen'), findsOneWidget);
    },
  );
  /*x{{/use_go_router}}*/
}
