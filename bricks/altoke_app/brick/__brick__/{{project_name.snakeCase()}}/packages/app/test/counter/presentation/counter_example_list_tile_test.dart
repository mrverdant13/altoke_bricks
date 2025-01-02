import 'package:{{project_name.snakeCase()}}/counter/counter.dart';
import 'package:{{project_name.snakeCase()}}/routing/routing.dart';{{#use_auto_route}}import 'package:auto_route/auto_route.dart';{{/use_auto_route}}import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';{{#use_go_router}}import 'package:go_router/go_router.dart';{{/use_go_router}}import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  final localizationVariant = LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.counterExampleListTileTitle,
    partialCases: {
      const (
        Locale('en'),
        'Counter',
      ),
      const (
        Locale('es'),
        // cspell:disable-next-line
        'Contador',
      ),
    },
  );

  testExhaustiveLocalizationVariant(
    '''

GIVEN a localization variant
WHEN testing the counter example list tile
THEN all supported locales should be considered
''',
    localizationVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a counter example list tile
WHEN it is displayed
THEN the button should include the localized label
''',
    const Scaffold(
      body: CounterExampleListTile(),
    ),
    ancestorFinder: find.byType(ListTile),
    variant: localizationVariant,
  );

  setUpAll(registerFallbackValues);{{#use_auto_route}}testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the counter path
WHEN the app starts
THEN the counter screen should be shown
''',
    (tester) async {
      final stackRouter = MockStackRouter();
      when(() => stackRouter.navigate(any())).thenAnswer((_) async {});
      await tester.pumpAppWithScreen(StackRouterScope(
            controller: stackRouter,
            stateHash: 0,
            child: const Scaffold(
              body: CounterExampleListTile(),
            ),
          ),);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CounterExampleListTile));
      verify(() => stackRouter.navigate(const CounterRoute())).called(1);
    },
  );{{/use_auto_route}}{{#use_go_router}}testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the counter path
WHEN the app starts
THEN the counter screen should be shown
''',
    (tester) async {
      final goRouter = MockGoRouter();
      when(() => goRouter.go(any())).thenAnswer((_) async {});
      await tester.pumpAppWithScreen(InheritedGoRouter(
            goRouter: goRouter,
            child: const Scaffold(
              body: CounterExampleListTile(),
            ),
          ),);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CounterExampleListTile));
      verify(() => goRouter.go(const CounterRouteData().location)).called(1);
    },
  );{{/use_go_router}}
}