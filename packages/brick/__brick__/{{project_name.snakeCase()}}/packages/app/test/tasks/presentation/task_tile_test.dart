import 'package:{{project_name.snakeCase()}}/routing/routing.dart';
import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';{{#use_auto_route_router}}import 'package:auto_route/auto_route.dart';{{/use_auto_route_router}}import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';{{#use_go_router_router}}import 'package:go_router/go_router.dart';{{/use_go_router_router}}import 'package:mocktail/mocktail.dart';
import 'package:tasks/tasks.dart';

import '../../helpers/helpers.dart';

void main() {
  registerFallbackValues();

  final dismissibleWrapperFinder = find.byType(DismissibleWrapper);
  final baseTileFinder = find.byType(BaseTaskTile);
  final skeletonTileFinder = find.byType(SkeletonTaskTile);
  final taskTileFinder = find.byType(TaskTile);

  testWidgets(
    '''

GIVEN a task tile skeleton
WHEN the task tile is rendered
THEN the task tile should be visible
├─ THAT displays a skeleton title
├─ AND displays a skeleton checkbox
''',
    (tester) async {
      await tester.pumpTestableWidget(
        const Scaffold(
          body: TaskTile.skeleton(),
        ),
      );
      expect(skeletonTileFinder, findsOneWidget);
      expect(baseTileFinder, findsOneWidget);
      final foundTileSkeleton = tester.widget(baseTileFinder);
      expect(
        foundTileSkeleton,
        isA<BaseTaskTile>()
            .having(
              (t) => t.title,
              'title widget',
              isA<SkeletonTaskTitle>(),
            )
            .having(
              (t) => t.trailing,
              'trailing widget',
              isA<SkeletonTaskCheckbox>(),
            ),
      );
    },
  );

  testWidgets(
    '''

GIVEN a task tile
AND a scoped task
├─ THAT has a title
├─ AND has no description
├─ AND is completed
WHEN the task tile is rendered
THEN the task tile should be visible
├─ THAT displays a title
├─ AND does not display a description
├─ AND displays a checkbox
│  ├─ THAT is checked
├─ AND has a tap callback
''',
    (tester) async {
      final task = Task(
        id: 1,
        title: 'Test task',
        isCompleted: true,
        createdAt: DateTime.now(),
      );
      await tester.pumpTestableWidget(
        Scaffold(
          body: ProviderScope(
            overrides: [
              taskPod.overrideWithValue(task),
            ],
            child: const TaskTile(),
          ),
        ),
      );
      expect(taskTileFinder, findsOneWidget);
      expect(baseTileFinder, findsOneWidget);
      expect(dismissibleWrapperFinder, findsOneWidget);
      final foundTile = tester.widget(baseTileFinder);
      expect(
        foundTile,
        isA<BaseTaskTile>()
            .having(
              (t) => find.descendant(
                of: find.byWidget(t),
                matching: find.widgetWithText(
                  TaskTitle,
                  task.title,
                ),
              ),
              'title widget',
              findsOneWidget,
            )
            .having(
              (t) => t.subtitle,
              'subtitle widget',
              isNull,
            )
            .having(
              (t) => find.descendant(
                of: find.descendant(
                  of: find.byWidget(t),
                  matching: find.byType(TaskCheckbox),
                ),
                matching: find.byWidgetPredicate(
                  (widget) {
                    if (widget is! Checkbox) return false;
                    return widget.value ?? false;
                  },
                ),
              ),
              'trailing widget',
              findsOneWidget,
            )
            .having(
              (t) => t.onTap,
              'onTap callback',
              isNotNull,
            ),
      );
    },
  );

  testWidgets(
    '''

GIVEN a task tile
AND a scoped task
├─ THAT has a title
├─ AND has a description
├─ AND is uncompleted
WHEN the task tile is rendered
THEN the task tile should be visible
├─ THAT displays a title
├─ AND displays a description
├─ AND displays a checkbox
│  ├─ THAT is unchecked
├─ AND has a tap callback
''',
    (tester) async {
      final task = Task(
        id: 7,
        title: 'Test task',
        description: 'Test description',
        isCompleted: false,
        createdAt: DateTime.now(),
      );
      await tester.pumpTestableWidget(
        Scaffold(
          body: ProviderScope(
            overrides: [
              taskPod.overrideWithValue(task),
            ],
            child: const TaskTile(),
          ),
        ),
      );
      expect(taskTileFinder, findsOneWidget);
      expect(baseTileFinder, findsOneWidget);
      expect(dismissibleWrapperFinder, findsOneWidget);
      final foundTile = tester.widget(baseTileFinder);
      expect(
        foundTile,
        isA<BaseTaskTile>()
            .having(
              (t) => find.descendant(
                of: find.byWidget(t),
                matching: find.widgetWithText(
                  TaskTitle,
                  task.title,
                ),
              ),
              'title widget',
              findsOneWidget,
            )
            .having(
              (t) => find.descendant(
                of: find.byWidget(t),
                matching: find.widgetWithText(
                  TaskDescription,
                  task.description!,
                ),
              ),
              'subtitle widget',
              findsOneWidget,
            )
            .having(
              (t) => find.descendant(
                of: find.descendant(
                  of: find.byWidget(t),
                  matching: find.byType(TaskCheckbox),
                ),
                matching: find.byWidgetPredicate(
                  (widget) {
                    if (widget is! Checkbox) return false;
                    return widget.value == false;
                  },
                ),
              ),
              'trailing widget',
              findsOneWidget,
            )
            .having(
              (t) => t.onTap,
              'onTap callback',
              isNotNull,
            ),
      );
    },
  );{{#use_auto_route_router}}testWidgets(
    '''

GIVEN a task tile
AND a scoped task
AND an injected routing controller
WHEN the tile is tapped
THEN the task details route for the given task should be visited
''',
    (tester) async {
      final task = Task(
        id: 7,
        title: 'Test task',
        description: 'Test description',
        isCompleted: false,
        createdAt: DateTime.now(),
      );
      final routingController = MockRoutingController();
      when(() => routingController.navigate(any()))
          .thenAnswer((_) async => null);
      await tester.pumpTestableWidget(
        ProviderScope(
          overrides: [taskPod.overrideWithValue(task),
          ],
          child: RouterScope(
            controller: routingController,
            inheritableObserversBuilder: () => [],
            stateHash: 0,
            child: const Scaffold(
              body: TaskTile(),
            ),
          ),
        ),
      );
      final taskTileFinder = find.byType(TaskTile);
      await tester.tap(taskTileFinder);
      verify(
        () => routingController.navigate(TaskDetailsRoute(taskId: task.id)),
      ).called(1);
      verifyNoMoreInteractions(routingController);
    },
  );{{/use_auto_route_router}}{{#use_go_router_router}}testWidgets(
    '''

GIVEN a task tile
AND a scoped task
AND an injected router
WHEN the tile is tapped
THEN the task details route for the given task should be visited
''',
    (tester) async {
      final task = Task(
        id: 7,
        title: 'Test task',
        description: 'Test description',
        isCompleted: false,
        createdAt: DateTime.now(),
      );
      final goRouter = MockGoRouter();
      when(() => goRouter.go(any())).thenAnswer((_) async {});
      await tester.pumpTestableWidget(
        ProviderScope(
          overrides: [taskPod.overrideWithValue(task),
          ],
          child: InheritedGoRouter(
            goRouter: goRouter,
            child: const Scaffold(
              body: TaskTile(),
            ),
          ),
        ),
      );
      final taskTileFinder = find.byType(TaskTile);
      await tester.tap(taskTileFinder);
      verify(
        () => goRouter.go(TaskDetailsRouteData(taskId: task.id).location),
      ).called(1);
      verifyNoMoreInteractions(goRouter);
    },
  );{{/use_go_router_router}}group(
    '''

GIVEN a task tile
AND a scoped task
AND an injected tasks mutator''',
    () {
      final task = Task(
        id: 13,
        title: 'Test task',
        description: 'Test description',
        isCompleted: true,
        createdAt: DateTime.now(),
      );

      late TasksMutator tasksMutator;
      late Widget testableTaskTile;

      setUp(
        () {
          tasksMutator = MockTasksMutator(
            initialState: const TasksMutationIdle(),
          );
          testableTaskTile = Scaffold(
            body: SizedBox.expand(
              child: ProviderScope(
                overrides: [
                  taskPod.overrideWithValue(task),
                  tasksMutatorPod.overrideWith(() => tasksMutator),
                ],
                child: const TaskTile(),
              ),
            ),
          );
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(tasksMutator);
        },
      );

      testWidgets(
        '''

WHEN the task tile is dismissed
THEN the task should be deleted
├─ BY delegating the task deletion to the tasks mutator
''',
        (tester) async {
          final dismissibleFinder = find.byType(Dismissible);
          when(
            () => tasksMutator.deleteTask(
              taskId: any(named: 'taskId'),
            ),
          ).thenAnswer(
            (_) async {},
          );
          await tester.pumpTestableWidget(testableTaskTile);
          expect(dismissibleFinder, findsOneWidget);
          final dismissibleSize = tester.getSize(dismissibleFinder);
          final dismissibleTopRightPoint =
              tester.getTopRight(dismissibleFinder);
          final downPoint = dismissibleTopRightPoint.translate(
            -dismissibleSize.width * 0.05,
            dismissibleSize.height * 0.5,
          );
          final gesture = await tester.startGesture(downPoint);
          await gesture.moveBy(Offset(-dismissibleSize.width, 0));
          await gesture.up();
          await tester.pumpAndSettle();
          expect(dismissibleFinder, findsNothing);
          verify(
            () => tasksMutator.deleteTask(
              taskId: task.id,
            ),
          ).called(1);
        },
      );

      testWidgets(
        '''

WHEN the checkbox is tapped
THEN the task status should be toggled
├─ BY delegating the task update to the tasks mutator
''',
        (tester) async {
          final checkboxFinder = find.byType(TaskCheckbox);
          when(
            () => tasksMutator.updateTask(
              taskId: any(named: 'taskId'),
              partialTask: any(named: 'partialTask'),
            ),
          ).thenAnswer(
            (_) async {},
          );
          await tester.pumpTestableWidget(testableTaskTile);
          expect(checkboxFinder, findsOneWidget);
          await tester.tap(checkboxFinder);
          await tester.pumpAndSettle();
          verify(
            () => tasksMutator.updateTask(
              taskId: task.id,
              partialTask: any(
                named: 'partialTask',
                that: isA<PartialTask>().having(
                  (t) => t.isCompleted?.call(),
                  'isCompleted',
                  isNot(task.isCompleted),
                ),
              ),
            ),
          ).called(1);
        },
      );
    },
  );
}
