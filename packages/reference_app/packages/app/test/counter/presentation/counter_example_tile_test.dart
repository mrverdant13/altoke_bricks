import 'package:altoke_app/counter/counter.dart';
import 'package:altoke_app/routing/routing.dart';
/*{{#use_auto_route_router}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route_router}}*/
import 'package:flutter/material.dart';
/*remove-start*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
/*remove-end*/
import 'package:flutter_test/flutter_test.dart';
/*{{#use_go_router_router}}*/
import 'package:go_router/go_router.dart';
/*{{/use_go_router_router}}*/
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  final localizationVariant = LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.counterExampleLabel,
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
WHEN testing the counter example tile
THEN all supported locales should be considered
''',
    localizationVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a counter example tile
WHEN it is displayed
THEN the tile should include the localized label
''',
    const Scaffold(
      body: CounterExampleTile(),
    ),
    ancestorFinder: find.byKey(
      const Key(
        '<counter::example-tile::title>',
      ),
    ),
    variant: localizationVariant,
  );

/*{{#use_auto_route_router}}*/
  testWidgets(
    '''

GIVEN a counter example tile
AND an injected routing controller
WHEN the tile is tapped
THEN the counter route should be visited
''',
    (tester) async {
      registerFallbackValues();
      final routingController = MockRoutingController();
      when(() => routingController.navigate(any()))
          .thenAnswer((_) async => null);
      await tester.pumpTestableWidget(
        /*remove-start*/ ProviderScope(
          overrides: [
            routerPod.overrideWithValue(RouterPackage.autoRoute),
          ],
          child: /*remove-end*/ RouterScope(
            controller: routingController,
            inheritableObserversBuilder: () => [],
            stateHash: 0,
            child: const Scaffold(
              body: CounterExampleTile(),
            ),
          ), /*remove-start*/
        ), /*remove-end*/
      );
      final counterExampleTileFinder = find.byType(CounterExampleTile);
      await tester.tap(counterExampleTileFinder);
      verify(() => routingController.navigate(const CounterRoute())).called(1);
      verifyNoMoreInteractions(routingController);
    },
  );
/*{{/use_auto_route_router}}*/

/*{{#use_go_router_router}}*/
  testWidgets(
    '''

GIVEN a counter example tile
AND an injected router
WHEN the tile is tapped
THEN the counter route should be visited
''',
    (tester) async {
      registerFallbackValues();
      final goRouter = MockGoRouter();
      when(() => goRouter.go(any())).thenAnswer((_) async {});
      await tester.pumpTestableWidget(
        /*remove-start*/ ProviderScope(
          overrides: [
            routerPod.overrideWithValue(RouterPackage.goRouter),
          ],
          child: /*remove-end*/ InheritedGoRouter(
            goRouter: goRouter,
            child: const Scaffold(
              body: CounterExampleTile(),
            ),
          ), /*remove-start*/
        ), /*remove-end*/
      );
      final counterExampleTileFinder = find.byType(CounterExampleTile);
      await tester.tap(counterExampleTileFinder);
      verify(() => goRouter.go(const CounterRouteData().location)).called(1);
      verifyNoMoreInteractions(goRouter);
    },
  );
/*{{/use_go_router_router}}*/
/*w 1v w*/
}
