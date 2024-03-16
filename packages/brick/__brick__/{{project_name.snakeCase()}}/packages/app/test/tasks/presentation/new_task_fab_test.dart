import 'package:{{project_name.snakeCase()}}/routing/routing.dart';
import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';{{#use_auto_route_router}}import 'package:auto_route/auto_route.dart';{{/use_auto_route_router}}import 'package:flutter/material.dart';import 'package:flutter_test/flutter_test.dart';{{#use_go_router_router}}import 'package:go_router/go_router.dart';{{/use_go_router_router}}import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  registerFallbackValues();

  final tooltipLocalizationVariant = LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.tasksNewTaskButtonTooltip,
    partialCases: {
      const (
        Locale('en'),
        'Create task',
      ),
      const (
        Locale('es'),
        // cspell:disable-next-line
        'Crear tarea',
      ),
    },
  );

  testExhaustiveLocalizationVariant(
    '''

GIVEN a tooltip localization variant
WHEN testing the new task fab
THEN all supported locales should be considered
''',
    tooltipLocalizationVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a new task fab
WHEN it is displayed
THEN the fab should include the localized tooltip
''',
    const NewTaskFab(),
    postPumpAction: (tester) async {
      final tooltipFinder = find.byType(Tooltip);
      await tester.longPress(tooltipFinder);
      await tester.pumpAndSettle();
    },
    ancestorFinder: find.byType(Overlay),
    variant: tooltipLocalizationVariant,
  );{{#use_auto_route_router}}testWidgets(
    '''

GIVEN a add task fab
AND and injected routing controller
WHEN the add task fab is tapped
THEN the new task route should be visited
''',
    (tester) async {
      final routingController = MockRoutingController();
      when(
        () => routingController.navigate(
          any(),
        ),
      ).thenAnswer(
        (_) async {},
      );
      await tester.pumpTestableWidget(RouterScope(
            controller: routingController,
            inheritableObserversBuilder: () => [],
            stateHash: 0,
            child: const NewTaskFab(),
          ),);
      final addTaskButtonFinder = find.byType(NewTaskFab);
      await tester.tap(addTaskButtonFinder);
      verify(() => routingController.navigate(const NewTaskRoute())).called(1);
      verifyNoMoreInteractions(routingController);
    },
  );{{/use_auto_route_router}}{{#use_go_router_router}}testWidgets(
    '''

GIVEN a add task fab
AND an injected router
WHEN the add task fab is tapped
THEN the new task route should be visited
''',
    (tester) async {
      final goRouter = MockGoRouter();
      when(
        () => goRouter.go(
          any(),
        ),
      ).thenAnswer(
        (_) async {},
      );
      await tester.pumpTestableWidget(InheritedGoRouter(
            goRouter: goRouter,
            child: const NewTaskFab(),
          ),);
      final addTaskButtonFinder = find.byType(NewTaskFab);
      await tester.tap(addTaskButtonFinder);
      verify(() => goRouter.go(const NewTaskRouteData().location)).called(1);
      verifyNoMoreInteractions(goRouter);
    },
  );{{/use_go_router_router}}
}
