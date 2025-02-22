import 'package:common/common.dart';
import 'package:{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}/{{#requirements_met}}{{entity_singular.snakeCase()}}{{/requirements_met}}.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for {{entity_singular.lowerCase()}}
WHEN the constructor is called
THEN an instance of the {{entity_singular.lowerCase()}} is returned
''',
    () {
{{#use_dart_mappable}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect({{entity_singular.camelCase()}}, isNotNull);
        expect({{entity_singular.camelCase()}}, isA<{{entity_singular.pascalCase()}}>());{{/use_dart_mappable}}{{#use_equatable}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect({{entity_singular.camelCase()}}, isNotNull);
        expect({{entity_singular.camelCase()}}, isA<{{entity_singular.pascalCase()}}>());{{/use_equatable}}{{#use_freezed}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect({{entity_singular.camelCase()}}, isNotNull);
        expect({{entity_singular.camelCase()}}, isA<{{entity_singular.pascalCase()}}>());{{/use_freezed}}{{#use_overrides}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect({{entity_singular.camelCase()}}, isNotNull);
        expect({{entity_singular.camelCase()}}, isA<{{entity_singular.pascalCase()}}>());{{/use_overrides}}
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
{{#use_dart_mappable}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const same{{entity_singular.pascalCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const different{{entity_singular.pascalCase()}} = {{entity_singular.pascalCase()}}(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect({{entity_singular.camelCase()}}, same{{entity_singular.pascalCase()}});
        expect({{entity_singular.camelCase()}}, isNot(different{{entity_singular.pascalCase()}}));
        expect({{entity_singular.camelCase()}}.hashCode, same{{entity_singular.pascalCase()}}.hashCode);
        expect({{entity_singular.camelCase()}}.hashCode, isNot(different{{entity_singular.pascalCase()}}.hashCode));{{/use_dart_mappable}}{{#use_equatable}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const same{{entity_singular.pascalCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const different{{entity_singular.pascalCase()}} = {{entity_singular.pascalCase()}}(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect({{entity_singular.camelCase()}}, same{{entity_singular.pascalCase()}});
        expect({{entity_singular.camelCase()}}, isNot(different{{entity_singular.pascalCase()}}));
        expect({{entity_singular.camelCase()}}.hashCode, same{{entity_singular.pascalCase()}}.hashCode);
        expect({{entity_singular.camelCase()}}.hashCode, isNot(different{{entity_singular.pascalCase()}}.hashCode));{{/use_equatable}}{{#use_freezed}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const same{{entity_singular.pascalCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const different{{entity_singular.pascalCase()}} = {{entity_singular.pascalCase()}}(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect({{entity_singular.camelCase()}}, same{{entity_singular.pascalCase()}});
        expect({{entity_singular.camelCase()}}, isNot(different{{entity_singular.pascalCase()}}));
        expect({{entity_singular.camelCase()}}.hashCode, same{{entity_singular.pascalCase()}}.hashCode);
        expect({{entity_singular.camelCase()}}.hashCode, isNot(different{{entity_singular.pascalCase()}}.hashCode));{{/use_freezed}}{{#use_overrides}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const same{{entity_singular.pascalCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        const different{{entity_singular.pascalCase()}} = {{entity_singular.pascalCase()}}(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect({{entity_singular.camelCase()}}, same{{entity_singular.pascalCase()}});
        expect({{entity_singular.camelCase()}}, isNot(different{{entity_singular.pascalCase()}}));
        expect({{entity_singular.camelCase()}}.hashCode, same{{entity_singular.pascalCase()}}.hashCode);
        expect({{entity_singular.camelCase()}}.hashCode, isNot(different{{entity_singular.pascalCase()}}.hashCode));{{/use_overrides}}
},
  );

  test(
    '''

