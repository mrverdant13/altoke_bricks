import 'package:altoke_common/common.dart';
import 'package:altoke_entities/altoke_entities.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for task
WHEN the constructor is called
THEN an instance of the task is returned
''',
    () {
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const task = DmTask(id: 37, name: 'name', description: 'description');
        expect(task, isNotNull);
        expect(task, isA<DmTask>());
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const task = ETask(id: 37, name: 'name', description: 'description');
        expect(task, isNotNull);
        expect(task, isA<ETask>());
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const task = FTask(id: 37, name: 'name', description: 'description');
        expect(task, isNotNull);
        expect(task, isA<FTask>());
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const task = Task(id: 37, name: 'name', description: 'description');
        expect(task, isNotNull);
        expect(task, isA<Task>());
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
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
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const task = DmTask(id: 37, name: 'name', description: 'description');
        const sameTask = DmTask(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const differentTask = DmTask(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(task, sameTask);
        expect(task, isNot(differentTask));
        expect(task.hashCode, sameTask.hashCode);
        expect(task.hashCode, isNot(differentTask.hashCode));
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const task = ETask(id: 37, name: 'name', description: 'description');
        const sameTask = ETask(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const differentTask = ETask(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(task, sameTask);
        expect(task, isNot(differentTask));
        expect(task.hashCode, sameTask.hashCode);
        expect(task.hashCode, isNot(differentTask.hashCode));
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const task = FTask(id: 37, name: 'name', description: 'description');
        const sameTask = FTask(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const differentTask = FTask(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(task, sameTask);
        expect(task, isNot(differentTask));
        expect(task.hashCode, sameTask.hashCode);
        expect(task.hashCode, isNot(differentTask.hashCode));
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const task = Task(id: 37, name: 'name', description: 'description');
        const sameTask = Task(id: 37, name: 'name', description: 'description');
        const differentTask = Task(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(task, sameTask);
        expect(task, isNot(differentTask));
        expect(task.hashCode, sameTask.hashCode);
        expect(task.hashCode, isNot(differentTask.hashCode));
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );

  test(
    '''

GIVEN an task
WHEN its string representation is requested
THEN a string representation of the task is returned
''',
    () {
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const task = DmTask(id: 37, name: 'name', description: 'description');
        expect(
          task.toString(),
          'DmTask(id: 37, name: name, description: description)',
        );
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const task = ETask(id: 37, name: 'name', description: 'description');
        expect(task.toString(), 'ETask(37, name, description)');
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const task = FTask(id: 37, name: 'name', description: 'description');
        expect(
          task.toString(),
          'FTask(id: 37, name: name, description: description)',
        );
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const task = Task(id: 37, name: 'name', description: 'description');
        expect(
          task.toString(),
          'Task(id: 37, name: name, description: description)',
        );
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
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
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const task = DmTask(id: 37, name: 'name', description: 'description');
        final fullyCopiedTask = task.copyWith(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(fullyCopiedTask, isNotNull);
        expect(
          fullyCopiedTask,
          isA<DmTask>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedTask = task.copyWith();
        expect(noopCopiedTask, isNotNull);
        expect(noopCopiedTask, task);
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const task = ETask(id: 37, name: 'name', description: 'description');
        final fullyCopiedTask = task.copyWith(
          id: 38,
          name: 'new name',
          description: () => 'new description',
        );
        expect(fullyCopiedTask, isNotNull);
        expect(
          fullyCopiedTask,
          isA<ETask>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedTask = task.copyWith();
        expect(noopCopiedTask, isNotNull);
        expect(noopCopiedTask, task);
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const task = FTask(id: 37, name: 'name', description: 'description');
        final fullyCopiedTask = task.copyWith(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(fullyCopiedTask, isNotNull);
        expect(
          fullyCopiedTask,
          isA<FTask>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedTask = task.copyWith();
        expect(noopCopiedTask, isNotNull);
        expect(noopCopiedTask, task);
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const task = Task(id: 37, name: 'name', description: 'description');
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
        expect(noopCopiedTask, task);
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );

  test(
    '''

