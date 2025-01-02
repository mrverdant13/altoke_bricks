import 'package:{{project_name.snakeCase()}}/app/app.dart';
import 'package:{{project_name.snakeCase()}}/flavors/flavors.dart';
import 'package:{{project_name.snakeCase()}}/routing/routing.dart';{{#use_auto_route}}import 'package:auto_route/auto_route.dart';{{/use_auto_route}}import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';{{#use_go_router}}import 'package:go_router/go_router.dart';{{/use_go_router}}void main() {
  setUp(() {
    debugFlavor = AppFlavor.dev;
  });

  tearDown(() {
    debugFlavor = null;
  });
{{#use_auto_route}}testWidgets(
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
            asyncInitializationPod.overrideWith((_) async {}),
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
  );{{/use_auto_route}}{{#use_go_router}}testWidgets(
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
            asyncInitializationPod.overrideWith((_) async {}),
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
  );{{/use_go_router}}
}