GIVEN an {{entity_singular.lowerCase()}}
WHEN its string representation is requested
THEN a string representation of the {{entity_singular.lowerCase()}} is returned
''',
    () {
{{#use_dart_mappable}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(
          {{entity_singular.camelCase()}}.toString(),
          '{{entity_singular.pascalCase()}}(id: 37, name: name, description: description)',
        );{{/use_dart_mappable}}{{#use_equatable}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect({{entity_singular.camelCase()}}.toString(), '{{entity_singular.pascalCase()}}(37, name, description)');{{/use_equatable}}{{#use_freezed}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(
          {{entity_singular.camelCase()}}.toString(),
          '{{entity_singular.pascalCase()}}(id: 37, name: name, description: description)',
        );{{/use_freezed}}{{#use_overrides}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect(
          {{entity_singular.camelCase()}}.toString(),
          '{{entity_singular.pascalCase()}}(id: 37, name: name, description: description)',
        );{{/use_overrides}}
},
  );

  test(
    '''

GIVEN an {{entity_singular.lowerCase()}}
WHEN it gets copied
THEN an new instance of the {{entity_singular.lowerCase()}} is returned
├─ THAT has updated values
''',
    () {
{{#use_dart_mappable}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        final fullyCopied{{entity_singular.pascalCase()}} = {{entity_singular.camelCase()}}.copyWith(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(fullyCopied{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          fullyCopied{{entity_singular.pascalCase()}},
          isA<{{entity_singular.pascalCase()}}>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopied{{entity_singular.pascalCase()}} = {{entity_singular.camelCase()}}.copyWith();
        expect(noopCopied{{entity_singular.pascalCase()}}, isNotNull);
        expect(noopCopied{{entity_singular.pascalCase()}}, {{entity_singular.camelCase()}});{{/use_dart_mappable}}{{#use_equatable}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        final fullyCopied{{entity_singular.pascalCase()}} = {{entity_singular.camelCase()}}.copyWith(
          id: 38,
          name: 'new name',
          description: () => 'new description',
        );
        expect(fullyCopied{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          fullyCopied{{entity_singular.pascalCase()}},
          isA<{{entity_singular.pascalCase()}}>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopied{{entity_singular.pascalCase()}} = {{entity_singular.camelCase()}}.copyWith();
        expect(noopCopied{{entity_singular.pascalCase()}}, isNotNull);
        expect(noopCopied{{entity_singular.pascalCase()}}, {{entity_singular.camelCase()}});{{/use_equatable}}{{#use_freezed}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        final fullyCopied{{entity_singular.pascalCase()}} = {{entity_singular.camelCase()}}.copyWith(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(fullyCopied{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          fullyCopied{{entity_singular.pascalCase()}},
          isA<{{entity_singular.pascalCase()}}>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopied{{entity_singular.pascalCase()}} = {{entity_singular.camelCase()}}.copyWith();
        expect(noopCopied{{entity_singular.pascalCase()}}, isNotNull);
        expect(noopCopied{{entity_singular.pascalCase()}}, {{entity_singular.camelCase()}});{{/use_freezed}}{{#use_overrides}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        final fullyCopied{{entity_singular.pascalCase()}} = {{entity_singular.camelCase()}}.copyWith(
          id: 38,
          name: 'new name',
          description: () => 'new description',
        );
        expect(fullyCopied{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          fullyCopied{{entity_singular.pascalCase()}},
          isA<{{entity_singular.pascalCase()}}>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopied{{entity_singular.pascalCase()}} = {{entity_singular.camelCase()}}.copyWith();
        expect(noopCopied{{entity_singular.pascalCase()}}, isNotNull);
        expect(noopCopied{{entity_singular.pascalCase()}}, {{entity_singular.camelCase()}});{{/use_overrides}}
},
  );

  test(
    '''

