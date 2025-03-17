import 'package:common/common.dart';
import 'package:{{package_name}}/{{package_name}}.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for task
WHEN the constructor is called
THEN an instance of the task is returned
''',
    () {
      {{#use_dart_mappable}}const task = Task(id: 37, name: 'name', description: 'description');
        expect(task, isNotNull);
        expect(task, isA<Task>());{{/use_dart_mappable}}{{#use_equatable}}const task = Task(id: 37, name: 'name', description: 'description');
        expect(task, isNotNull);
        expect(task, isA<Task>());{{/use_equatable}}{{#use_freezed}}const task = Task(id: 37, name: 'name', description: 'description');
        expect(task, isNotNull);
        expect(task, isA<Task>());{{/use_freezed}}{{#use_overrides}}const task = Task(id: 37, name: 'name', description: 'description');
        expect(task, isNotNull);
        expect(task, isA<Task>());{{/use_overrides}}
    },
  );

  test(
    '''

GIVEN a couple of tasks
WHEN they are directly compared
AND their hash codes are compared
THEN they are equal if they have the same values
AND their hash codes are equal if they have the same values
''',
    () {
      {{#use_dart_mappable}}const task = Task(id: 37, name: 'name', description: 'description');
        const sameTask = Task(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const differentTask = Task(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(task, sameTask);
        expect(task, isNot(differentTask));
        expect(task.hashCode, sameTask.hashCode);
        expect(task.hashCode, isNot(differentTask.hashCode));{{/use_dart_mappable}}{{#use_equatable}}const task = Task(id: 37, name: 'name', description: 'description');
        const sameTask = Task(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const differentTask = Task(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(task, sameTask);
        expect(task, isNot(differentTask));
        expect(task.hashCode, sameTask.hashCode);
        expect(task.hashCode, isNot(differentTask.hashCode));{{/use_equatable}}{{#use_freezed}}const task = Task(id: 37, name: 'name', description: 'description');
        const sameTask = Task(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const differentTask = Task(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(task, sameTask);
        expect(task, isNot(differentTask));
        expect(task.hashCode, sameTask.hashCode);
        expect(task.hashCode, isNot(differentTask.hashCode));{{/use_freezed}}{{#use_overrides}}const task = Task(id: 37, name: 'name', description: 'description');
        const sameTask = Task(id: 37, name: 'name', description: 'description');
        const differentTask = Task(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(task, sameTask);
        expect(task, isNot(differentTask));
        expect(task.hashCode, sameTask.hashCode);
        expect(task.hashCode, isNot(differentTask.hashCode));{{/use_overrides}}
    },
  );

  test(
    '''

GIVEN an task
WHEN its string representation is requested
THEN a string representation of the task is returned
''',
    () {
      {{#use_dart_mappable}}const task = Task(id: 37, name: 'name', description: 'description');
        expect(
          task.toString(),
          'Task(id: 37, name: name, description: description)',
        );{{/use_dart_mappable}}{{#use_equatable}}const task = Task(id: 37, name: 'name', description: 'description');
        expect(task.toString(), 'Task(37, name, description)');{{/use_equatable}}{{#use_freezed}}const task = Task(id: 37, name: 'name', description: 'description');
        expect(
          task.toString(),
          'Task(id: 37, name: name, description: description)',
        );{{/use_freezed}}{{#use_overrides}}const task = Task(id: 37, name: 'name', description: 'description');
        expect(
          task.toString(),
          'Task(id: 37, name: name, description: description)',
        );{{/use_overrides}}
    },
  );

  test(
    '''

GIVEN an task
WHEN it gets copied
THEN an new instance of the task is returned
├─ THAT has updated values
''',
    () {
      {{#use_dart_mappable}}const task = Task(id: 37, name: 'name', description: 'description');
        final fullyCopiedTask = task.copyWith(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(fullyCopiedTask, isNotNull);
        expect(
          fullyCopiedTask,
          isA<Task>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedTask = task.copyWith();
        expect(noopCopiedTask, isNotNull);
        expect(noopCopiedTask, task);{{/use_dart_mappable}}{{#use_equatable}}const task = Task(id: 37, name: 'name', description: 'description');
        final fullyCopiedTask = task.copyWith(
          id: 38,
          name: 'new name',
          description: () => 'new description',
        );
        expect(fullyCopiedTask, isNotNull);
        expect(
          fullyCopiedTask,
          isA<Task>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedTask = task.copyWith();
        expect(noopCopiedTask, isNotNull);
        expect(noopCopiedTask, task);{{/use_equatable}}{{#use_freezed}}const task = Task(id: 37, name: 'name', description: 'description');
        final fullyCopiedTask = task.copyWith(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(fullyCopiedTask, isNotNull);
        expect(
          fullyCopiedTask,
          isA<Task>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedTask = task.copyWith();
        expect(noopCopiedTask, isNotNull);
        expect(noopCopiedTask, task);{{/use_freezed}}{{#use_overrides}}const task = Task(id: 37, name: 'name', description: 'description');
        final fullyCopiedTask = task.copyWith(
          id: 38,
          name: 'new name',
          description: () => 'new description',
        );
        expect(fullyCopiedTask, isNotNull);
        expect(
          fullyCopiedTask,
          isA<Task>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedTask = task.copyWith();
        expect(noopCopiedTask, isNotNull);
        expect(noopCopiedTask, task);{{/use_overrides}}
    },
  );

  test(
    '''

