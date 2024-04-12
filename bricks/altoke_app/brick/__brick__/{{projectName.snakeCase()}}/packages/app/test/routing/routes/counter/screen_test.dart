import 'package:{{projectName.snakeCase()}}/app/app.dart';
import 'package:{{projectName.snakeCase()}}/routing/routing.dart';{{#use_auto_route_router}}import 'package:auto_route/auto_route.dart';{{/use_auto_route_router}}import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';{{#use_go_router_router}}import 'package:go_router/go_router.dart';{{/use_go_router_router}}void main() {
{{#use_auto_route_router}}testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the counter path
WHEN the app starts
THEN the counter screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            routerConfigPod.overrideWithValue(
              AppRouter().config(
                deepLinkBuilder: (_) => const DeepLink.path('/counter'),
              ),
            ),
          ],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();
      final counterScreenFinder = find.byType(CounterScreen);
      expect(counterScreenFinder, findsOneWidget);
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
        ProviderScope(
          overrides: [
            routerConfigPod.overrideWithValue(
              GoRouter(
                routes: $appRoutes,
                initialLocation: '/counter',
              ),
            ),
          ],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();
      final counterScreenFinder = find.byType(CounterScreen);
      expect(counterScreenFinder, findsOneWidget);
    },
  );{{/use_go_router_router}}
}