GIVEN a constructor for a new {{entity_singular.lowerCase()}}
WHEN the constructor is called
THEN an instance of the new {{entity_singular.lowerCase()}} is returned
''',
    () {
{{#use_dart_mappable}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        expect(new{{entity_singular.pascalCase()}}, isNotNull);
        expect(new{{entity_singular.pascalCase()}}, isA<New{{entity_singular.pascalCase()}}>());{{/use_dart_mappable}}{{#use_equatable}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        expect(new{{entity_singular.pascalCase()}}, isNotNull);
        expect(new{{entity_singular.pascalCase()}}, isA<New{{entity_singular.pascalCase()}}>());{{/use_equatable}}{{#use_freezed}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        expect(new{{entity_singular.pascalCase()}}, isNotNull);
        expect(new{{entity_singular.pascalCase()}}, isA<New{{entity_singular.pascalCase()}}>());{{/use_freezed}}{{#use_overrides}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        expect(new{{entity_singular.pascalCase()}}, isNotNull);
        expect(new{{entity_singular.pascalCase()}}, isA<New{{entity_singular.pascalCase()}}>());{{/use_overrides}}
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
{{#use_dart_mappable}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        const sameNew{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        const differentNew{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'new name',
          description: 'new description',
        );
        expect(new{{entity_singular.pascalCase()}}, sameNew{{entity_singular.pascalCase()}});
        expect(new{{entity_singular.pascalCase()}}, isNot(differentNew{{entity_singular.pascalCase()}}));
        expect(new{{entity_singular.pascalCase()}}.hashCode, sameNew{{entity_singular.pascalCase()}}.hashCode);
        expect(
          new{{entity_singular.pascalCase()}}.hashCode,
          isNot(differentNew{{entity_singular.pascalCase()}}.hashCode),
        );{{/use_dart_mappable}}{{#use_equatable}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        const sameNew{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        const differentNew{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'new name',
          description: 'new description',
        );
        expect(new{{entity_singular.pascalCase()}}, sameNew{{entity_singular.pascalCase()}});
        expect(new{{entity_singular.pascalCase()}}, isNot(differentNew{{entity_singular.pascalCase()}}));
        expect(new{{entity_singular.pascalCase()}}.hashCode, sameNew{{entity_singular.pascalCase()}}.hashCode);
        expect(
          new{{entity_singular.pascalCase()}}.hashCode,
          isNot(differentNew{{entity_singular.pascalCase()}}.hashCode),
        );{{/use_equatable}}{{#use_freezed}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        const sameNew{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        const differentNew{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'new name',
          description: 'new description',
        );
        expect(new{{entity_singular.pascalCase()}}, sameNew{{entity_singular.pascalCase()}});
        expect(new{{entity_singular.pascalCase()}}, isNot(differentNew{{entity_singular.pascalCase()}}));
        expect(new{{entity_singular.pascalCase()}}.hashCode, sameNew{{entity_singular.pascalCase()}}.hashCode);
        expect(
          new{{entity_singular.pascalCase()}}.hashCode,
          isNot(differentNew{{entity_singular.pascalCase()}}.hashCode),
        );{{/use_freezed}}{{#use_overrides}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        const sameNew{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        const differentNew{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'new name',
          description: 'new description',
        );
        expect(new{{entity_singular.pascalCase()}}, sameNew{{entity_singular.pascalCase()}});
        expect(new{{entity_singular.pascalCase()}}, isNot(differentNew{{entity_singular.pascalCase()}}));
        expect(new{{entity_singular.pascalCase()}}.hashCode, sameNew{{entity_singular.pascalCase()}}.hashCode);
        expect(
          new{{entity_singular.pascalCase()}}.hashCode,
          isNot(differentNew{{entity_singular.pascalCase()}}.hashCode),
        );{{/use_overrides}}
},
  );

  test(
    '''

GIVEN a new {{entity_singular.lowerCase()}}
WHEN its string representation is requested
THEN a string representation of the new {{entity_singular.lowerCase()}} is returned
''',
    () {
{{#use_dart_mappable}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        expect(
          new{{entity_singular.pascalCase()}}.toString(),
          'New{{entity_singular.pascalCase()}}(name: name, description: description)',
        );{{/use_dart_mappable}}{{#use_equatable}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        expect(
          new{{entity_singular.pascalCase()}}.toString(),
          'New{{entity_singular.pascalCase()}}(name, description)',
        );{{/use_equatable}}{{#use_freezed}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        expect(
          new{{entity_singular.pascalCase()}}.toString(),
          'New{{entity_singular.pascalCase()}}(name: name, description: description)',
        );{{/use_freezed}}{{#use_overrides}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        expect(
          new{{entity_singular.pascalCase()}}.toString(),
          'New{{entity_singular.pascalCase()}}(name: name, description: description)',
        );{{/use_overrides}}
},
  );

  test(
    '''