GIVEN a constructor for a new task
WHEN the constructor is called
THEN an instance of the new task is returned
''',
    () {
      {{#use_dart_mappable}}const newTask = NewTask(name: 'name', description: 'description');
        expect(newTask, isNotNull);
        expect(newTask, isA<NewTask>());{{/use_dart_mappable}}{{#use_equatable}}const newTask = NewTask(name: 'name', description: 'description');
        expect(newTask, isNotNull);
        expect(newTask, isA<NewTask>());{{/use_equatable}}{{#use_freezed}}const newTask = NewTask(name: 'name', description: 'description');
        expect(newTask, isNotNull);
        expect(newTask, isA<NewTask>());{{/use_freezed}}{{#use_overrides}}const newTask = NewTask(name: 'name', description: 'description');
        expect(newTask, isNotNull);
        expect(newTask, isA<NewTask>());{{/use_overrides}}
    },
  );

  test(
    '''

GIVEN a couple of new tasks
WHEN they are directly compared
AND their hash codes are compared
THEN they are equal if they have the same values
AND their hash codes are equal if they have the same values
''',
    () {
      {{#use_dart_mappable}}const newTask = NewTask(name: 'name', description: 'description');
        const sameNewTask = NewTask(name: 'name', description: 'description');
        const differentNewTask = NewTask(
          name: 'new name',
          description: 'new description',
        );
        expect(newTask, sameNewTask);
        expect(newTask, isNot(differentNewTask));
        expect(newTask.hashCode, sameNewTask.hashCode);
        expect(newTask.hashCode, isNot(differentNewTask.hashCode));{{/use_dart_mappable}}{{#use_equatable}}const newTask = NewTask(name: 'name', description: 'description');
        const sameNewTask = NewTask(name: 'name', description: 'description');
        const differentNewTask = NewTask(
          name: 'new name',
          description: 'new description',
        );
        expect(newTask, sameNewTask);
        expect(newTask, isNot(differentNewTask));
        expect(newTask.hashCode, sameNewTask.hashCode);
        expect(newTask.hashCode, isNot(differentNewTask.hashCode));{{/use_equatable}}{{#use_freezed}}const newTask = NewTask(name: 'name', description: 'description');
        const sameNewTask = NewTask(name: 'name', description: 'description');
        const differentNewTask = NewTask(
          name: 'new name',
          description: 'new description',
        );
        expect(newTask, sameNewTask);
        expect(newTask, isNot(differentNewTask));
        expect(newTask.hashCode, sameNewTask.hashCode);
        expect(newTask.hashCode, isNot(differentNewTask.hashCode));{{/use_freezed}}{{#use_overrides}}const newTask = NewTask(name: 'name', description: 'description');
        const sameNewTask = NewTask(name: 'name', description: 'description');
        const differentNewTask = NewTask(
          name: 'new name',
          description: 'new description',
        );
        expect(newTask, sameNewTask);
        expect(newTask, isNot(differentNewTask));
        expect(newTask.hashCode, sameNewTask.hashCode);
        expect(newTask.hashCode, isNot(differentNewTask.hashCode));{{/use_overrides}}
    },
  );

  test(
    '''

