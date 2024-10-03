import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/routing/routing.dart';
/*{{#use_auto_route}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route}}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
/*{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
/*{{/use_go_router}}*/

void main() {
/*w 1v w*/
/*{{#use_auto_route}}*/
  testWidgets(
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
  );
/*{{/use_auto_route}}*/

/*{{#use_go_router}}*/
  testWidgets(
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
  );
/*{{/use_go_router}}*/
/*w 1v w*/
}
