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

import '../../helpers/helpers.dart';

void main() {
/*{{#use_auto_route_router}}*/
  testWidgets(
    '''

GIVEN a task creation state handler wrapper
AND an injected routing controller
WHEN a task is created
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
              body: TaskCreationStateHandlerWrapper(
                child: SizedBox.shrink(),
              ),
            ),
          ),
        ),
      );
      container.read(taskCreatorPod.notifier).state = const AsyncData(true);
      verify(() => routingController.navigate(const TasksRoute())).called(1);
      verifyNoMoreInteractions(routingController);
    },
  );
/*{{/use_auto_route_router}}*/

/*{{#use_go_router_router}}*/
  testWidgets(
    '''

GIVEN a task creation state handler wrapper
AND an injected router
WHEN a task is created
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
              body: TaskCreationStateHandlerWrapper(
                child: SizedBox.shrink(),
              ),
            ),
          ),
        ),
      );
      container.read(taskCreatorPod.notifier).state = const AsyncData(true);
      verify(() => goRouter.go(const TasksRouteData().location)).called(1);
      verifyNoMoreInteractions(goRouter);
    },
  );
/*{{/use_go_router_router}}*/
}