GIVEN a new {{entity_singular.lowerCase()}}
WHEN it gets copied
THEN an new instance of the new {{entity_singular.lowerCase()}} is returned
├─ THAT has updated values
''',
    () {
{{#use_dart_mappable}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        final fullyCopiedNew{{entity_singular.pascalCase()}} = new{{entity_singular.pascalCase()}}.copyWith(
          name: 'new name',
          description: 'new description',
        );
        expect(fullyCopiedNew{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          fullyCopiedNew{{entity_singular.pascalCase()}},
          isA<New{{entity_singular.pascalCase()}}>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedNew{{entity_singular.pascalCase()}} = new{{entity_singular.pascalCase()}}.copyWith();
        expect(noopCopiedNew{{entity_singular.pascalCase()}}, isNotNull);
        expect(noopCopiedNew{{entity_singular.pascalCase()}}, new{{entity_singular.pascalCase()}});{{/use_dart_mappable}}{{#use_equatable}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        final fullyCopiedNew{{entity_singular.pascalCase()}} = new{{entity_singular.pascalCase()}}.copyWith(
          name: 'new name',
          description: () => 'new description',
        );
        expect(fullyCopiedNew{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          fullyCopiedNew{{entity_singular.pascalCase()}},
          isA<New{{entity_singular.pascalCase()}}>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedNew{{entity_singular.pascalCase()}} = new{{entity_singular.pascalCase()}}.copyWith();
        expect(noopCopiedNew{{entity_singular.pascalCase()}}, isNotNull);
        expect(noopCopiedNew{{entity_singular.pascalCase()}}, new{{entity_singular.pascalCase()}});{{/use_equatable}}{{#use_freezed}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        final fullyCopiedNew{{entity_singular.pascalCase()}} = new{{entity_singular.pascalCase()}}.copyWith(
          name: 'new name',
          description: 'new description',
        );
        expect(fullyCopiedNew{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          fullyCopiedNew{{entity_singular.pascalCase()}},
          isA<New{{entity_singular.pascalCase()}}>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedNew{{entity_singular.pascalCase()}} = new{{entity_singular.pascalCase()}}.copyWith();
        expect(noopCopiedNew{{entity_singular.pascalCase()}}, isNotNull);
        expect(noopCopiedNew{{entity_singular.pascalCase()}}, new{{entity_singular.pascalCase()}});{{/use_freezed}}{{#use_overrides}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        final fullyCopiedNew{{entity_singular.pascalCase()}} = new{{entity_singular.pascalCase()}}.copyWith(
          name: 'new name',
          description: () => 'new description',
        );
        expect(fullyCopiedNew{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          fullyCopiedNew{{entity_singular.pascalCase()}},
          isA<New{{entity_singular.pascalCase()}}>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );
        final noopCopiedNew{{entity_singular.pascalCase()}} = new{{entity_singular.pascalCase()}}.copyWith();
        expect(noopCopiedNew{{entity_singular.pascalCase()}}, isNotNull);
        expect(noopCopiedNew{{entity_singular.pascalCase()}}, new{{entity_singular.pascalCase()}});{{/use_overrides}}
},
  );

  test(
    '''