GIVEN a new task
WHEN its string representation is requested
THEN a string representation of the new task is returned
''',
    () {
      {{#use_dart_mappable}}const newTask = NewTask(name: 'name', description: 'description');
        expect(
          newTask.toString(),
          'NewTask(name: name, description: description)',
        );{{/use_dart_mappable}}{{#use_equatable}}const newTask = NewTask(name: 'name', description: 'description');
        expect(newTask.toString(), 'NewTask(name, description)');{{/use_equatable}}{{#use_freezed}}const newTask = NewTask(name: 'name', description: 'description');
        expect(
          newTask.toString(),
          'NewTask(name: name, description: description)',
        );{{/use_freezed}}{{#use_overrides}}const newTask = NewTask(name: 'name', description: 'description');
        expect(
          newTask.toString(),
          'NewTask(name: name, description: description)',
        );{{/use_overrides}}
    },
  );

  test(
    '''

GIVEN a new task
WHEN it gets copied
THEN an new instance of the new task is returned
├─ THAT has updated values
''',
    () {
      {{#use_dart_mappable}}const newTask = NewTask(name: 'name', description: 'description');
        final fullyCopiedNewTask = newTask.copyWith(
          name: 'new name',
          description: 'new description',
        );
        expect(fullyCopiedNewTask, isNotNull);
        expect(
          fullyCopiedNewTask,
          isA<NewTask>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedNewTask = newTask.copyWith();
        expect(noopCopiedNewTask, isNotNull);
        expect(noopCopiedNewTask, newTask);{{/use_dart_mappable}}{{#use_equatable}}const newTask = NewTask(name: 'name', description: 'description');
        final fullyCopiedNewTask = newTask.copyWith(
          name: 'new name',
          description: () => 'new description',
        );
        expect(fullyCopiedNewTask, isNotNull);
        expect(
          fullyCopiedNewTask,
          isA<NewTask>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedNewTask = newTask.copyWith();
        expect(noopCopiedNewTask, isNotNull);
        expect(noopCopiedNewTask, newTask);{{/use_equatable}}{{#use_freezed}}const newTask = NewTask(name: 'name', description: 'description');
        final fullyCopiedNewTask = newTask.copyWith(
          name: 'new name',
          description: 'new description',
        );
        expect(fullyCopiedNewTask, isNotNull);
        expect(
          fullyCopiedNewTask,
          isA<NewTask>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedNewTask = newTask.copyWith();
        expect(noopCopiedNewTask, isNotNull);
        expect(noopCopiedNewTask, newTask);{{/use_freezed}}{{#use_overrides}}const newTask = NewTask(name: 'name', description: 'description');
        final fullyCopiedNewTask = newTask.copyWith(
          name: 'new name',
          description: () => 'new description',
        );
        expect(fullyCopiedNewTask, isNotNull);
        expect(
          fullyCopiedNewTask,
          isA<NewTask>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedNewTask = newTask.copyWith();
        expect(noopCopiedNewTask, isNotNull);
        expect(noopCopiedNewTask, newTask);{{/use_overrides}}
    },
  );

  test(
    '''

GIVEN a constructor for a partial task
WHEN the constructor is called
THEN an instance of the partial task is returned
''',
    () {
      {{#use_dart_mappable}}const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(partialTask, isNotNull);
        expect(partialTask, isA<PartialTask>());{{/use_dart_mappable}}{{#use_equatable}}const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(partialTask, isNotNull);
        expect(partialTask, isA<PartialTask>());{{/use_equatable}}{{#use_freezed}}const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(partialTask, isNotNull);
        expect(partialTask, isA<PartialTask>());{{/use_freezed}}{{#use_overrides}}const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(partialTask, isNotNull);
        expect(partialTask, isA<PartialTask>());{{/use_overrides}}
    },
  );

  test(
    '''

GIVEN a couple of partial tasks
WHEN they are directly compared
AND their hash codes are compared
THEN they are equal if they have the same values
AND their hash codes are equal if they have the same values
''',
    () {
      {{#use_dart_mappable}}const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const samePartialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const differentPartialTask = PartialTask(
          name: Optional.some('new name'),
          description: Optional.some('new description'),
        );
        expect(partialTask, samePartialTask);
        expect(partialTask, isNot(differentPartialTask));
        expect(partialTask.hashCode, samePartialTask.hashCode);
        expect(partialTask.hashCode, isNot(differentPartialTask.hashCode));{{/use_dart_mappable}}{{#use_equatable}}const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const samePartialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const differentPartialTask = PartialTask(
          name: Optional.some('new name'),
          description: Optional.some('new description'),
        );
        expect(partialTask, samePartialTask);
        expect(partialTask, isNot(differentPartialTask));
        expect(partialTask.hashCode, samePartialTask.hashCode);
        expect(partialTask.hashCode, isNot(differentPartialTask.hashCode));{{/use_equatable}}{{#use_freezed}}const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const samePartialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const differentPartialTask = PartialTask(
          name: Optional.some('new name'),
          description: Optional.some('new description'),
        );
        expect(partialTask, samePartialTask);
        expect(partialTask, isNot(differentPartialTask));
        expect(partialTask.hashCode, samePartialTask.hashCode);
        expect(partialTask.hashCode, isNot(differentPartialTask.hashCode));{{/use_freezed}}{{#use_overrides}}const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const samePartialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const differentPartialTask = PartialTask(
          name: Optional.some('new name'),
          description: Optional.some('new description'),
        );
        expect(partialTask, samePartialTask);
        expect(partialTask, isNot(differentPartialTask));
        expect(partialTask.hashCode, samePartialTask.hashCode);
        expect(partialTask.hashCode, isNot(differentPartialTask.hashCode));{{/use_overrides}}
    },
  );

  test(
    '''

