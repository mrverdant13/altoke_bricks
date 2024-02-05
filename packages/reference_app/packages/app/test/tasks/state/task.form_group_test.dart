import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    '''

GIVEN a task form group''',
    () {
      late TaskFormGroup taskFormGroup;

      setUp(() {
        taskFormGroup = TaskFormGroup();
      });

      tearDown(() {
        taskFormGroup.dispose();
      });

      test(
        '''

WHEN the form group is created
THEN the title control is created
AND the description control is created
AND all the controls are added to the form group
''',
        () {
          expect(
            taskFormGroup.titleControl,
            isNotNull,
          );
          expect(
            taskFormGroup.descriptionControl,
            isNotNull,
          );
          expect(
            taskFormGroup.control(TaskFormGroup.titleControlName),
            taskFormGroup.titleControl,
          );
          expect(
            taskFormGroup.control(TaskFormGroup.descriptionControlName),
            taskFormGroup.descriptionControl,
          );
        },
      );

      test(
        '''

AND the title control holds a non-empty value
AND the description control remains untouched
WHEN the form group is validated
THEN the form group is valid
''',
        () {
          taskFormGroup.titleControl.value = 'title';

          expect(
            taskFormGroup.valid,
            isTrue,
          );
        },
      );

      test(
        '''

AND the title control holds a non-empty value
AND the description control holds an empty value
WHEN the form group is validated
THEN the form group is valid
''',
        () {
          taskFormGroup.titleControl.value = 'title';
          taskFormGroup.descriptionControl.value = '';

          expect(
            taskFormGroup.valid,
            isTrue,
          );
        },
      );

      test(
        '''

AND the title control holds a non-empty value
AND the description control holds a non-empty value
WHEN the form group is validated
THEN the form group is valid
''',
        () {
          taskFormGroup.titleControl.value = 'title';
          taskFormGroup.descriptionControl.value = 'description';

          expect(
            taskFormGroup.valid,
            isTrue,
          );
        },
      );

      test(
        '''

AND the title control remains untouched
AND the description control remains untouched
WHEN the form group is validated
THEN the form group is invalid
''',
        () {
          expect(
            taskFormGroup.valid,
            isFalse,
          );
        },
      );

      test(
        '''

AND the title control remains untouched
AND the description control holds an empty value
WHEN the form group is validated
THEN the form group is invalid
''',
        () {
          taskFormGroup.descriptionControl.value = '';

          expect(
            taskFormGroup.valid,
            isFalse,
          );
        },
      );

      test(
        '''

AND the title control remains untouched
AND the description control holds a non-empty value
WHEN the form group is validated
THEN the form group is invalid
''',
        () {
          taskFormGroup.descriptionControl.value = 'description';

          expect(
            taskFormGroup.valid,
            isFalse,
          );
        },
      );

      test(
        '''

AND the title control holds an empty value
AND the description control remains untouched
WHEN the form group is validated
THEN the form group is invalid
''',
        () {
          taskFormGroup.titleControl.value = '';

          expect(
            taskFormGroup.valid,
            isFalse,
          );
        },
      );

      test(
        '''

AND the title control holds an empty value
AND the description control holds an empty value
WHEN the form group is validated
THEN the form group is invalid
''',
        () {
          taskFormGroup.titleControl.value = '';
          taskFormGroup.descriptionControl.value = '';

          expect(
            taskFormGroup.valid,
            isFalse,
          );
        },
      );

      test(
        '''

AND the title control holds an empty value
AND the description control holds a non-empty value
WHEN the form group is validated
THEN the form group is invalid
''',
        () {
          taskFormGroup.titleControl.value = '';
          taskFormGroup.descriptionControl.value = 'description';

          expect(
            taskFormGroup.valid,
            isFalse,
          );
        },
      );
    },
  );
}