GIVEN a constructor for a partial {{entity_singular.lowerCase()}}
WHEN the constructor is called
THEN an instance of the partial {{entity_singular.lowerCase()}} is returned
''',
    () {
{{#use_dart_mappable}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(partial{{entity_singular.pascalCase()}}, isNotNull);
        expect(partial{{entity_singular.pascalCase()}}, isA<Partial{{entity_singular.pascalCase()}}>());{{/use_dart_mappable}}{{#use_equatable}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(partial{{entity_singular.pascalCase()}}, isNotNull);
        expect(partial{{entity_singular.pascalCase()}}, isA<Partial{{entity_singular.pascalCase()}}>());{{/use_equatable}}{{#use_freezed}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(partial{{entity_singular.pascalCase()}}, isNotNull);
        expect(partial{{entity_singular.pascalCase()}}, isA<Partial{{entity_singular.pascalCase()}}>());{{/use_freezed}}{{#use_overrides}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(partial{{entity_singular.pascalCase()}}, isNotNull);
        expect(partial{{entity_singular.pascalCase()}}, isA<Partial{{entity_singular.pascalCase()}}>());{{/use_overrides}}
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
{{#use_dart_mappable}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const samePartial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const differentPartial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('new name'),
          description: Optional.some('new description'),
        );
        expect(partial{{entity_singular.pascalCase()}}, samePartial{{entity_singular.pascalCase()}});
        expect(partial{{entity_singular.pascalCase()}}, isNot(differentPartial{{entity_singular.pascalCase()}}));
        expect(partial{{entity_singular.pascalCase()}}.hashCode, samePartial{{entity_singular.pascalCase()}}.hashCode);
        expect(
          partial{{entity_singular.pascalCase()}}.hashCode,
          isNot(differentPartial{{entity_singular.pascalCase()}}.hashCode),
        );{{/use_dart_mappable}}{{#use_equatable}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const samePartial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const differentPartial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('new name'),
          description: Optional.some('new description'),
        );
        expect(partial{{entity_singular.pascalCase()}}, samePartial{{entity_singular.pascalCase()}});
        expect(partial{{entity_singular.pascalCase()}}, isNot(differentPartial{{entity_singular.pascalCase()}}));
        expect(partial{{entity_singular.pascalCase()}}.hashCode, samePartial{{entity_singular.pascalCase()}}.hashCode);
        expect(
          partial{{entity_singular.pascalCase()}}.hashCode,
          isNot(differentPartial{{entity_singular.pascalCase()}}.hashCode),
        );{{/use_equatable}}{{#use_freezed}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const samePartial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const differentPartial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('new name'),
          description: Optional.some('new description'),
        );
        expect(partial{{entity_singular.pascalCase()}}, samePartial{{entity_singular.pascalCase()}});
        expect(partial{{entity_singular.pascalCase()}}, isNot(differentPartial{{entity_singular.pascalCase()}}));
        expect(partial{{entity_singular.pascalCase()}}.hashCode, samePartial{{entity_singular.pascalCase()}}.hashCode);
        expect(
          partial{{entity_singular.pascalCase()}}.hashCode,
          isNot(differentPartial{{entity_singular.pascalCase()}}.hashCode),
        );{{/use_freezed}}{{#use_overrides}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const samePartial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        const differentPartial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('new name'),
          description: Optional.some('new description'),
        );
        expect(partial{{entity_singular.pascalCase()}}, samePartial{{entity_singular.pascalCase()}});
        expect(partial{{entity_singular.pascalCase()}}, isNot(differentPartial{{entity_singular.pascalCase()}}));
        expect(partial{{entity_singular.pascalCase()}}.hashCode, samePartial{{entity_singular.pascalCase()}}.hashCode);
        expect(
          partial{{entity_singular.pascalCase()}}.hashCode,
          isNot(differentPartial{{entity_singular.pascalCase()}}.hashCode),
        );{{/use_overrides}}
},
  );

  test(
    '''

GIVEN a partial {{entity_singular.lowerCase()}}
WHEN its string representation is requested
THEN a string representation of the partial {{entity_singular.lowerCase()}} is returned
''',
    () {
{{#use_dart_mappable}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(
          partial{{entity_singular.pascalCase()}}.toString(),
          '''Partial{{entity_singular.pascalCase()}}(name: DmSome(value: name), description: DmSome(value: description))''',
        );{{/use_dart_mappable}}{{#use_equatable}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(
          partial{{entity_singular.pascalCase()}}.toString(),
          '''Partial{{entity_singular.pascalCase()}}(ESome<String>(name), ESome<String?>(description))''',
        );{{/use_equatable}}{{#use_freezed}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(
          partial{{entity_singular.pascalCase()}}.toString(),
          '''Partial{{entity_singular.pascalCase()}}(name: Optional<String>.some(value: name), description: Optional<String?>.some(value: description))''',
        );{{/use_freezed}}{{#use_overrides}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(
          partial{{entity_singular.pascalCase()}}.toString(),
          '''Partial{{entity_singular.pascalCase()}}(name: Some<String>(value: name), description: Some<String?>(value: description))''',
        );{{/use_overrides}}
},
  );

  test(
    '''

