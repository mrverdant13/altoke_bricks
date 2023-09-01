import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
/*w 1v w*/
/*{{#use_auto_route_router}}*/
  testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the home path
WHEN the app starts
THEN the home screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        MyApp(
          routerConfig: AppRouter().config(
            deepLinkBuilder: (_) => DeepLink.path('/'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final homeScreenFinder = find.byType(HomeScreen);
      expect(homeScreenFinder, findsOneWidget);
    },
  );
/*{{/use_auto_route_router}}*/

/*{{#use_go_router_router}}*/
  testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the home path
WHEN the app starts
THEN the home screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        MyApp(
          routerConfig: GoRouter(
            routes: $appRoutes,
            initialLocation: '/',
          ),
        ),
      );
      await tester.pumpAndSettle();
      final homeScreenFinder = find.byType(HomeScreen);
      expect(homeScreenFinder, findsOneWidget);
    },
  );
/*{{/use_go_router_router}}*/
}
