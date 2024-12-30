import 'package:{{projectName.snakeCase()}}/app/app.dart';
import 'package:{{projectName.snakeCase()}}/flavors/flavors.dart';
import 'package:{{projectName.snakeCase()}}/routing/routing.dart';{{/use_auto_route}}import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';{{#use_go_router}}import 'package:go_router/go_router.dart';{{/use_go_router}}void main() {
  setUp(() {
    debugFlavor = AppFlavor.dev;
  });

  tearDown(() {
    debugFlavor = null;
  });

  testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the home path
WHEN the app starts
THEN the home screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            asyncInitializationPod.overrideWith((_) async {}),
            routerConfigPod.overrideWithValue(
              GoRouter(
                routes: $appRoutes,
                initialLocation: '/',
              ),
            ),
          ],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();
      final homeScreenFinder = find.byType(HomeScreen);
      expect(homeScreenFinder, findsOneWidget);
    },
  );
}
