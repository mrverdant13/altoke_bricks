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
        /*{{#use_freezed}}*/
        const altokeEntity = EAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(altokeEntity, isNotNull);
        expect(altokeEntity, isA<EAltokeEntity>());
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const altokeEntity = FAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(altokeEntity, isNotNull);
        expect(altokeEntity, isA<FAltokeEntity>());
        /*{{/use_equatable}}*/
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
        final copiedAltokeEntity = altokeEntity.copyWith(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(copiedAltokeEntity, isNotNull);
        expect(
          copiedAltokeEntity,
          isA<DmAltokeEntity>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
        const altokeEntity = EAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        final copiedAltokeEntity = altokeEntity.copyWith(
          id: 38,
          name: 'new name',
          description: () => 'new description',
        );
        expect(copiedAltokeEntity, isNotNull);
        expect(
          copiedAltokeEntity,
          isA<EAltokeEntity>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const altokeEntity = FAltokeEntity(
          id: 37,
          name: 'name',
          description: 'description',
        );
        final copiedAltokeEntity = altokeEntity.copyWith(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(copiedAltokeEntity, isNotNull);
        expect(
          copiedAltokeEntity,
          isA<FAltokeEntity>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        /*{{/use_equatable}}*/
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
        final copiedAltokeEntity = altokeEntity.copyWith(
          id: 38,
          name: 'new name',
          description: () => 'new description',
        );
        expect(copiedAltokeEntity, isNotNull);
        expect(
          copiedAltokeEntity,
          isA<AltokeEntity>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
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
        /*{{#use_freezed}}*/
        const newAltokeEntity = ENewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(newAltokeEntity, isNotNull);
        expect(newAltokeEntity, isA<ENewAltokeEntity>());
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const newAltokeEntity = FNewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        expect(newAltokeEntity, isNotNull);
        expect(newAltokeEntity, isA<FNewAltokeEntity>());
        /*{{/use_equatable}}*/
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
        final copiedNewAltokeEntity = newAltokeEntity.copyWith(
          name: 'new name',
          description: 'new description',
        );
        expect(copiedNewAltokeEntity, isNotNull);
        expect(
          copiedNewAltokeEntity,
          isA<DmNewAltokeEntity>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
        const newAltokeEntity = ENewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        final copiedNewAltokeEntity = newAltokeEntity.copyWith(
          name: 'new name',
          description: () => 'new description',
        );
        expect(copiedNewAltokeEntity, isNotNull);
        expect(
          copiedNewAltokeEntity,
          isA<ENewAltokeEntity>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const newAltokeEntity = FNewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        final copiedNewAltokeEntity = newAltokeEntity.copyWith(
          name: 'new name',
          description: 'new description',
        );
        expect(copiedNewAltokeEntity, isNotNull);
        expect(
          copiedNewAltokeEntity,
          isA<FNewAltokeEntity>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
        const newAltokeEntity = NewAltokeEntity(
          name: 'name',
          description: 'description',
        );
        final copiedNewAltokeEntity = newAltokeEntity.copyWith(
          name: 'new name',
          description: () => 'new description',
        );
        expect(copiedNewAltokeEntity, isNotNull);
        expect(
          copiedNewAltokeEntity,
          isA<NewAltokeEntity>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
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
        /*{{#use_freezed}}*/
        const partialAltokeEntity = EPartialAltokeEntity(
          name: EOptional.some('name'),
          description: EOptional.some('description'),
        );
        expect(partialAltokeEntity, isNotNull);
        expect(partialAltokeEntity, isA<EPartialAltokeEntity>());
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const partialAltokeEntity = FPartialAltokeEntity(
          name: FOptional.some('name'),
          description: FOptional.some('description'),
        );
        expect(partialAltokeEntity, isNotNull);
        expect(partialAltokeEntity, isA<FPartialAltokeEntity>());
        /*{{/use_equatable}}*/
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
        final copiedPartialAltokeEntity = partialAltokeEntity.copyWith(
          name: const DmOptional.some('new name'),
          description: const DmOptional.some('new description'),
        );
        expect(copiedPartialAltokeEntity, isNotNull);
        expect(
          copiedPartialAltokeEntity,
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
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
        const partialAltokeEntity = EPartialAltokeEntity(
          name: EOptional.some('name'),
          description: EOptional.some('description'),
        );
        final copiedPartialAltokeEntity = partialAltokeEntity.copyWith(
          name: const EOptional.some('new name'),
          description: const EOptional.some('new description'),
        );
        expect(copiedPartialAltokeEntity, isNotNull);
        expect(
          copiedPartialAltokeEntity,
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
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const partialAltokeEntity = FPartialAltokeEntity(
          name: FOptional.some('name'),
          description: FOptional.some('description'),
        );
        final copiedPartialAltokeEntity = partialAltokeEntity.copyWith(
          name: const FOptional.some('new name'),
          description: const FOptional.some('new description'),
        );
        expect(copiedPartialAltokeEntity, isNotNull);
        expect(
          copiedPartialAltokeEntity,
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
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
        const partialAltokeEntity = PartialAltokeEntity(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        final copiedPartialAltokeEntity = partialAltokeEntity.copyWith(
          name: const Optional.some('new name'),
          description: const Optional.some('new description'),
        );
        expect(copiedPartialAltokeEntity, isNotNull);
        expect(
          copiedPartialAltokeEntity,
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
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
    },
  );
}