GIVEN a constructor for a new task
WHEN the constructor is called
THEN an instance of the new task is returned
''',
    () {
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const newTask = DmNewTask(name: 'name', description: 'description');
        expect(newTask, isNotNull);
        expect(newTask, isA<DmNewTask>());
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const newTask = ENewTask(name: 'name', description: 'description');
        expect(newTask, isNotNull);
        expect(newTask, isA<ENewTask>());
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const newTask = FNewTask(name: 'name', description: 'description');
        expect(newTask, isNotNull);
        expect(newTask, isA<FNewTask>());
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const newTask = NewTask(name: 'name', description: 'description');
        expect(newTask, isNotNull);
        expect(newTask, isA<NewTask>());
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
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
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const newTask = DmNewTask(name: 'name', description: 'description');
        const sameNewTask = DmNewTask(name: 'name', description: 'description');
        const differentNewTask = DmNewTask(
          name: 'new name',
          description: 'new description',
        );
        expect(newTask, sameNewTask);
        expect(newTask, isNot(differentNewTask));
        expect(newTask.hashCode, sameNewTask.hashCode);
        expect(newTask.hashCode, isNot(differentNewTask.hashCode));
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const newTask = ENewTask(name: 'name', description: 'description');
        const sameNewTask = ENewTask(name: 'name', description: 'description');
        const differentNewTask = ENewTask(
          name: 'new name',
          description: 'new description',
        );
        expect(newTask, sameNewTask);
        expect(newTask, isNot(differentNewTask));
        expect(newTask.hashCode, sameNewTask.hashCode);
        expect(newTask.hashCode, isNot(differentNewTask.hashCode));
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const newTask = FNewTask(name: 'name', description: 'description');
        const sameNewTask = FNewTask(name: 'name', description: 'description');
        const differentNewTask = FNewTask(
          name: 'new name',
          description: 'new description',
        );
        expect(newTask, sameNewTask);
        expect(newTask, isNot(differentNewTask));
        expect(newTask.hashCode, sameNewTask.hashCode);
        expect(newTask.hashCode, isNot(differentNewTask.hashCode));
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const newTask = NewTask(name: 'name', description: 'description');
        const sameNewTask = NewTask(name: 'name', description: 'description');
        const differentNewTask = NewTask(
          name: 'new name',
          description: 'new description',
        );
        expect(newTask, sameNewTask);
        expect(newTask, isNot(differentNewTask));
        expect(newTask.hashCode, sameNewTask.hashCode);
        expect(newTask.hashCode, isNot(differentNewTask.hashCode));
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );

  test(
    '''

GIVEN a new task
WHEN its string representation is requested
THEN a string representation of the new task is returned
''',
    () {
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const newTask = DmNewTask(name: 'name', description: 'description');
        expect(
          newTask.toString(),
          'DmNewTask(name: name, description: description)',
        );
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const newTask = ENewTask(name: 'name', description: 'description');
        expect(newTask.toString(), 'ENewTask(name, description)');
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const newTask = FNewTask(name: 'name', description: 'description');
        expect(
          newTask.toString(),
          'FNewTask(name: name, description: description)',
        );
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const newTask = NewTask(name: 'name', description: 'description');
        expect(
          newTask.toString(),
          'NewTask(name: name, description: description)',
        );
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
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
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const newTask = DmNewTask(name: 'name', description: 'description');
        final fullyCopiedNewTask = newTask.copyWith(
          name: 'new name',
          description: 'new description',
        );
        expect(fullyCopiedNewTask, isNotNull);
        expect(
          fullyCopiedNewTask,
          isA<DmNewTask>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedNewTask = newTask.copyWith();
        expect(noopCopiedNewTask, isNotNull);
        expect(noopCopiedNewTask, newTask);
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const newTask = ENewTask(name: 'name', description: 'description');
        final fullyCopiedNewTask = newTask.copyWith(
          name: 'new name',
          description: () => 'new description',
        );
        expect(fullyCopiedNewTask, isNotNull);
        expect(
          fullyCopiedNewTask,
          isA<ENewTask>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedNewTask = newTask.copyWith();
        expect(noopCopiedNewTask, isNotNull);
        expect(noopCopiedNewTask, newTask);
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const newTask = FNewTask(name: 'name', description: 'description');
        final fullyCopiedNewTask = newTask.copyWith(
          name: 'new name',
          description: 'new description',
        );
        expect(fullyCopiedNewTask, isNotNull);
        expect(
          fullyCopiedNewTask,
          isA<FNewTask>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedNewTask = newTask.copyWith();
        expect(noopCopiedNewTask, isNotNull);
        expect(noopCopiedNewTask, newTask);
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const newTask = NewTask(name: 'name', description: 'description');
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
        expect(noopCopiedNewTask, newTask);
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );

  test(
    '''