GIVEN a partial task
WHEN its string representation is requested
THEN a string representation of the partial task is returned
''',
    () {
      {{#use_dart_mappable}}const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(
          partialTask.toString(),
          '''PartialTask(name: DmSome(value: name), description: DmSome(value: description))''',
        );{{/use_dart_mappable}}{{#use_equatable}}const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(
          partialTask.toString(),
          '''PartialTask(ESome<String>(name), ESome<String?>(description))''',
        );{{/use_equatable}}{{#use_freezed}}const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(
          partialTask.toString(),
          '''PartialTask(name: Optional<String>.some(value: name), description: Optional<String?>.some(value: description))''',
        );{{/use_freezed}}{{#use_overrides}}const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(
          partialTask.toString(),
          '''PartialTask(name: Some<String>(value: name), description: Some<String?>(value: description))''',
        );{{/use_overrides}}
    },
  );

  test(
    '''

GIVEN a partial task
WHEN it gets copied
THEN an new instance of the partial task is returned
├─ THAT has updated values
''',
    () {
      {{#use_dart_mappable}}const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        final fullyCopiedPartialTask = partialTask.copyWith(
          name: const Optional.some('new name'),
          description: const Optional.some('new description'),
        );
        expect(fullyCopiedPartialTask, isNotNull);
        expect(
          fullyCopiedPartialTask,
          isA<PartialTask>()
              .having((e) => e.name, 'name', const Optional.some('new name'))
              .having(
                (e) => e.description,
                'description',
                const Optional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartialTask = partialTask.copyWith();
        expect(noopCopiedPartialTask, isNotNull);
        expect(noopCopiedPartialTask, partialTask);{{/use_dart_mappable}}{{#use_equatable}}const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        final fullyCopiedPartialTask = partialTask.copyWith(
          name: const Optional.some('new name'),
          description: const Optional.some('new description'),
        );
        expect(fullyCopiedPartialTask, isNotNull);
        expect(
          fullyCopiedPartialTask,
          isA<PartialTask>()
              .having((e) => e.name, 'name', const Optional.some('new name'))
              .having(
                (e) => e.description,
                'description',
                const Optional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartialTask = partialTask.copyWith();
        expect(noopCopiedPartialTask, isNotNull);
        expect(noopCopiedPartialTask, partialTask);{{/use_equatable}}{{#use_freezed}}const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        final fullyCopiedPartialTask = partialTask.copyWith(
          name: const Optional.some('new name'),
          description: const Optional.some('new description'),
        );
        expect(fullyCopiedPartialTask, isNotNull);
        expect(
          fullyCopiedPartialTask,
          isA<PartialTask>()
              .having((e) => e.name, 'name', const Optional.some('new name'))
              .having(
                (e) => e.description,
                'description',
                const Optional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartialTask = partialTask.copyWith();
        expect(noopCopiedPartialTask, isNotNull);
        expect(noopCopiedPartialTask, partialTask);{{/use_freezed}}{{#use_overrides}}const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        final fullyCopiedPartialTask = partialTask.copyWith(
          name: const Optional.some('new name'),
          description: const Optional.some('new description'),
        );
        expect(fullyCopiedPartialTask, isNotNull);
        expect(
          fullyCopiedPartialTask,
          isA<PartialTask>()
              .having((e) => e.name, 'name', const Optional.some('new name'))
              .having(
                (e) => e.description,
                'description',
                const Optional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartialTask = partialTask.copyWith();
        expect(noopCopiedPartialTask, isNotNull);
        expect(noopCopiedPartialTask, partialTask);{{/use_overrides}}
    },
  );
}
