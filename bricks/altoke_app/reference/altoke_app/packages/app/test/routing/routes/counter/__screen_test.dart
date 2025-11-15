import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/counter/counter.dart';
import 'package:altoke_app/flavors/flavors.dart';
import 'package:altoke_app/routing/routing.dart';
/*x{{#use_auto_route}}*/
import 'package:auto_route/auto_route.dart';
/*x{{/use_auto_route}}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
/*x{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
/*x{{/use_go_router}}*/

@Dependencies([
  /*remove-start*/
  SelectedRouterPackage,
  /*remove-end-x*/
  Counter,
])
void main() {
  setUp(() {
    debugFlavor = AppFlavor.dev;
  });

  tearDown(() {
    debugFlavor = null;
  });

  /*{{#use_auto_route}}x*/
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
  );
  /*x{{/use_auto_route}}x*/

  /*x{{#use_go_router}}x*/
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
            asyncInitializationPod.overrideWith((_) async {}),
            routerConfigPod.overrideWithValue(
              GoRouter(routes: $appRoutes, initialLocation: '/counter'),
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
  /*x{{/use_go_router}}*/
}
