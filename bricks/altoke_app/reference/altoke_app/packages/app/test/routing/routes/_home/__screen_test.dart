import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/flavors/flavors.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
/*x{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
/*x{{/use_go_router}}*/

void main() {
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
            /*x-remove-start*/
            routerConfigPod.overrideWithValue(
              GoRouter(routes: $appRoutes, initialLocation: '/'),
            ),
            /*remove-end*/
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
