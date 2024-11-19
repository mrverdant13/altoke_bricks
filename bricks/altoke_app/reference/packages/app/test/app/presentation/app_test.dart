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
        /*remove-start*/ // /*remove-end*/ const
        /*w 1v w*/
        ProviderScope(
          overrides: [
            asyncInitializationPod.overrideWith((_) async {}),
            /*remove-start*/
            routerPackagePod.overrideWithValue(RouterPackage.autoRoute),
            /*remove-end*/
          ],
          child:
              /*remove-start*/
              const
              /*remove-end*/
              MyApp(),
        ),
      );
      await tester.pumpAndSettle();
      final homeScreenFinder = find.byType(HomeScreen);
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
        /*remove-start*/ // /*remove-end*/ const
        /*w 1v w*/
        ProviderScope(
          overrides: [
            asyncInitializationPod.overrideWith((_) async {}),
            /*remove-start*/
            routerPackagePod.overrideWithValue(RouterPackage.goRouter),
            /*remove-end*/
          ],
          child:
              /*remove-start*/
              const
              /*remove-end*/
              MyApp(),
        ),
      );
      await tester.pumpAndSettle();
      final homeScreenFinder = find.byType(HomeScreen);
      expect(homeScreenFinder, findsOneWidget);
    },
  );
/*{{/use_go_router}}*/
/*w 1v w*/
}
