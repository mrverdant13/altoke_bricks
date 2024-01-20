import 'dart:async';

import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tasks/tasks.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets(
    '''

GIVEN a task details form initializer
AND an injected task form group
├─ THAT is filled
├─ AND is enabled
AND an injected async task
WHEN the async task is errored
THEN the form should be disabled
AND the form should be empty
''',
    (tester) async {
      final formGroup = TaskFormGroup()
        ..titleControl.value = 'title'
        ..descriptionControl.value = 'description'
        ..markAsEnabled();
      addTearDown(formGroup.dispose);
      final asyncTaskCompleter = Completer<void>();
      await tester.pumpTestableWidget(
        ProviderScope(
          overrides: [
            asyncTaskPod.overrideWith(
              (ref) => Future<Task?>.error(Exception('error'))
                  .whenComplete(asyncTaskCompleter.complete),
            ),
          ],
          child: ReactiveForm(
            formGroup: formGroup,
            child: const TaskDetailsFormInitializerWrapper(
              child: SizedBox.shrink(),
            ),
          ),
        ),
      );
      await asyncTaskCompleter.future;
      expect(formGroup.enabled, isFalse);
      expect(formGroup.anyControls((control) => control.isNotNull), isFalse);
    },
  );

  testWidgets(
    '''

GIVEN a task details form initializer
AND an injected task form group
├─ THAT is filled
├─ AND is enabled
AND an injected async task
WHEN the async task is loaded but non-existent
THEN the form should be disabled
AND the form should be empty
''',
    (tester) async {
      final formGroup = TaskFormGroup()
        ..titleControl.value = 'title'
        ..descriptionControl.value = 'description'
        ..markAsEnabled();
      addTearDown(formGroup.dispose);
      final asyncTaskCompleter = Completer<void>();
      await tester.pumpTestableWidget(
        ProviderScope(
          overrides: [
            asyncTaskPod.overrideWith(
              (ref) => Future<Task?>.value()
                  .whenComplete(asyncTaskCompleter.complete),
            ),
          ],
          child: ReactiveForm(
            formGroup: formGroup,
            child: const TaskDetailsFormInitializerWrapper(
              child: SizedBox.shrink(),
            ),
          ),
        ),
      );
      await asyncTaskCompleter.future;
      expect(formGroup.enabled, isFalse);
      expect(formGroup.anyControls((control) => control.isNotNull), isFalse);
    },
  );

  testWidgets(
    '''

GIVEN a task details form initializer
AND an injected task form group
├─ THAT is empty
├─ AND is disabled
AND an injected async task
WHEN the async task is loaded and existent
THEN the form should be enabled
AND the form should be filled
''',
    (tester) async {
      final formGroup = TaskFormGroup()
        ..titleControl.value = null
        ..descriptionControl.value = null
        ..markAsDisabled();
      addTearDown(formGroup.dispose);
      final asyncTaskCompleter = Completer<void>();
      final task = Task(
        id: 7827,
        title: 'title',
        description: 'description',
        isCompleted: false,
        createdAt: DateTime.now(),
      );
      await tester.pumpTestableWidget(
        ProviderScope(
          overrides: [
            asyncTaskPod.overrideWith(
              (ref) => Future<Task?>.value(task)
                  .whenComplete(asyncTaskCompleter.complete),
            ),
          ],
          child: ReactiveForm(
            formGroup: formGroup,
            child: const TaskDetailsFormInitializerWrapper(
              child: SizedBox.shrink(),
            ),
          ),
        ),
      );
      await asyncTaskCompleter.future;
      expect(formGroup.enabled, isTrue);
      expect(formGroup.titleControl.value, task.title);
      expect(formGroup.descriptionControl.value, task.description);
    },
  );
}