GIVEN a partial {{entity_singular.lowerCase()}}
WHEN it gets copied
THEN an new instance of the partial {{entity_singular.lowerCase()}} is returned
├─ THAT has updated values
''',
    () {
{{#use_dart_mappable}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        final fullyCopiedPartial{{entity_singular.pascalCase()}} = partial{{entity_singular.pascalCase()}}.copyWith(
          name: const Optional.some('new name'),
          description: const Optional.some('new description'),
        );
        expect(fullyCopiedPartial{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          fullyCopiedPartial{{entity_singular.pascalCase()}},
          isA<Partial{{entity_singular.pascalCase()}}>()
              .having((e) => e.name, 'name', const Optional.some('new name'))
              .having(
                (e) => e.description,
                'description',
                const Optional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartial{{entity_singular.pascalCase()}} = partial{{entity_singular.pascalCase()}}.copyWith();
        expect(noopCopiedPartial{{entity_singular.pascalCase()}}, isNotNull);
        expect(noopCopiedPartial{{entity_singular.pascalCase()}}, partial{{entity_singular.pascalCase()}});{{/use_dart_mappable}}{{#use_equatable}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        final fullyCopiedPartial{{entity_singular.pascalCase()}} = partial{{entity_singular.pascalCase()}}.copyWith(
          name: const Optional.some('new name'),
          description: const Optional.some('new description'),
        );
        expect(fullyCopiedPartial{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          fullyCopiedPartial{{entity_singular.pascalCase()}},
          isA<Partial{{entity_singular.pascalCase()}}>()
              .having((e) => e.name, 'name', const Optional.some('new name'))
              .having(
                (e) => e.description,
                'description',
                const Optional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartial{{entity_singular.pascalCase()}} = partial{{entity_singular.pascalCase()}}.copyWith();
        expect(noopCopiedPartial{{entity_singular.pascalCase()}}, isNotNull);
        expect(noopCopiedPartial{{entity_singular.pascalCase()}}, partial{{entity_singular.pascalCase()}});{{/use_equatable}}{{#use_freezed}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        final fullyCopiedPartial{{entity_singular.pascalCase()}} = partial{{entity_singular.pascalCase()}}.copyWith(
          name: const Optional.some('new name'),
          description: const Optional.some('new description'),
        );
        expect(fullyCopiedPartial{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          fullyCopiedPartial{{entity_singular.pascalCase()}},
          isA<Partial{{entity_singular.pascalCase()}}>()
              .having((e) => e.name, 'name', const Optional.some('new name'))
              .having(
                (e) => e.description,
                'description',
                const Optional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartial{{entity_singular.pascalCase()}} = partial{{entity_singular.pascalCase()}}.copyWith();
        expect(noopCopiedPartial{{entity_singular.pascalCase()}}, isNotNull);
        expect(noopCopiedPartial{{entity_singular.pascalCase()}}, partial{{entity_singular.pascalCase()}});{{/use_freezed}}{{#use_overrides}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        final fullyCopiedPartial{{entity_singular.pascalCase()}} = partial{{entity_singular.pascalCase()}}.copyWith(
          name: const Optional.some('new name'),
          description: const Optional.some('new description'),
        );
        expect(fullyCopiedPartial{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          fullyCopiedPartial{{entity_singular.pascalCase()}},
          isA<Partial{{entity_singular.pascalCase()}}>()
              .having((e) => e.name, 'name', const Optional.some('new name'))
              .having(
                (e) => e.description,
                'description',
                const Optional<String?>.some('new description'),
              ),
        );
        final noopCopiedPartial{{entity_singular.pascalCase()}} = partial{{entity_singular.pascalCase()}}.copyWith();
        expect(noopCopiedPartial{{entity_singular.pascalCase()}}, isNotNull);
        expect(noopCopiedPartial{{entity_singular.pascalCase()}}, partial{{entity_singular.pascalCase()}});{{/use_overrides}}
},
  );
}
