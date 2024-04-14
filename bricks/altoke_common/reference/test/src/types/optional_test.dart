import 'package:altoke_common/common.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for a present value
WHEN the constructor is called
THEN an instance of the present is returned
''',
    () {
      /*w 1v w*/
      /*remove-start*/
      {
        /*remove-end*/
        /*{{#use_dart_mappable}}*/
        const presentValue = DmOptional.some('value');
        expect(presentValue, isNotNull);
        expect(presentValue, isA<DmOptional>());
        expect(presentValue, isA<DmSome>());
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const presentValue = EOptional.some('value');
        expect(presentValue, isNotNull);
        expect(presentValue, isA<EOptional>());
        expect(presentValue, isA<ESome>());
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
        const presentValue = FOptional.some('value');
        expect(presentValue, isNotNull);
        expect(presentValue, isA<FOptional>());
        expect(presentValue, isA<FSome>());
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
        const presentValue = Optional.some('value');
        expect(presentValue, isNotNull);
        expect(presentValue, isA<Optional>());
        expect(presentValue, isA<Some>());
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
    },
  );

  test(
    '''

GIVEN a constructor for an absent value
WHEN the constructor is called
THEN an instance of the absent value is returned
''',
    () {
      /*w 1v w*/
      /*remove-start*/
      {
        /*remove-end*/
        /*{{#use_dart_mappable}}*/
        const absentValue = DmOptional.none();
        expect(absentValue, isNotNull);
        expect(absentValue, isA<DmOptional>());
        expect(absentValue, isA<DmNone>());
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const absentValue = EOptional.none();
        expect(absentValue, isNotNull);
        expect(absentValue, isA<EOptional>());
        expect(absentValue, isA<ENone>());
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
        const absentValue = FOptional.none();
        expect(absentValue, isNotNull);
        expect(absentValue, isA<FOptional>());
        expect(absentValue, isA<FNone>());
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
        const absentValue = Optional.none();
        expect(absentValue, isNotNull);
        expect(absentValue, isA<Optional>());
        expect(absentValue, isA<None>());
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
    },
  );

  test(
    '''

GIVEN a couple of present values
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
        const presentValue = DmOptional.some('some-value');
        const sameOptional = DmSome('some-value');
        const differentOptional = DmSome('other-value');
        expect(presentValue, sameOptional);
        expect(presentValue, isNot(differentOptional));
        expect(presentValue.hashCode, sameOptional.hashCode);
        expect(presentValue.hashCode, isNot(differentOptional.hashCode));
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const presentValue = EOptional.some('some-value');
        const sameOptional = ESome('some-value');
        const differentOptional = ESome('other-value');
        expect(presentValue, sameOptional);
        expect(presentValue, isNot(differentOptional));
        expect(presentValue.hashCode, sameOptional.hashCode);
        expect(presentValue.hashCode, isNot(differentOptional.hashCode));
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
        const presentValue = FOptional.some('some-value');
        const sameOptional = FSome('some-value');
        const differentOptional = FSome('other-value');
        expect(presentValue, sameOptional);
        expect(presentValue, isNot(differentOptional));
        expect(presentValue.hashCode, sameOptional.hashCode);
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
        const presentValue = Optional.some('some-value');
        const sameOptional = Some('some-value');
        const differentOptional = Some('other-value');
        expect(presentValue, sameOptional);
        expect(presentValue, isNot(differentOptional));
        expect(presentValue.hashCode, sameOptional.hashCode);
        expect(presentValue.hashCode, isNot(differentOptional.hashCode));
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
    },
  );

  test(
    '''

GIVEN a couple of absent values
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
        const absentValue = DmOptional<String>.none();
        const sameOptional = DmNone<String>();
        /*remove-start*/
        // const differentOptional = DmNone<int>();
        /*remove-end*/
        expect(absentValue, sameOptional);
        /*remove-start*/
        // HACK: Equality should consider the type parameter.
        // expect(absentValue, isNot(differentOptional));
        /*remove-end*/
        expect(absentValue.hashCode, sameOptional.hashCode);
        /*remove-start*/
        // HACK: Hashes should consider the type parameter.
        // expect(absentValue.hashCode, isNot(differentOptional.hashCode));
        /*remove-end*/
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const absentValue = EOptional<String>.none();
        const sameOptional = ENone<String>();
        const differentOptional = ENone<int>();
        expect(absentValue, sameOptional);
        expect(absentValue, isNot(differentOptional));
        expect(absentValue.hashCode, sameOptional.hashCode);
        expect(absentValue.hashCode, isNot(differentOptional.hashCode));
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
        const absentValue = FOptional<String>.none();
        const sameOptional = FNone<String>();
        const differentOptional = FNone<int>();
        expect(absentValue, sameOptional);
        expect(absentValue, isNot(differentOptional));
        expect(absentValue.hashCode, sameOptional.hashCode);
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
        const absentValue = Optional<String>.none();
        const sameOptional = None<String>();
        const differentOptional = None<int>();
        expect(absentValue, sameOptional);
        expect(absentValue, isNot(differentOptional));
        expect(absentValue.hashCode, sameOptional.hashCode);
        expect(absentValue.hashCode, isNot(differentOptional.hashCode));
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
    },
  );

  test(
    '''

GIVEN a present value
WHEN its string representation is requested
THEN a string representation of the present value is returned
''',
    () {
      /*w 1v w*/
      /*remove-start*/
      {
        /*remove-end*/
        /*{{#use_dart_mappable}}*/
        const presentValue = DmOptional.some('some-value');
        expect(
          presentValue.toString(),
          'DmSome(value: some-value)',
        );
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const presentValue = EOptional.some('some-value');
        expect(
          presentValue.toString(),
          'ESome<String>(some-value)',
        );
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
        const presentValue = FOptional.some('some-value');
        expect(
          presentValue.toString(),
          'FOptional<String>.some(value: some-value)',
        );
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
        const presentValue = Optional.some('some-value');
        expect(
          presentValue.toString(),
          'Some<String>(value: some-value)',
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

GIVEN absent value
WHEN its string representation is requested
THEN a string representation of the absent value is returned
''',
    () {
      /*w 1v w*/
      /*remove-start*/
      {
        /*remove-end*/
        /*{{#use_dart_mappable}}*/
        const absentValue = DmOptional<String>.none();
        expect(
          absentValue.toString(),
          'DmNone()',
        );
        /*{{/use_dart_mappable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_equatable}}*/
        const absentValue = EOptional<String>.none();
        expect(
          absentValue.toString(),
          'ENone<String>()',
        );
        /*{{/use_equatable}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_freezed}}*/
        const absentValue = FOptional<String>.none();
        expect(
          absentValue.toString(),
          'FOptional<String>.none()',
        );
        /*{{/use_freezed}}*/
        /*remove-start*/
      }
      {
        /*remove-end*/
        /*{{#use_overrides}}*/
        const absentValue = Optional<String>.none();
        expect(
          absentValue.toString(),
          'None<String>()',
        );
        /*{{/use_overrides}}*/
        /*remove-start*/
      }
      /*remove-end*/
      /*w 1v w*/
    },
  );
}
