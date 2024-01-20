import 'dart:async';

import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:altoke_app/tasks/tasks.dart';
/*{{#use_auto_route_router}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route_router}}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
/*{{#use_go_router_router}}*/
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tasks/tasks.dart';

import '../../../../helpers/app_tester.dart';
/*{{/use_go_router_router}}*/

void main() {
/*w 1v w*/
/*{{#use_auto_route_router}}*/
  testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the task details path
WHEN the app starts
THEN the task details screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MyApp(
            routerConfig: AppRouter().config(
              deepLinkBuilder: (_) => const DeepLink.path('/tasks/123'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final tasksScreenFinder = find.byType(TaskDetailsScreen);
      expect(tasksScreenFinder, findsOneWidget);
    },
  );
/*{{/use_auto_route_router}}*/

/*{{#use_go_router_router}}*/
  testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the task details path
WHEN the app starts
THEN the task details screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MyApp(
            routerConfig: GoRouter(
              routes: $appRoutes,
              initialLocation: '/tasks/123',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final tasksScreenFinder = find.byType(TaskDetailsScreen);
      expect(tasksScreenFinder, findsOneWidget);
    },
  );
/*{{/use_go_router_router}}*/

  testWidgets(
    '''

GIVEN a task details screen
├─ THAT receives a task ID
WHEN the screen is displayed
THEN the task details screen layout should be shown
├─ THAT is wrapped by a task details form initializer
AND the scoped task ID should be injected
AND a task form group should be injected
├─ THAT is initially disabled
''',
    (tester) async {
      final asyncTaskCompleter = Completer<Task?>();
      await tester.pumpTestableWidget(
        ProviderScope(
          overrides: [
            asyncTaskPod.overrideWith(
              (_) => asyncTaskCompleter.future,
            ),
          ],
          child: const TaskDetailsScreen(
            taskId: 13,
          ),
        ),
      );
      final layoutFinder = find.byType(TaskDetailsScreenLayout);
      expect(layoutFinder, findsOneWidget);
      final formInitializerFinder = find.ancestor(
        of: layoutFinder,
        matching: find.byType(TaskDetailsFormInitializerWrapper),
      );
      expect(formInitializerFinder, findsOneWidget);
      final layoutContext = tester.element(layoutFinder);
      final innerContainer = ProviderScope.containerOf(
        layoutContext,
        listen: false,
      );
      final scopedTaskId = innerContainer.read(scopedTaskIdPod);
      expect(scopedTaskId, 13);
      final formBuilderFinder = find.ancestor(
        of: formInitializerFinder,
        matching: find.byWidgetPredicate(
          (widget) {
            if (widget is! ReactiveFormBuilder) return false;
            final formGroup = widget.form();
            if (formGroup is! TaskFormGroup) return false;
            return formGroup.disabled;
          },
        ),
      );
      expect(formBuilderFinder, findsOneWidget);
      asyncTaskCompleter.complete(null);
    },
  );

  testWidgets(
    '''

GIVEN a task details screen layout
AND an injected task form group
├─ THAT is disabled
AND an injected scoped task ID
AND an injected async task
├─ THAT is loading
WHEN the screen is displayed
THEN the sliver task form should be shown
AND the update task FAB should not be shown
''',
    (tester) async {
      final asyncTaskCompleter = Completer<Task?>();
      await tester.pumpTestableWidget(
        ProviderScope(
          overrides: [
            scopedTaskIdPod.overrideWithValue(86),
            asyncTaskPod.overrideWith(
              (_) => asyncTaskCompleter.future,
            ),
          ],
          child: ReactiveFormBuilder(
            form: () => TaskFormGroup()..markAsDisabled(),
            builder: (context, formGroup, child) => child!,
            child: const TaskDetailsScreenLayout(),
          ),
        ),
      );
      final formFinder = find.byType(SliverTaskForm);
      expect(formFinder, findsOneWidget);
      final fabFinder = find.byType(UpdateTaskFab);
      expect(fabFinder, findsNothing);
      asyncTaskCompleter.complete(null);
    },
  );

  testWidgets(
    '''

GIVEN a task details screen layout
AND an injected task form group
├─ THAT is disabled
AND an injected scoped task ID
AND an injected async task
├─ THAT is errored
WHEN the screen is displayed
THEN the error indicator should be shown
AND the update task FAB should not be shown
''',
    (tester) async {
      await tester.pumpTestableWidget(
        ProviderScope(
          overrides: [
            scopedTaskIdPod.overrideWithValue(86),
            asyncTaskPod.overrideWith(
              (_) => throw Exception('oops'),
            ),
          ],
          child: ReactiveFormBuilder(
            form: () => TaskFormGroup()..markAsDisabled(),
            builder: (context, formGroup, child) => child!,
            child: const TaskDetailsScreenLayout(),
          ),
        ),
      );
      final errorIndicatorFinder = find.byType(
        SliverFillRemainingWithErrorOnTaskLoad,
      );
      expect(errorIndicatorFinder, findsOneWidget);
      final fabFinder = find.byType(UpdateTaskFab);
      expect(fabFinder, findsNothing);
    },
  );

  testWidgets(
    '''

GIVEN a task details screen layout
AND an injected task form group
├─ THAT is disabled
AND an injected scoped task ID
AND an injected async task
├─ THAT is loaded but non-existent
WHEN the screen is displayed
THEN the not found indicator should be shown
AND the update task FAB should not be shown
''',
    (tester) async {
      await tester.pumpTestableWidget(
        ProviderScope(
          overrides: [
            scopedTaskIdPod.overrideWithValue(86),
            asyncTaskPod.overrideWith(
              (_) => null,
            ),
          ],
          child: ReactiveFormBuilder(
            form: () => TaskFormGroup()..markAsDisabled(),
            builder: (context, formGroup, child) => child!,
            child: const TaskDetailsScreenLayout(),
          ),
        ),
      );
      final errorIndicatorFinder = find.byType(
        SliverFillRemainingWithTaskNotFoundError,
      );
      expect(errorIndicatorFinder, findsOneWidget);
      final fabFinder = find.byType(UpdateTaskFab);
      expect(fabFinder, findsNothing);
    },
  );

  testWidgets(
    '''

GIVEN a task details screen layout
AND an injected task form group
├─ THAT is enabled
AND an injected scoped task ID
AND an injected async task
├─ THAT is loaded and existent
WHEN the screen is displayed
THEN the task form should be shown
AND the update task FAB should be shown
''',
    (tester) async {
      await tester.pumpTestableWidget(
        ProviderScope(
          overrides: [
            scopedTaskIdPod.overrideWithValue(86),
            asyncTaskPod.overrideWith(
              (_) => Task(
                id: 389,
                title: 'title',
                isCompleted: false,
                createdAt: DateTime.now(),
              ),
            ),
          ],
          child: ReactiveFormBuilder(
            form: () => TaskFormGroup()..markAsEnabled(),
            builder: (context, formGroup, child) => child!,
            child: const TaskDetailsScreenLayout(),
          ),
        ),
      );
      final formFinder = find.byType(SliverTaskForm);
      expect(formFinder, findsOneWidget);
      final fabFinder = find.byType(UpdateTaskFab);
      expect(fabFinder, findsOneWidget);
    },
  );
}
