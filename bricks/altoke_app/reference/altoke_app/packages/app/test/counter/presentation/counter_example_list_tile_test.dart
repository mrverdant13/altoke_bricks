import 'package:altoke_app/counter/counter.dart';
import 'package:altoke_app/routing/routing.dart';
/*x{{#use_auto_route}}*/
import 'package:auto_route/auto_route.dart';
/*x{{/use_auto_route}}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
/*x{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
/*x{{/use_go_router}}*/
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

import '../../helpers/helpers.dart';

@Dependencies([
  /*remove-start*/
  SelectedRouterPackage,
  /*remove-end-x*/
  Counter,
])
void main() {
  testWidgets(
    '''

GIVEN a counter example list tile
WHEN it is displayed
THEN the button should include the localized label
''',
    (tester) async {
      await tester.pumpAppWithScreen(
        const Scaffold(body: CounterExampleListTile()),
      );
      expect(
        find.l10n.widgetWithText(
          ListTile,
          (l10n) => l10n.counterExampleListTileTitle,
        ),
        findsOneWidget,
      );
    },
  );

  setUpAll(registerFallbackValues);

  /*{{#use_auto_route}}x*/
  testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the counter path
WHEN the app starts
THEN the counter screen should be shown
''',
    (tester) async {
      final stackRouter = MockStackRouter();
      when(() => stackRouter.navigate(any())).thenAnswer((_) async {});
      await tester.pumpAppWithScreen(
        /*remove-start*/
        ProviderScope(
          overrides: [
            selectedRouterPackagePod.overrideWith(
              () => FakeSelectedRouterPackage(
                initialValue: RouterPackage.autoRoute,
              ),
            ),
          ],
          child: /*remove-end-x*/ StackRouterScope(
            controller: stackRouter,
            stateHash: 0,
            child: const Scaffold(body: CounterExampleListTile()),
            /*x-remove-start*/
          ),
          /*remove-end*/
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CounterExampleListTile));
      verify(() => stackRouter.navigate(const CounterRoute())).called(1);
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
      final goRouter = MockGoRouter();
      when(() => goRouter.go(any())).thenAnswer((_) async {});
      await tester.pumpAppWithScreen(
        /*remove-start*/
        ProviderScope(
          overrides: [
            selectedRouterPackagePod.overrideWith(
              () => FakeSelectedRouterPackage(
                initialValue: RouterPackage.goRouter,
              ),
            ),
          ],
          child: /*remove-end-x*/ InheritedGoRouter(
            goRouter: goRouter,
            child: const Scaffold(body: CounterExampleListTile()),
            /*x-remove-start*/
          ),
          /*remove-end*/
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CounterExampleListTile));
      verify(() => goRouter.go(const CounterRouteData().location)).called(1);
    },
  );
  /*x{{/use_go_router}}*/
}
