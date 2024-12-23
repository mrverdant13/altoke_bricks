import 'package:altoke_common/common.dart';
import 'package:local_database/local_database.dart';
import 'package:test/test.dart';

void main() {
  group('$NewTask', () {
    test('can be instantiated', () {
      const task = NewTask(
        title: 'title',
        description: 'description',
        priority: TaskPriority.low,
      );
      expect(task, isA<NewTask>());
    });
  });

  group('$Task', () {
    test('can be instantiated', () {
      const task = Task(
        id: 1,
        title: 'title',
        priority: TaskPriority.low,
        completed: false,
        description: 'description',
      );
      expect(task, isA<Task>());
    });

    test('has a string representation', () {
      const task = Task(
        id: 1,
        title: 'title',
        priority: TaskPriority.low,
        completed: false,
        description: 'description',
      );
      expect(
        task.toString(),
        '''Task(id: 1, title: title, priority: TaskPriority.low, completed: false, description: description)''',
      );
    });

    test('can be compared and has a consistent hash code', () {
      // Using a non-const object to ensure coverage.
      // ignore: prefer_const_constructors
      final task = Task(
        id: 1,
        title: 'title',
        priority: TaskPriority.low,
        completed: false,
        description: 'description',
      );
      const sameTask = Task(
        id: 1,
        title: 'title',
        priority: TaskPriority.low,
        completed: false,
        description: 'description',
      );
      const differentTask = Task(
        id: 2,
        title: 'other title',
        priority: TaskPriority.medium,
        completed: true,
        description: 'other description',
      );
      expect(task, equals(sameTask));
      expect(task.hashCode, equals(sameTask.hashCode));
      expect(task, isNot(equals(differentTask)));
      expect(task.hashCode, isNot(equals(differentTask.hashCode)));
    });
  });

  group('$PartialTask', () {
    test('can be instantiated', () {
      const task = PartialTask(
        title: Some('title'),
        priority: Some(TaskPriority.low),
        completed: Some(false),
        description: Some('description'),
      );
      expect(task, isA<PartialTask>());
    });
  });
}
