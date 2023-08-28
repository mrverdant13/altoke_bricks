import 'package:{{project_name.snakeCase()}}/home/home.dart';
import 'package:{{project_name.snakeCase()}}/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets(
    '''

GIVEN a counter example tile
AND an injected routing controller
WHEN the tile is tapped
THEN the counter route should be visited
''',
    (tester) async {
      registerRoutingFallbackValues();
      final routingController = MockRoutingController();
      when(() => routingController.navigate(any()))
          .thenAnswer((_) async => null);
      await tester.pumpRoutedAppWithTestableWidget(
        routingController: routingController,
        testableWidget: Scaffold(
          body: CounterExampleTile(),
        ),
      );
      final counterExampleTileFinder = find.byType(CounterExampleTile);
      await tester.tap(counterExampleTileFinder);
      verify(() => routingController.navigate(CounterRoute())).called(1);
      verifyNoMoreInteractions(routingController);
    },
  );
}
