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
