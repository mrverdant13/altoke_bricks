import 'package:common/common.dart';
import 'package:{{entity_singular.snakeCase()}}/{{entity_singular.snakeCase()}}.dart';
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
        expect({{entity_singular.camelCase()}}, isA<{{entity_singular.pascalCase()}}>());{{/use_dart_mappable}}{{#use_freezed}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect({{entity_singular.camelCase()}}, isNotNull);
        expect({{entity_singular.camelCase()}}, isA<{{entity_singular.pascalCase()}}>());{{/use_freezed}}{{#use_equatable}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        expect({{entity_singular.camelCase()}}, isNotNull);
        expect({{entity_singular.camelCase()}}, isA<{{entity_singular.pascalCase()}}>());{{/use_equatable}}{{#use_overrides}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
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
        final copied{{entity_singular.pascalCase()}} = {{entity_singular.camelCase()}}.copyWith(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(copied{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          copied{{entity_singular.pascalCase()}},
          isA<{{entity_singular.pascalCase()}}>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );{{/use_dart_mappable}}{{#use_freezed}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        final copied{{entity_singular.pascalCase()}} = {{entity_singular.camelCase()}}.copyWith(
          id: 38,
          name: 'new name',
          description: () => 'new description',
        );
        expect(copied{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          copied{{entity_singular.pascalCase()}},
          isA<{{entity_singular.pascalCase()}}>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );{{/use_freezed}}{{#use_equatable}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        final copied{{entity_singular.pascalCase()}} = {{entity_singular.camelCase()}}.copyWith(
          id: 38,
          name: 'new name',
          description: 'new description',
        );
        expect(copied{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          copied{{entity_singular.pascalCase()}},
          isA<{{entity_singular.pascalCase()}}>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );{{/use_equatable}}{{#use_overrides}}const {{entity_singular.camelCase()}} = {{entity_singular.pascalCase()}}(
          id: 37,
          name: 'name',
          description: 'description',
        );
        final copied{{entity_singular.pascalCase()}} = {{entity_singular.camelCase()}}.copyWith(
          id: 38,
          name: 'new name',
          description: () => 'new description',
        );
        expect(copied{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          copied{{entity_singular.pascalCase()}},
          isA<{{entity_singular.pascalCase()}}>()
              .having((e) => e.id, 'id', 38)
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );{{/use_overrides}}
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
        expect(new{{entity_singular.pascalCase()}}, isA<New{{entity_singular.pascalCase()}}>());{{/use_dart_mappable}}{{#use_freezed}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        expect(new{{entity_singular.pascalCase()}}, isNotNull);
        expect(new{{entity_singular.pascalCase()}}, isA<New{{entity_singular.pascalCase()}}>());{{/use_freezed}}{{#use_equatable}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        expect(new{{entity_singular.pascalCase()}}, isNotNull);
        expect(new{{entity_singular.pascalCase()}}, isA<New{{entity_singular.pascalCase()}}>());{{/use_equatable}}{{#use_overrides}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        expect(new{{entity_singular.pascalCase()}}, isNotNull);
        expect(new{{entity_singular.pascalCase()}}, isA<New{{entity_singular.pascalCase()}}>());{{/use_overrides}}
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
        final copiedNew{{entity_singular.pascalCase()}} = new{{entity_singular.pascalCase()}}.copyWith(
          name: 'new name',
          description: 'new description',
        );
        expect(copiedNew{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          copiedNew{{entity_singular.pascalCase()}},
          isA<New{{entity_singular.pascalCase()}}>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );{{/use_dart_mappable}}{{#use_freezed}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        final copiedNew{{entity_singular.pascalCase()}} = new{{entity_singular.pascalCase()}}.copyWith(
          name: 'new name',
          description: () => 'new description',
        );
        expect(copiedNew{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          copiedNew{{entity_singular.pascalCase()}},
          isA<New{{entity_singular.pascalCase()}}>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );{{/use_freezed}}{{#use_equatable}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        final copiedNew{{entity_singular.pascalCase()}} = new{{entity_singular.pascalCase()}}.copyWith(
          name: 'new name',
          description: 'new description',
        );
        expect(copiedNew{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          copiedNew{{entity_singular.pascalCase()}},
          isA<New{{entity_singular.pascalCase()}}>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );{{/use_equatable}}{{#use_overrides}}const new{{entity_singular.pascalCase()}} = New{{entity_singular.pascalCase()}}(
          name: 'name',
          description: 'description',
        );
        final copiedNew{{entity_singular.pascalCase()}} = new{{entity_singular.pascalCase()}}.copyWith(
          name: 'new name',
          description: () => 'new description',
        );
        expect(copiedNew{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          copiedNew{{entity_singular.pascalCase()}},
          isA<New{{entity_singular.pascalCase()}}>()
              .having((e) => e.name, 'name', 'new name')
              .having((e) => e.description, 'description', 'new description'),
        );{{/use_overrides}}
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
        expect(partial{{entity_singular.pascalCase()}}, isA<Partial{{entity_singular.pascalCase()}}>());{{/use_dart_mappable}}{{#use_freezed}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(partial{{entity_singular.pascalCase()}}, isNotNull);
        expect(partial{{entity_singular.pascalCase()}}, isA<Partial{{entity_singular.pascalCase()}}>());{{/use_freezed}}{{#use_equatable}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(partial{{entity_singular.pascalCase()}}, isNotNull);
        expect(partial{{entity_singular.pascalCase()}}, isA<Partial{{entity_singular.pascalCase()}}>());{{/use_equatable}}{{#use_overrides}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        expect(partial{{entity_singular.pascalCase()}}, isNotNull);
        expect(partial{{entity_singular.pascalCase()}}, isA<Partial{{entity_singular.pascalCase()}}>());{{/use_overrides}}
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
        final copiedPartial{{entity_singular.pascalCase()}} = partial{{entity_singular.pascalCase()}}.copyWith(
          name: const Optional.some('new name'),
          description: const Optional.some('new description'),
        );
        expect(copiedPartial{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          copiedPartial{{entity_singular.pascalCase()}},
          isA<Partial{{entity_singular.pascalCase()}}>()
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
        );{{/use_dart_mappable}}{{#use_freezed}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        final copiedPartial{{entity_singular.pascalCase()}} = partial{{entity_singular.pascalCase()}}.copyWith(
          name: const Optional.some('new name'),
          description: const Optional.some('new description'),
        );
        expect(copiedPartial{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          copiedPartial{{entity_singular.pascalCase()}},
          isA<Partial{{entity_singular.pascalCase()}}>()
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
        );{{/use_freezed}}{{#use_equatable}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        final copiedPartial{{entity_singular.pascalCase()}} = partial{{entity_singular.pascalCase()}}.copyWith(
          name: const Optional.some('new name'),
          description: const Optional.some('new description'),
        );
        expect(copiedPartial{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          copiedPartial{{entity_singular.pascalCase()}},
          isA<Partial{{entity_singular.pascalCase()}}>()
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
        );{{/use_equatable}}{{#use_overrides}}const partial{{entity_singular.pascalCase()}} = Partial{{entity_singular.pascalCase()}}(
          name: Optional.some('name'),
          description: Optional.some('description'),
        );
        final copiedPartial{{entity_singular.pascalCase()}} = partial{{entity_singular.pascalCase()}}.copyWith(
          name: const Optional.some('new name'),
          description: const Optional.some('new description'),
        );
        expect(copiedPartial{{entity_singular.pascalCase()}}, isNotNull);
        expect(
          copiedPartial{{entity_singular.pascalCase()}},
          isA<Partial{{entity_singular.pascalCase()}}>()
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
        );{{/use_overrides}}
},
  );
}
