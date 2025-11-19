// Allow non-const constructors for testing
// ignore_for_file: prefer_const_constructors

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
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([
  /*remove-start*/
  SelectedRouterPackage,
  /*remove-end-x*/
  asyncInitialization,
])
void main() {
  /*{{#use_auto_route}}x*/
  /*remove-start*/
  group('(using auto_route)', () {
    /*remove-end*/
    late RootStackRouter router;

    setUp(() {
      debugFlavor = AppFlavor.dev;
      router = RootStackRouter.build(
        routes: [
          AutoRoute(
            path: '/',
            page: PageInfo(
              'FakeRoute',
              builder: (data) => const Scaffold(
                body: Center(
                  child: Text('Fake Screen'),
                ),
              ),
            ),
          ),
        ],
      );
    });

    tearDown(() {
      router.dispose();
      debugFlavor = null;
    });

    @Dependencies([
      asyncInitialization,
      /*x-remove-start*/
      SelectedRouterPackage,
      /*remove-end*/
    ])
    Widget buildSubjectApp() {
      return MyApp(
        routerConfig: router.config(),
      );
    }

    testWidgets(
      '''

GIVEN an app
WHEN the app is built
THEN the flavor banner should be displayed
''',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              asyncInitializationPod.overrideWith((_) async {}),
            ],
            child: buildSubjectApp(),
          ),
        );
        expect(find.byType(FlavorBanner), findsOneWidget);
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
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              asyncInitializationPod.overrideWith((_) async {}),
            ],
            child: buildSubjectApp(),
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
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              asyncInitializationPod.overrideWith((ref) async {
                if (!ref.isRefresh) {
                  throw Exception('error');
                }
              }),
            ],
            child: buildSubjectApp(),
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
    );
    /*remove-start*/
  });
  /*remove-end*/
  /*x{{/use_auto_route}}x*/

  /*x{{#use_go_router}}x*/
  /*remove-start*/
  group('(using go_router)', () {
    /*remove-end*/
    late GoRouter router;

    setUp(() {
      debugFlavor = AppFlavor.dev;
      router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            name: 'FakeRoute',
            builder: (context, state) => Scaffold(
              body: Center(
                child: Text('Fake Screen'),
              ),
            ),
          ),
        ],
      );
    });

    tearDown(() {
      router.dispose();
      debugFlavor = null;
    });

    @Dependencies([
      asyncInitialization,
      /*x-remove-start*/
      SelectedRouterPackage,
      /*remove-end*/
    ])
    Widget buildSubjectApp() {
      return MyApp(
        routerConfig: router,
      );
    }

    testWidgets(
      '''

GIVEN an app
WHEN the app is built
THEN the flavor banner should be displayed
''',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              asyncInitializationPod.overrideWith((_) async {}),
            ],
            child: buildSubjectApp(),
          ),
        );
        expect(find.byType(FlavorBanner), findsOneWidget);
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
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              asyncInitializationPod.overrideWith((_) async {}),
            ],
            child: buildSubjectApp(),
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
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              asyncInitializationPod.overrideWith((ref) async {
                if (!ref.isRefresh) {
                  throw Exception('error');
                }
              }),
            ],
            child: buildSubjectApp(),
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
    );
    /*remove-start*/
  });
  /*remove-end*/
  /*x{{/use_go_router}}*/
}
