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
      /*w 1v w*/
      /*remove-start*/
      {
        /*remove-end*/
        /*{{#use_dart_mappable}}*/
        const altokeEntity = DmAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(altokeEntity, isNotNull);
        expect(altokeEntity, isA<DmAltokeEntity>());
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const altokeEntity = EAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(altokeEntity, isNotNull);
        expect(altokeEntity, isA<EAltokeEntity>());
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
        const altokeEntity = FAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(altokeEntity, isNotNull);
        expect(altokeEntity, isA<FAltokeEntity>());
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
        const altokeEntity = AltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(altokeEntity, isNotNull);
        expect(altokeEntity, isA<AltokeEntity>());
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
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
      /*w 1v w*/
      /*remove-start*/
      {
        /*remove-end*/
        /*{{#use_dart_mappable}}*/
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
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
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
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
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
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
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
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
    },
  );

  test(
    '''

GIVEN an altoke entity
WHEN its string representation is requested
THEN a string representation of the altoke entity is returned
''',
    () {
      /*w 1v w*/
      /*remove-start*/
      {
        /*remove-end*/
        /*{{#use_dart_mappable}}*/
        const altokeEntity = DmAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(
          altokeEntity.toString(),
          'DmAltokeEntity(id: 37, name: name, description: description)',
        );
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const altokeEntity = EAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(
          altokeEntity.toString(),
          'EAltokeEntity(37, name, description)',
        );
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
        const altokeEntity = FAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(
          altokeEntity.toString(),
          'FAltokeEntity(id: 37, name: name, description: description)',
        );
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
        const altokeEntity = AltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(
          altokeEntity.toString(),
          'AltokeEntity(id: 37, name: name, description: description)',
        );
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
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
      /*w 1v w*/
      /*remove-start*/
      {
        /*remove-end*/
        /*{{#use_dart_mappable}}*/
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
        expect(
          noopCopiedAltokeEntity,
          altokeEntity,
        );
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
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
        expect(
          noopCopiedAltokeEntity,
          altokeEntity,
        );
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
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
        expect(
          noopCopiedAltokeEntity,
          altokeEntity,
        );
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
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
        expect(
          noopCopiedAltokeEntity,
          altokeEntity,
        );
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
    },
  );

  test(
    '''

GIVEN a constructor for a new altoke entity
WHEN the constructor is called
THEN an instance of the new altoke entity is returned
''',
    () {
      /*w 1v w*/
      /*remove-start*/
      {
        /*remove-end*/
        /*{{#use_dart_mappable}}*/
        const newAltokeEntity = DmNewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(newAltokeEntity, isNotNull);
        expect(newAltokeEntity, isA<DmNewAltokeEntity>());
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const newAltokeEntity = ENewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(newAltokeEntity, isNotNull);
        expect(newAltokeEntity, isA<ENewAltokeEntity>());
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
        const newAltokeEntity = FNewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(newAltokeEntity, isNotNull);
        expect(newAltokeEntity, isA<FNewAltokeEntity>());
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
        const newAltokeEntity = NewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(newAltokeEntity, isNotNull);
        expect(newAltokeEntity, isA<NewAltokeEntity>());
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
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
      /*w 1v w*/
      /*remove-start*/
      {
        /*remove-end*/
        /*{{#use_dart_mappable}}*/
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
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
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
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
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
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
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
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
    },
  );

  test(
    '''

GIVEN a new altoke entity
WHEN its string representation is requested
THEN a string representation of the new altoke entity is returned
''',
    () {
      /*w 1v w*/
      /*remove-start*/
      {
        /*remove-end*/
        /*{{#use_dart_mappable}}*/
        const newAltokeEntity = DmNewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(
          newAltokeEntity.toString(),
          'DmNewAltokeEntity(name: name, description: description)',
        );
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const newAltokeEntity = ENewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(
          newAltokeEntity.toString(),
          'ENewAltokeEntity(name, description)',
        );
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
        const newAltokeEntity = FNewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(
          newAltokeEntity.toString(),
          'FNewAltokeEntity(name: name, description: description)',
        );
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
        const newAltokeEntity = NewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(
          newAltokeEntity.toString(),
          'NewAltokeEntity(name: name, description: description)',
        );
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
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
      /*w 1v w*/
      /*remove-start*/
      {
        /*remove-end*/
        /*{{#use_dart_mappable}}*/
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
        expect(
          noopCopiedNewAltokeEntity,
          newAltokeEntity,
        );
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
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
        expect(
          noopCopiedNewAltokeEntity,
          newAltokeEntity,
        );
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
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
        expect(
          noopCopiedNewAltokeEntity,
          newAltokeEntity,
        );
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
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
        expect(
          noopCopiedNewAltokeEntity,
          newAltokeEntity,
        );
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
    },
  );

  test(
    '''

GIVEN a constructor for a partial altoke entity
WHEN the constructor is called
THEN an instance of the partial altoke entity is returned
''',
    () {
      /*w 1v w*/
      /*remove-start*/
      {
        /*remove-end*/
        /*{{#use_dart_mappable}}*/
        const partialAltokeEntity = DmPartialAltokeEntity(
          name: DmOptional.some('name'),
          description: DmOptional.some('description'),
        );
        expect(partialAltokeEntity, isNotNull);
        expect(partialAltokeEntity, isA<DmPartialAltokeEntity>());
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const partialAltokeEntity = EPartialAltokeEntity(
          name: EOptional.some('name'),
          description: EOptional.some('description'),
        );
        expect(partialAltokeEntity, isNotNull);
        expect(partialAltokeEntity, isA<EPartialAltokeEntity>());
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
        const partialAltokeEntity = FPartialAltokeEntity(
          name: FOptional.some('name'),
          description: FOptional.some('description'),
        );
        expect(partialAltokeEntity, isNotNull);
        expect(partialAltokeEntity, isA<FPartialAltokeEntity>());
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
        const partialAltokeEntity = PartialAltokeEntity(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(partialAltokeEntity, isNotNull);
        expect(partialAltokeEntity, isA<PartialAltokeEntity>());
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
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
      /*w 1v w*/
      /*remove-start*/
      {
        /*remove-end*/
        /*{{#use_dart_mappable}}*/
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
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
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
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
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
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
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
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
    },
  );

  test(
    '''

GIVEN a partial altoke entity
WHEN its string representation is requested
THEN a string representation of the partial altoke entity is returned
''',
    () {
      /*w 1v w*/
      /*remove-start*/
      {
        /*remove-end*/
        /*{{#use_dart_mappable}}*/
        const partialAltokeEntity = DmPartialAltokeEntity(
          name: DmOptional.some('name'),
          description: DmOptional.some('description'),
        );
        expect(
          partialAltokeEntity.toString(),
          '''DmPartialAltokeEntity(name: DmSome(value: name), description: DmSome(value: description))''',
        );
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const partialAltokeEntity = EPartialAltokeEntity(
          name: EOptional.some('name'),
          description: EOptional.some('description'),
        );
        expect(
          partialAltokeEntity.toString(),
          '''EPartialAltokeEntity(ESome<String>(name), ESome<String?>(description))''',
        );
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
        const partialAltokeEntity = FPartialAltokeEntity(
          name: FOptional.some('name'),
          description: FOptional.some('description'),
        );
        expect(
          partialAltokeEntity.toString(),
          '''FPartialAltokeEntity(name: FOptional<String>.some(value: name), description: FOptional<String?>.some(value: description))''',
        );
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
        const partialAltokeEntity = PartialAltokeEntity(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(
          partialAltokeEntity.toString(),
          '''PartialAltokeEntity(name: Some<String>(value: name), description: Some<String?>(value: description))''',
        );
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
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
      /*w 1v w*/
      /*remove-start*/
      {
        /*remove-end*/
        /*{{#use_dart_mappable}}*/
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
              .having(
                (e) => e.name,
                'name',
                const DmOptional.some('new name'),
              )
              .having(
                (e) => e.description,
                'description',
                const DmOptional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartialAltokeEntity = partialAltokeEntity.copyWith();
        expect(noopCopiedPartialAltokeEntity, isNotNull);
        expect(
          noopCopiedPartialAltokeEntity,
          partialAltokeEntity,
        );
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
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
              .having(
                (e) => e.name,
                'name',
                const EOptional.some('new name'),
              )
              .having(
                (e) => e.description,
                'description',
                const EOptional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartialAltokeEntity = partialAltokeEntity.copyWith();
        expect(noopCopiedPartialAltokeEntity, isNotNull);
        expect(
          noopCopiedPartialAltokeEntity,
          partialAltokeEntity,
        );
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
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
              .having(
                (e) => e.name,
                'name',
                const FOptional.some('new name'),
              )
              .having(
                (e) => e.description,
                'description',
                const FOptional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartialAltokeEntity = partialAltokeEntity.copyWith();
        expect(noopCopiedPartialAltokeEntity, isNotNull);
        expect(
          noopCopiedPartialAltokeEntity,
          partialAltokeEntity,
        );
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
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
              .having(
                (e) => e.name,
                'name',
                const Optional.some('new name'),
              )
              .having(
                (e) => e.description,
                'description',
                const Optional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartialAltokeEntity = partialAltokeEntity.copyWith();
        expect(noopCopiedPartialAltokeEntity, isNotNull);
        expect(
          noopCopiedPartialAltokeEntity,
          partialAltokeEntity,
        );
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
    },
  );
}