GIVEN a constructor for a partial task
WHEN the constructor is called
THEN an instance of the partial task is returned
''',
    () {
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const partialTask = DmPartialTask(
          name: DmOptional.some('name'),
          description: DmOptional.some('description'),
        );
        expect(partialTask, isNotNull);
        expect(partialTask, isA<DmPartialTask>());
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const partialTask = EPartialTask(
          name: EOptional.some('name'),
          description: EOptional.some('description'),
        );
        expect(partialTask, isNotNull);
        expect(partialTask, isA<EPartialTask>());
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const partialTask = FPartialTask(
          name: FOptional.some('name'),
          description: FOptional.some('description'),
        );
        expect(partialTask, isNotNull);
        expect(partialTask, isA<FPartialTask>());
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(partialTask, isNotNull);
        expect(partialTask, isA<PartialTask>());
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
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
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const partialTask = DmPartialTask(
          name: DmOptional.some('name'),
          description: DmOptional.some('description'),
        );
        const samePartialTask = DmPartialTask(
          name: DmOptional.some('name'),
          description: DmOptional.some('description'),
        );
        const differentPartialTask = DmPartialTask(
          name: DmOptional.some('new name'),
          description: DmOptional.some('new description'),
        );
        expect(partialTask, samePartialTask);
        expect(partialTask, isNot(differentPartialTask));
        expect(partialTask.hashCode, samePartialTask.hashCode);
        expect(partialTask.hashCode, isNot(differentPartialTask.hashCode));
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const partialTask = EPartialTask(
          name: EOptional.some('name'),
          description: EOptional.some('description'),
        );
        const samePartialTask = EPartialTask(
          name: EOptional.some('name'),
          description: EOptional.some('description'),
        );
        const differentPartialTask = EPartialTask(
          name: EOptional.some('new name'),
          description: EOptional.some('new description'),
        );
        expect(partialTask, samePartialTask);
        expect(partialTask, isNot(differentPartialTask));
        expect(partialTask.hashCode, samePartialTask.hashCode);
        expect(partialTask.hashCode, isNot(differentPartialTask.hashCode));
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const partialTask = FPartialTask(
          name: FOptional.some('name'),
          description: FOptional.some('description'),
        );
        const samePartialTask = FPartialTask(
          name: FOptional.some('name'),
          description: FOptional.some('description'),
        );
        const differentPartialTask = FPartialTask(
          name: FOptional.some('new name'),
          description: FOptional.some('new description'),
        );
        expect(partialTask, samePartialTask);
        expect(partialTask, isNot(differentPartialTask));
        expect(partialTask.hashCode, samePartialTask.hashCode);
        expect(partialTask.hashCode, isNot(differentPartialTask.hashCode));
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const partialTask = PartialTask(
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
        expect(partialTask.hashCode, isNot(differentPartialTask.hashCode));
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );

  test(
    '''

GIVEN a partial task
WHEN its string representation is requested
THEN a string representation of the partial task is returned
''',
    () {
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const partialTask = DmPartialTask(
          name: DmOptional.some('name'),
          description: DmOptional.some('description'),
        );
        expect(
          partialTask.toString(),
          matches(
            r'DmPartialTask\(name: DmSome\(value: name, hashCode: \d+\), description: DmSome\(value: description, hashCode: \d+\)\)',
          ),
        );
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const partialTask = EPartialTask(
          name: EOptional.some('name'),
          description: EOptional.some('description'),
        );
        expect(
          partialTask.toString(),
          '''EPartialTask(ESome<String>(name), ESome<String?>(description))''',
        );
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const partialTask = FPartialTask(
          name: FOptional.some('name'),
          description: FOptional.some('description'),
        );
        expect(
          partialTask.toString(),
          '''FPartialTask(name: FOptional<String>.some(value: name), description: FOptional<String?>.some(value: description))''',
        );
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const partialTask = PartialTask(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(
          partialTask.toString(),
          '''PartialTask(name: Some<String>(value: name), description: Some<String?>(value: description))''',
        );
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
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
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const partialTask = DmPartialTask(
          name: DmOptional.some('name'),
          description: DmOptional.some('description'),
        );
        final fullyCopiedPartialTask = partialTask.copyWith(
          name: const DmOptional.some('new name'),
          description: const DmOptional.some('new description'),
        );
        expect(fullyCopiedPartialTask, isNotNull);
        expect(
          fullyCopiedPartialTask,
          isA<DmPartialTask>()
              .having((e) => e.name, 'name', const DmOptional.some('new name'))
              .having(
                (e) => e.description,
                'description',
                const DmOptional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartialTask = partialTask.copyWith();
        expect(noopCopiedPartialTask, isNotNull);
        expect(noopCopiedPartialTask, partialTask);
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const partialTask = EPartialTask(
          name: EOptional.some('name'),
          description: EOptional.some('description'),
        );
        final fullyCopiedPartialTask = partialTask.copyWith(
          name: const EOptional.some('new name'),
          description: const EOptional.some('new description'),
        );
        expect(fullyCopiedPartialTask, isNotNull);
        expect(
          fullyCopiedPartialTask,
          isA<EPartialTask>()
              .having((e) => e.name, 'name', const EOptional.some('new name'))
              .having(
                (e) => e.description,
                'description',
                const EOptional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartialTask = partialTask.copyWith();
        expect(noopCopiedPartialTask, isNotNull);
        expect(noopCopiedPartialTask, partialTask);
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const partialTask = FPartialTask(
          name: FOptional.some('name'),
          description: FOptional.some('description'),
        );
        final fullyCopiedPartialTask = partialTask.copyWith(
          name: const FOptional.some('new name'),
          description: const FOptional.some('new description'),
        );
        expect(fullyCopiedPartialTask, isNotNull);
        expect(
          fullyCopiedPartialTask,
          isA<FPartialTask>()
              .having((e) => e.name, 'name', const FOptional.some('new name'))
              .having(
                (e) => e.description,
                'description',
                const FOptional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartialTask = partialTask.copyWith();
        expect(noopCopiedPartialTask, isNotNull);
        expect(noopCopiedPartialTask, partialTask);
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const partialTask = PartialTask(
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
        expect(noopCopiedPartialTask, partialTask);
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );
}
