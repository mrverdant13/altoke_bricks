import 'package:{{project_name.snakeCase()}}/app/app.dart';
import 'package:{{project_name.snakeCase()}}/routing/routing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
{{#use_auto_route_router}}testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the counter path
WHEN the app starts
THEN the counter screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        MyApp(
          routerConfig: AppRouter().config(
            deepLinkBuilder: (_) => const DeepLink.path('/counter'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final counterScreenFinder = find.byType(CounterScreen);
      expect(counterScreenFinder, findsOneWidget);
    },
  );

  testWidgets(
    '''

GIVEN a counter screen
├─ THAT starts with a counter value of 0
WHEN the increment button is tapped
THEN the counter value should be 1
''',
    (tester) async {
      await tester.pumpWidget(
        MyApp(
          routerConfig: AppRouter().config(
            deepLinkBuilder: (_) => const DeepLink.path('/counter'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing);
      final incrementButtonFinder = find.byType(FloatingActionButton);
      await tester.tap(incrementButtonFinder);
      await tester.pump();
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsOneWidget);
    },
  );{{/use_auto_route_router}}{{#use_go_router_router}}testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the counter path
WHEN the app starts
THEN the counter screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        MyApp(
          routerConfig: GoRouter(
            routes: $appRoutes,
            initialLocation: '/counter',
          ),
        ),
      );
      await tester.pumpAndSettle();
      final counterScreenFinder = find.byType(CounterScreen);
      expect(counterScreenFinder, findsOneWidget);
    },
  );

  testWidgets(
    '''

GIVEN a counter screen
├─ THAT starts with a counter value of 0
WHEN the increment button is tapped
THEN the counter value should be 1
''',
    (tester) async {
      await tester.pumpWidget(
        MyApp(
          routerConfig: GoRouter(
            routes: $appRoutes,
            initialLocation: '/counter',
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing);
      final incrementButtonFinder = find.byType(FloatingActionButton);
      await tester.tap(incrementButtonFinder);
      await tester.pump();
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsOneWidget);
    },
  );{{/use_go_router_router}}}
