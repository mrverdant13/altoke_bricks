import 'package:altoke_common/common.dart';
import 'package:altoke_entity/altoke_entity.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for altoke entity
WHEN the constructor is called
THEN an instance of the altoke entity is returned
''',
    () {
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const altokeEntity = DmAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(altokeEntity, isNotNull);
        expect(altokeEntity, isA<DmAltokeEntity>());
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const altokeEntity = EAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(altokeEntity, isNotNull);
        expect(altokeEntity, isA<EAltokeEntity>());
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const altokeEntity = FAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(altokeEntity, isNotNull);
        expect(altokeEntity, isA<FAltokeEntity>());
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const altokeEntity = AltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(altokeEntity, isNotNull);
        expect(altokeEntity, isA<AltokeEntity>());
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );

  test(
    '''

GIVEN a couple of altoke entities
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
        const altokeEntity = DmAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const sameAltokeEntity = DmAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const differentAltokeEntity = DmAltokeEntity(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(altokeEntity, sameAltokeEntity);
        expect(altokeEntity, isNot(differentAltokeEntity));
        expect(altokeEntity.hashCode, sameAltokeEntity.hashCode);
        expect(altokeEntity.hashCode, isNot(differentAltokeEntity.hashCode));
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const altokeEntity = EAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const sameAltokeEntity = EAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const differentAltokeEntity = EAltokeEntity(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(altokeEntity, sameAltokeEntity);
        expect(altokeEntity, isNot(differentAltokeEntity));
        expect(altokeEntity.hashCode, sameAltokeEntity.hashCode);
        expect(altokeEntity.hashCode, isNot(differentAltokeEntity.hashCode));
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const altokeEntity = FAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const sameAltokeEntity = FAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const differentAltokeEntity = FAltokeEntity(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(altokeEntity, sameAltokeEntity);
        expect(altokeEntity, isNot(differentAltokeEntity));
        expect(altokeEntity.hashCode, sameAltokeEntity.hashCode);
        expect(altokeEntity.hashCode, isNot(differentAltokeEntity.hashCode));
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const altokeEntity = AltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const sameAltokeEntity = AltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const differentAltokeEntity = AltokeEntity(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(altokeEntity, sameAltokeEntity);
        expect(altokeEntity, isNot(differentAltokeEntity));
        expect(altokeEntity.hashCode, sameAltokeEntity.hashCode);
        expect(altokeEntity.hashCode, isNot(differentAltokeEntity.hashCode));
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );

  test(
    '''

GIVEN an altoke entity
WHEN its string representation is requested
THEN a string representation of the altoke entity is returned
''',
    () {
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const altokeEntity = DmAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(
          altokeEntity.toString(),
          'DmAltokeEntity(id: 37, name: name, description: description)',
        );
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const altokeEntity = EAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(altokeEntity.toString(), 'EAltokeEntity(37, name, description)');
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const altokeEntity = FAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(
          altokeEntity.toString(),
          'FAltokeEntity(id: 37, name: name, description: description)',
        );
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const altokeEntity = AltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(
          altokeEntity.toString(),
          'AltokeEntity(id: 37, name: name, description: description)',
        );
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );

  test(
    '''

GIVEN an altoke entity
WHEN it gets copied
THEN an new instance of the altoke entity is returned
├─ THAT has updated values
''',
    () {
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const altokeEntity = DmAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        final fullyCopiedAltokeEntity = altokeEntity.copyWith(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(fullyCopiedAltokeEntity, isNotNull);
        expect(
          fullyCopiedAltokeEntity,
          isA<DmAltokeEntity>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedAltokeEntity = altokeEntity.copyWith();
        expect(noopCopiedAltokeEntity, isNotNull);
        expect(noopCopiedAltokeEntity, altokeEntity);
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const altokeEntity = EAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        final fullyCopiedAltokeEntity = altokeEntity.copyWith(
          id: 38,
          name: 'new name',
          description: () => 'new description',
        );
        expect(fullyCopiedAltokeEntity, isNotNull);
        expect(
          fullyCopiedAltokeEntity,
          isA<EAltokeEntity>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedAltokeEntity = altokeEntity.copyWith();
        expect(noopCopiedAltokeEntity, isNotNull);
        expect(noopCopiedAltokeEntity, altokeEntity);
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const altokeEntity = FAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        final fullyCopiedAltokeEntity = altokeEntity.copyWith(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(fullyCopiedAltokeEntity, isNotNull);
        expect(
          fullyCopiedAltokeEntity,
          isA<FAltokeEntity>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedAltokeEntity = altokeEntity.copyWith();
        expect(noopCopiedAltokeEntity, isNotNull);
        expect(noopCopiedAltokeEntity, altokeEntity);
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const altokeEntity = AltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        final fullyCopiedAltokeEntity = altokeEntity.copyWith(
          id: 38,
          name: 'new name',
          description: () => 'new description',
        );
        expect(fullyCopiedAltokeEntity, isNotNull);
        expect(
          fullyCopiedAltokeEntity,
          isA<AltokeEntity>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedAltokeEntity = altokeEntity.copyWith();
        expect(noopCopiedAltokeEntity, isNotNull);
        expect(noopCopiedAltokeEntity, altokeEntity);
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );

  test(
    '''

GIVEN a constructor for a new altoke entity
WHEN the constructor is called
THEN an instance of the new altoke entity is returned
''',
    () {
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const newAltokeEntity = DmNewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(newAltokeEntity, isNotNull);
        expect(newAltokeEntity, isA<DmNewAltokeEntity>());
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const newAltokeEntity = ENewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(newAltokeEntity, isNotNull);
        expect(newAltokeEntity, isA<ENewAltokeEntity>());
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const newAltokeEntity = FNewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(newAltokeEntity, isNotNull);
        expect(newAltokeEntity, isA<FNewAltokeEntity>());
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const newAltokeEntity = NewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(newAltokeEntity, isNotNull);
        expect(newAltokeEntity, isA<NewAltokeEntity>());
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );

  test(
    '''

GIVEN a couple of new altoke entities
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
        const newAltokeEntity = DmNewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        const sameNewAltokeEntity = DmNewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        const differentNewAltokeEntity = DmNewAltokeEntity(
          name: 'new name',
          description: 'new description',
        );
        expect(newAltokeEntity, sameNewAltokeEntity);
        expect(newAltokeEntity, isNot(differentNewAltokeEntity));
        expect(newAltokeEntity.hashCode, sameNewAltokeEntity.hashCode);
        expect(
          newAltokeEntity.hashCode,
          isNot(differentNewAltokeEntity.hashCode),
        );
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const newAltokeEntity = ENewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        const sameNewAltokeEntity = ENewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        const differentNewAltokeEntity = ENewAltokeEntity(
          name: 'new name',
          description: 'new description',
        );
        expect(newAltokeEntity, sameNewAltokeEntity);
        expect(newAltokeEntity, isNot(differentNewAltokeEntity));
        expect(newAltokeEntity.hashCode, sameNewAltokeEntity.hashCode);
        expect(
          newAltokeEntity.hashCode,
          isNot(differentNewAltokeEntity.hashCode),
        );
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const newAltokeEntity = FNewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        const sameNewAltokeEntity = FNewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        const differentNewAltokeEntity = FNewAltokeEntity(
          name: 'new name',
          description: 'new description',
        );
        expect(newAltokeEntity, sameNewAltokeEntity);
        expect(newAltokeEntity, isNot(differentNewAltokeEntity));
        expect(newAltokeEntity.hashCode, sameNewAltokeEntity.hashCode);
        expect(
          newAltokeEntity.hashCode,
          isNot(differentNewAltokeEntity.hashCode),
        );
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const newAltokeEntity = NewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        const sameNewAltokeEntity = NewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        const differentNewAltokeEntity = NewAltokeEntity(
          name: 'new name',
          description: 'new description',
        );
        expect(newAltokeEntity, sameNewAltokeEntity);
        expect(newAltokeEntity, isNot(differentNewAltokeEntity));
        expect(newAltokeEntity.hashCode, sameNewAltokeEntity.hashCode);
        expect(
          newAltokeEntity.hashCode,
          isNot(differentNewAltokeEntity.hashCode),
        );
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );

  test(
    '''

GIVEN a new altoke entity
WHEN its string representation is requested
THEN a string representation of the new altoke entity is returned
''',
    () {
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const newAltokeEntity = DmNewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(
          newAltokeEntity.toString(),
          'DmNewAltokeEntity(name: name, description: description)',
        );
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const newAltokeEntity = ENewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(
          newAltokeEntity.toString(),
          'ENewAltokeEntity(name, description)',
        );
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const newAltokeEntity = FNewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(
          newAltokeEntity.toString(),
          'FNewAltokeEntity(name: name, description: description)',
        );
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const newAltokeEntity = NewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(
          newAltokeEntity.toString(),
          'NewAltokeEntity(name: name, description: description)',
        );
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );

  test(
    '''

GIVEN a new altoke entity
WHEN it gets copied
THEN an new instance of the new altoke entity is returned
├─ THAT has updated values
''',
    () {
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const newAltokeEntity = DmNewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        final fullyCopiedNewAltokeEntity = newAltokeEntity.copyWith(
          name: 'new name',
          description: 'new description',
        );
        expect(fullyCopiedNewAltokeEntity, isNotNull);
        expect(
          fullyCopiedNewAltokeEntity,
          isA<DmNewAltokeEntity>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedNewAltokeEntity = newAltokeEntity.copyWith();
        expect(noopCopiedNewAltokeEntity, isNotNull);
        expect(noopCopiedNewAltokeEntity, newAltokeEntity);
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const newAltokeEntity = ENewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        final fullyCopiedNewAltokeEntity = newAltokeEntity.copyWith(
          name: 'new name',
          description: () => 'new description',
        );
        expect(fullyCopiedNewAltokeEntity, isNotNull);
        expect(
          fullyCopiedNewAltokeEntity,
          isA<ENewAltokeEntity>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedNewAltokeEntity = newAltokeEntity.copyWith();
        expect(noopCopiedNewAltokeEntity, isNotNull);
        expect(noopCopiedNewAltokeEntity, newAltokeEntity);
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const newAltokeEntity = FNewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        final fullyCopiedNewAltokeEntity = newAltokeEntity.copyWith(
          name: 'new name',
          description: 'new description',
        );
        expect(fullyCopiedNewAltokeEntity, isNotNull);
        expect(
          fullyCopiedNewAltokeEntity,
          isA<FNewAltokeEntity>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedNewAltokeEntity = newAltokeEntity.copyWith();
        expect(noopCopiedNewAltokeEntity, isNotNull);
        expect(noopCopiedNewAltokeEntity, newAltokeEntity);
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const newAltokeEntity = NewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        final fullyCopiedNewAltokeEntity = newAltokeEntity.copyWith(
          name: 'new name',
          description: () => 'new description',
        );
        expect(fullyCopiedNewAltokeEntity, isNotNull);
        expect(
          fullyCopiedNewAltokeEntity,
          isA<NewAltokeEntity>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedNewAltokeEntity = newAltokeEntity.copyWith();
        expect(noopCopiedNewAltokeEntity, isNotNull);
        expect(noopCopiedNewAltokeEntity, newAltokeEntity);
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );

  test(
    '''

GIVEN a constructor for a partial altoke entity
WHEN the constructor is called
THEN an instance of the partial altoke entity is returned
''',
    () {
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const partialAltokeEntity = DmPartialAltokeEntity(
          name: DmOptional.some('name'),
          description: DmOptional.some('description'),
        );
        expect(partialAltokeEntity, isNotNull);
        expect(partialAltokeEntity, isA<DmPartialAltokeEntity>());
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const partialAltokeEntity = EPartialAltokeEntity(
          name: EOptional.some('name'),
          description: EOptional.some('description'),
        );
        expect(partialAltokeEntity, isNotNull);
        expect(partialAltokeEntity, isA<EPartialAltokeEntity>());
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const partialAltokeEntity = FPartialAltokeEntity(
          name: FOptional.some('name'),
          description: FOptional.some('description'),
        );
        expect(partialAltokeEntity, isNotNull);
        expect(partialAltokeEntity, isA<FPartialAltokeEntity>());
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const partialAltokeEntity = PartialAltokeEntity(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(partialAltokeEntity, isNotNull);
        expect(partialAltokeEntity, isA<PartialAltokeEntity>());
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );

  test(
    '''

GIVEN a couple of partial altoke entities
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
        const partialAltokeEntity = DmPartialAltokeEntity(
          name: DmOptional.some('name'),
          description: DmOptional.some('description'),
        );
        const samePartialAltokeEntity = DmPartialAltokeEntity(
          name: DmOptional.some('name'),
          description: DmOptional.some('description'),
        );
        const differentPartialAltokeEntity = DmPartialAltokeEntity(
          name: DmOptional.some('new name'),
          description: DmOptional.some('new description'),
        );
        expect(partialAltokeEntity, samePartialAltokeEntity);
        expect(partialAltokeEntity, isNot(differentPartialAltokeEntity));
        expect(partialAltokeEntity.hashCode, samePartialAltokeEntity.hashCode);
        expect(
          partialAltokeEntity.hashCode,
          isNot(differentPartialAltokeEntity.hashCode),
        );
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const partialAltokeEntity = EPartialAltokeEntity(
          name: EOptional.some('name'),
          description: EOptional.some('description'),
        );
        const samePartialAltokeEntity = EPartialAltokeEntity(
          name: EOptional.some('name'),
          description: EOptional.some('description'),
        );
        const differentPartialAltokeEntity = EPartialAltokeEntity(
          name: EOptional.some('new name'),
          description: EOptional.some('new description'),
        );
        expect(partialAltokeEntity, samePartialAltokeEntity);
        expect(partialAltokeEntity, isNot(differentPartialAltokeEntity));
        expect(partialAltokeEntity.hashCode, samePartialAltokeEntity.hashCode);
        expect(
          partialAltokeEntity.hashCode,
          isNot(differentPartialAltokeEntity.hashCode),
        );
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const partialAltokeEntity = FPartialAltokeEntity(
          name: FOptional.some('name'),
          description: FOptional.some('description'),
        );
        const samePartialAltokeEntity = FPartialAltokeEntity(
          name: FOptional.some('name'),
          description: FOptional.some('description'),
        );
        const differentPartialAltokeEntity = FPartialAltokeEntity(
          name: FOptional.some('new name'),
          description: FOptional.some('new description'),
        );
        expect(partialAltokeEntity, samePartialAltokeEntity);
        expect(partialAltokeEntity, isNot(differentPartialAltokeEntity));
        expect(partialAltokeEntity.hashCode, samePartialAltokeEntity.hashCode);
        expect(
          partialAltokeEntity.hashCode,
          isNot(differentPartialAltokeEntity.hashCode),
        );
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const partialAltokeEntity = PartialAltokeEntity(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const samePartialAltokeEntity = PartialAltokeEntity(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const differentPartialAltokeEntity = PartialAltokeEntity(
          name: Optional.some('new name'),
          description: Optional.some('new description'),
        );
        expect(partialAltokeEntity, samePartialAltokeEntity);
        expect(partialAltokeEntity, isNot(differentPartialAltokeEntity));
        expect(partialAltokeEntity.hashCode, samePartialAltokeEntity.hashCode);
        expect(
          partialAltokeEntity.hashCode,
          isNot(differentPartialAltokeEntity.hashCode),
        );
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );

  test(
    '''

GIVEN a partial altoke entity
WHEN its string representation is requested
THEN a string representation of the partial altoke entity is returned
''',
    () {
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const partialAltokeEntity = DmPartialAltokeEntity(
          name: DmOptional.some('name'),
          description: DmOptional.some('description'),
        );
        expect(
          partialAltokeEntity.toString(),
          '''DmPartialAltokeEntity(name: DmSome(value: name), description: DmSome(value: description))''',
        );
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const partialAltokeEntity = EPartialAltokeEntity(
          name: EOptional.some('name'),
          description: EOptional.some('description'),
        );
        expect(
          partialAltokeEntity.toString(),
          '''EPartialAltokeEntity(ESome<String>(name), ESome<String?>(description))''',
        );
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const partialAltokeEntity = FPartialAltokeEntity(
          name: FOptional.some('name'),
          description: FOptional.some('description'),
        );
        expect(
          partialAltokeEntity.toString(),
          '''FPartialAltokeEntity(name: FOptional<String>.some(value: name), description: FOptional<String?>.some(value: description))''',
        );
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const partialAltokeEntity = PartialAltokeEntity(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(
          partialAltokeEntity.toString(),
          '''PartialAltokeEntity(name: Some<String>(value: name), description: Some<String?>(value: description))''',
        );
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );

  test(
    '''

GIVEN a partial altoke entity
WHEN it gets copied
THEN an new instance of the partial altoke entity is returned
├─ THAT has updated values
''',
    () {
      /*remove-start*/
      {
        /*remove-end-x*/
        /*{{#use_dart_mappable}}x*/
        const partialAltokeEntity = DmPartialAltokeEntity(
          name: DmOptional.some('name'),
          description: DmOptional.some('description'),
        );
        final fullyCopiedPartialAltokeEntity = partialAltokeEntity.copyWith(
          name: const DmOptional.some('new name'),
          description: const DmOptional.some('new description'),
        );
        expect(fullyCopiedPartialAltokeEntity, isNotNull);
        expect(
          fullyCopiedPartialAltokeEntity,
          isA<DmPartialAltokeEntity>()
              .having((e) => e.name, 'name', const DmOptional.some('new name'))
              .having(
                (e) => e.description,
                'description',
                const DmOptional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartialAltokeEntity = partialAltokeEntity.copyWith();
        expect(noopCopiedPartialAltokeEntity, isNotNull);
        expect(noopCopiedPartialAltokeEntity, partialAltokeEntity);
        /*x{{/use_dart_mappable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_equatable}}x*/
        const partialAltokeEntity = EPartialAltokeEntity(
          name: EOptional.some('name'),
          description: EOptional.some('description'),
        );
        final fullyCopiedPartialAltokeEntity = partialAltokeEntity.copyWith(
          name: const EOptional.some('new name'),
          description: const EOptional.some('new description'),
        );
        expect(fullyCopiedPartialAltokeEntity, isNotNull);
        expect(
          fullyCopiedPartialAltokeEntity,
          isA<EPartialAltokeEntity>()
              .having((e) => e.name, 'name', const EOptional.some('new name'))
              .having(
                (e) => e.description,
                'description',
                const EOptional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartialAltokeEntity = partialAltokeEntity.copyWith();
        expect(noopCopiedPartialAltokeEntity, isNotNull);
        expect(noopCopiedPartialAltokeEntity, partialAltokeEntity);
        /*x{{/use_equatable}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_freezed}}x*/
        const partialAltokeEntity = FPartialAltokeEntity(
          name: FOptional.some('name'),
          description: FOptional.some('description'),
        );
        final fullyCopiedPartialAltokeEntity = partialAltokeEntity.copyWith(
          name: const FOptional.some('new name'),
          description: const FOptional.some('new description'),
        );
        expect(fullyCopiedPartialAltokeEntity, isNotNull);
        expect(
          fullyCopiedPartialAltokeEntity,
          isA<FPartialAltokeEntity>()
              .having((e) => e.name, 'name', const FOptional.some('new name'))
              .having(
                (e) => e.description,
                'description',
                const FOptional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartialAltokeEntity = partialAltokeEntity.copyWith();
        expect(noopCopiedPartialAltokeEntity, isNotNull);
        expect(noopCopiedPartialAltokeEntity, partialAltokeEntity);
        /*x{{/use_freezed}}x*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*x{{#use_overrides}}x*/
        const partialAltokeEntity = PartialAltokeEntity(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        final fullyCopiedPartialAltokeEntity = partialAltokeEntity.copyWith(
          name: const Optional.some('new name'),
          description: const Optional.some('new description'),
        );
        expect(fullyCopiedPartialAltokeEntity, isNotNull);
        expect(
          fullyCopiedPartialAltokeEntity,
          isA<PartialAltokeEntity>()
              .having((e) => e.name, 'name', const Optional.some('new name'))
              .having(
                (e) => e.description,
                'description',
                const Optional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartialAltokeEntity = partialAltokeEntity.copyWith();
        expect(noopCopiedPartialAltokeEntity, isNotNull);
        expect(noopCopiedPartialAltokeEntity, partialAltokeEntity);
        /*x{{/use_overrides}}*/
        /*x-remove-start*/
      }
      /*remove-end*/
    },
  );
}
