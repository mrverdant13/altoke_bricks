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
          title: 'title',
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
}
