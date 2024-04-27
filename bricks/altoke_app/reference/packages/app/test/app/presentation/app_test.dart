import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
/*w 1v w*/
/*{{#use_auto_route}}*/
  testWidgets(
    '''

GIVEN an app
AND an app router
WHEN the app is built
THEN the counter screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          /*remove-start*/
          overrides: [
            routerPackagePod.overrideWithValue(RouterPackage.autoRoute),
          ],
          /*remove-end*/
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();
      final homeScreenFinder = find.byType(CounterScreen);
      expect(homeScreenFinder, findsOneWidget);
    },
  );
/*{{/use_auto_route}}*/

/*{{#use_go_router}}*/
  testWidgets(
    '''

GIVEN an app
AND an app router
WHEN the app is built
THEN the counter screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          /*remove-start*/
          overrides: [
            routerPackagePod.overrideWithValue(RouterPackage.goRouter),
          ],
          /*remove-end*/
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();
      final homeScreenFinder = find.byType(CounterScreen);
      expect(homeScreenFinder, findsOneWidget);
    },
  );
/*{{/use_go_router}}*/
/*w 1v w*/
}
