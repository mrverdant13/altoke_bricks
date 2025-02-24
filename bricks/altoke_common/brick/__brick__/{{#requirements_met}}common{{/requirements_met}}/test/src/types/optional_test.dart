import 'package:{{#requirements_met}}common{{/requirements_met}}/{{#requirements_met}}common{{/requirements_met}}.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for a present value
WHEN the constructor is called
THEN an instance of the present is returned
''',
    () {
      {{#use_dart_mappable}}const presentValue = Optional.some('value');
        expect(presentValue, isNotNull);
        expect(presentValue, isA<Optional>());
        expect(presentValue, isA<DmSome>());{{/use_dart_mappable}}{{#use_equatable}}const presentValue = Optional.some('value');
        expect(presentValue, isNotNull);
        expect(presentValue, isA<Optional>());
        expect(presentValue, isA<ESome>());{{/use_equatable}}{{#use_freezed}}const presentValue = Optional.some('value');
        expect(presentValue, isNotNull);
        expect(presentValue, isA<Optional>());
        expect(presentValue, isA<FSome>());{{/use_freezed}}{{#use_overrides}}const presentValue = Optional.some('value');
        expect(presentValue, isNotNull);
        expect(presentValue, isA<Optional>());
        expect(presentValue, isA<Some>());{{/use_overrides}}
},
  );

  test(
    '''

GIVEN a constructor for an absent value
WHEN the constructor is called
THEN an instance of the absent value is returned
''',
    () {
{{#use_dart_mappable}}const absentValue = Optional.none();
        expect(absentValue, isNotNull);
        expect(absentValue, isA<Optional>());
        expect(absentValue, isA<DmNone>());{{/use_dart_mappable}}{{#use_equatable}}const absentValue = Optional.none();
        expect(absentValue, isNotNull);
        expect(absentValue, isA<Optional>());
        expect(absentValue, isA<ENone>());{{/use_equatable}}{{#use_freezed}}const absentValue = Optional.none();
        expect(absentValue, isNotNull);
        expect(absentValue, isA<Optional>());
        expect(absentValue, isA<FNone>());{{/use_freezed}}{{#use_overrides}}const absentValue = Optional.none();
        expect(absentValue, isNotNull);
        expect(absentValue, isA<Optional>());
        expect(absentValue, isA<None>());{{/use_overrides}}
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
{{#use_dart_mappable}}const presentValue = Optional.some('some-value');
        const sameOptional = DmSome('some-value');
        const differentOptional1 = DmSome('other-value');
        const differentOptional2 = DmSome<int>(42);
        const differentOptional3 = DmNone<double>();
        expect(presentValue, sameOptional);
        expect(presentValue, isNot(differentOptional1));
        expect(presentValue, isNot(differentOptional2));
        expect(presentValue, isNot(differentOptional3));
        expect(presentValue.hashCode, sameOptional.hashCode);
        expect(presentValue.hashCode, isNot(differentOptional1.hashCode));
        expect(presentValue.hashCode, isNot(differentOptional2.hashCode));
        expect(presentValue.hashCode, isNot(differentOptional3.hashCode));{{/use_dart_mappable}}{{#use_equatable}}const presentValue = Optional.some('some-value');
        const sameOptional = ESome('some-value');
        const differentOptional1 = ESome('other-value');
        const differentOptional2 = ESome<int>(42);
        const differentOptional3 = ENone<double>();
        expect(presentValue, sameOptional);
        expect(presentValue, isNot(differentOptional1));
        expect(presentValue, isNot(differentOptional2));
        expect(presentValue, isNot(differentOptional3));
        expect(presentValue.hashCode, sameOptional.hashCode);
        expect(presentValue.hashCode, isNot(differentOptional1.hashCode));
        expect(presentValue.hashCode, isNot(differentOptional2.hashCode));
        expect(presentValue.hashCode, isNot(differentOptional3.hashCode));{{/use_equatable}}{{#use_freezed}}const presentValue = Optional.some('some-value');
        const sameOptional = FSome('some-value');
        const differentOptional1 = FSome('other-value');
        const differentOptional2 = FSome<int>(42);
        const differentOptional3 = FNone<double>();
        expect(presentValue, sameOptional);
        expect(presentValue, isNot(differentOptional1));
        expect(presentValue, isNot(differentOptional2));
        expect(presentValue, isNot(differentOptional3));
        expect(presentValue.hashCode, sameOptional.hashCode);
        expect(presentValue.hashCode, isNot(differentOptional1.hashCode));
        expect(presentValue.hashCode, isNot(differentOptional2.hashCode));
        expect(presentValue.hashCode, isNot(differentOptional3.hashCode));{{/use_freezed}}{{#use_overrides}}const presentValue = Optional.some('some-value');
        const sameOptional = Some('some-value');
        const differentOptional1 = Some('other-value');
        const differentOptional2 = Some<int>(42);
        const differentOptional3 = None<double>();
        expect(presentValue, sameOptional);
        expect(presentValue, isNot(differentOptional1));
        expect(presentValue, isNot(differentOptional2));
        expect(presentValue, isNot(differentOptional3));
        expect(presentValue.hashCode, sameOptional.hashCode);
        expect(presentValue.hashCode, isNot(differentOptional1.hashCode));
        expect(presentValue.hashCode, isNot(differentOptional2.hashCode));
        expect(presentValue.hashCode, isNot(differentOptional3.hashCode));{{/use_overrides}}
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
{{#use_dart_mappable}}const absentValue = Optional<String>.none();
        const sameOptional = DmNone<String>();
        const differentOptional1 = DmNone<int>();
        const differentOptional2 = DmNone<double>();
        const differentOptional3 = DmSome<int>(42);
        expect(absentValue, sameOptional);
        expect(absentValue, isNot(differentOptional1));
        expect(absentValue, isNot(differentOptional2));
        expect(absentValue, isNot(differentOptional3));
        expect(absentValue.hashCode, sameOptional.hashCode);
        expect(absentValue.hashCode, isNot(differentOptional1.hashCode));
        expect(absentValue.hashCode, isNot(differentOptional2.hashCode));
        expect(absentValue.hashCode, isNot(differentOptional3.hashCode));{{/use_dart_mappable}}{{#use_equatable}}const absentValue = Optional<String>.none();
        const sameOptional = ENone<String>();
        const differentOptional1 = ENone<int>();
        const differentOptional2 = ENone<double>();
        const differentOptional3 = ESome<int>(42);
        expect(absentValue, sameOptional);
        expect(absentValue, isNot(differentOptional1));
        expect(absentValue, isNot(differentOptional2));
        expect(absentValue, isNot(differentOptional3));
        expect(absentValue.hashCode, sameOptional.hashCode);
        expect(absentValue.hashCode, isNot(differentOptional1.hashCode));
        expect(absentValue.hashCode, isNot(differentOptional2.hashCode));
        expect(absentValue.hashCode, isNot(differentOptional3.hashCode));{{/use_equatable}}{{#use_freezed}}const absentValue = Optional<String>.none();
        const sameOptional = FNone<String>();
        const differentOptional1 = FNone<int>();
        const differentOptional2 = FNone<double>();
        const differentOptional3 = FSome<int>(42);
        expect(absentValue, sameOptional);
        expect(absentValue, isNot(differentOptional1));
        expect(absentValue, isNot(differentOptional2));
        expect(absentValue, isNot(differentOptional3));
        expect(absentValue.hashCode, sameOptional.hashCode);
        expect(absentValue.hashCode, isNot(differentOptional1.hashCode));
        expect(absentValue.hashCode, isNot(differentOptional2.hashCode));
        expect(absentValue.hashCode, isNot(differentOptional3.hashCode));{{/use_freezed}}{{#use_overrides}}const absentValue = Optional<String>.none();
        const sameOptional = None<String>();
        const differentOptional1 = None<int>();
        const differentOptional2 = None<double>();
        const differentOptional3 = Some<int>(42);
        expect(absentValue, sameOptional);
        expect(absentValue, isNot(differentOptional1));
        expect(absentValue, isNot(differentOptional2));
        expect(absentValue, isNot(differentOptional3));
        expect(absentValue.hashCode, sameOptional.hashCode);
        expect(absentValue.hashCode, isNot(differentOptional1.hashCode));
        expect(absentValue.hashCode, isNot(differentOptional2.hashCode));
        expect(absentValue.hashCode, isNot(differentOptional3.hashCode));{{/use_overrides}}
},
  );

  test(
    '''

GIVEN a present value
WHEN its string representation is requested
THEN a string representation of the present value is returned
''',
    () {
{{#use_dart_mappable}}const presentValue = Optional.some('some-value');
        expect(presentValue.toString(), 'DmSome(value: some-value)');{{/use_dart_mappable}}{{#use_equatable}}const presentValue = Optional.some('some-value');
        expect(presentValue.toString(), 'ESome<String>(some-value)');{{/use_equatable}}{{#use_freezed}}const presentValue = Optional.some('some-value');
        expect(
          presentValue.toString(),
          'Optional<String>.some(value: some-value)',
        );{{/use_freezed}}{{#use_overrides}}const presentValue = Optional.some('some-value');
        expect(presentValue.toString(), 'Some<String>(value: some-value)');{{/use_overrides}}
},
  );

  test(
    '''

GIVEN absent value
WHEN its string representation is requested
THEN a string representation of the absent value is returned
''',
    () {
{{#use_dart_mappable}}const absentValue = Optional<String>.none();
        expect(absentValue.toString(), 'DmNone()');{{/use_dart_mappable}}{{#use_equatable}}const absentValue = Optional<String>.none();
        expect(absentValue.toString(), 'ENone<String>()');{{/use_equatable}}{{#use_freezed}}const absentValue = Optional<String>.none();
        expect(absentValue.toString(), 'Optional<String>.none()');{{/use_freezed}}{{#use_overrides}}const absentValue = Optional<String>.none();
        expect(absentValue.toString(), 'None<String>()');{{/use_overrides}}
},
  );
}
