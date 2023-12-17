import 'package:tasks/tasks.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for a task
WHEN the constructor is called
THEN an instance of the task is returned
''',
    () {
      final task = Task(
        id: 'id',
        title: 'title',
        isCompleted: false,
        createdAt: DateTime.now(),
        description: 'description',
      );
      expect(task, isNotNull);
      expect(task, isA<Task>());
    },
  );

  test(
    '''

GIVEN a constructor for a new task
WHEN the constructor is called
THEN an instance of the new task is returned
''',
    () {
      const newTask = NewTask(
        title: 'title',
        description: 'description',
      );
      expect(newTask, isNotNull);
      expect(newTask, isA<NewTask>());
    },
  );

  test(
    '''

GIVEN a constructor for a partial task
WHEN the constructor is called
THEN an instance of the partial task is returned
''',
    () {
      final partialTask = PartialTask(
        title: () => 'title',
        isCompleted: () => false,
        description: () => 'description',
      );
      expect(partialTask, isNotNull);
      expect(partialTask, isA<PartialTask>());
    },
  );
}
