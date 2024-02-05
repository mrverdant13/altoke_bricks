import 'package:altoke_app/routing/routing.dart';
import 'package:altoke_app/tasks/tasks.dart';
/*{{#use_auto_route_router}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route_router}}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
/*{{#use_go_router_router}}*/
import 'package:go_router/go_router.dart';
/*{{/use_go_router_router}}*/
import 'package:mocktail/mocktail.dart';
import 'package:tasks_storage/tasks_storage.dart';

import '../../helpers/helpers.dart';

void main() {
/*w 1v w*/
/*{{#use_auto_route_router}}*/
  testWidgets(
    '''

GIVEN a task update state handler wrapper
AND an injected routing controller
WHEN a task is updated
THEN the tasks route should be visited
''',
    (tester) async {
      registerFallbackValues();
      final container = ProviderContainer(
        /*remove-start*/
        overrides: [
          routerPod.overrideWithValue(RouterPackage.autoRoute),
        ],
        /*remove-end*/
      );
      addTearDown(container.dispose);
      final routingController = MockRoutingController();
      when(() => routingController.navigate(any()))
          .thenAnswer((_) async => null);
      await tester.pumpTestableWidget(
        UncontrolledProviderScope(
          container: container,
          child: RouterScope(
            controller: routingController,
            inheritableObserversBuilder: () => [],
            stateHash: 0,
            child: const Scaffold(
              body: TaskUpdateStateHandlerWrapper(
                child: SizedBox.shrink(),
              ),
            ),
          ),
        ),
      );
      container.read(tasksMutatorPod.notifier)
        ..state = const TasksUpdatingTask()
        ..state = const TasksMutationIdle();
      verify(() => routingController.navigate(const TasksRoute())).called(1);
      verifyNoMoreInteractions(routingController);
    },
  );
/*{{/use_auto_route_router}}*/

/*{{#use_go_router_router}}*/
  testWidgets(
    '''

GIVEN a task update state handler wrapper
AND an injected router
WHEN a task is updated
THEN the tasks route should be visited
''',
    (tester) async {
      registerFallbackValues();
      final container = ProviderContainer(
        /*remove-start*/
        overrides: [
          routerPod.overrideWithValue(RouterPackage.goRouter),
        ],
        /*remove-end*/
      );
      addTearDown(container.dispose);
      final goRouter = MockGoRouter();
      when(() => goRouter.go(any())).thenAnswer((_) async {});
      await tester.pumpTestableWidget(
        UncontrolledProviderScope(
          container: container,
          child: InheritedGoRouter(
            goRouter: goRouter,
            child: const Scaffold(
              body: TaskUpdateStateHandlerWrapper(
                child: SizedBox.shrink(),
              ),
            ),
          ),
        ),
      );
      container.read(tasksMutatorPod.notifier)
        ..state = const TasksUpdatingTask()
        ..state = const TasksMutationIdle();
      verify(() => goRouter.go(const TasksRouteData().location)).called(1);
      verifyNoMoreInteractions(goRouter);
    },
  );
/*{{/use_go_router_router}}*/

  testWidgets(
    '''

GIVEN a task update state handler wrapper
WHEN a task fails to be updated
THEN a snackbar with the error message should be shown
''',
    (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await tester.pumpTestableWidget(
        UncontrolledProviderScope(
          container: container,
          child: const Scaffold(
            body: TaskUpdateStateHandlerWrapper(
              child: SizedBox.shrink(),
            ),
          ),
        ),
      );
      final snackbarFinder = find.byType(SnackBar);
      expect(snackbarFinder, findsNothing);
      container.read(tasksMutatorPod.notifier)
        ..state = const TasksUpdatingTask()
        ..state = const TasksMutationFailure(
          error: UpdateTaskFailureEmptyTitle(),
          stackTrace: StackTrace.empty,
        );
      await tester.pumpAndSettle();
      expect(snackbarFinder, findsOneWidget);
      final snackBarContentFinder = find.byKey(
        const Key(
          '''<tasks:task-update-state-handler-wrapper:snackbar-content>''',
        ),
      );
      expect(snackBarContentFinder, findsOneWidget);
    },
  );

  group(
    '''

GIVEN a localization variant for the error message used when a task title is empty''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10) =>
            l10.tasksUpdateTaskFailureEmptyTitleSnackbarMessage,
        partialCases: {
          const (
            Locale('en'),
            'A task title cannot be empty',
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'El título de una tarea no puede estar vacío',
          ),
        },
      );

      testExhaustiveLocalizationVariant(
        '''

WHEN testing the app bar
THEN all supported locales should be considered
''',
        localizationVariant,
      );

      testLocalizedWidget(
        '''

AND an existing task
WHEN the app bar is displayed
THEN the title should be localized
''',
        const Scaffold(
          body: SnackbarErrorContent(
            error: UpdateTaskFailureEmptyTitle(),
          ),
        ),
        ancestorFinder: find.byKey(
          const Key(
            '''<tasks:task-update-state-handler-wrapper:snackbar-content>''',
          ),
        ),
        variant: localizationVariant,
      );
    },
  );
}
