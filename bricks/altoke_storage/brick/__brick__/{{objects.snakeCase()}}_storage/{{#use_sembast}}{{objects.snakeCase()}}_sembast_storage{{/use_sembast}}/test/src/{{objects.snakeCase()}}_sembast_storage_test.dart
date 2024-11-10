import 'dart:async';

import 'package:common/common.dart';
import 'package:{{objects.snakeCase()}}_sembast_storage/{{objects.snakeCase()}}_sembast_storage.dart';
import 'package:{{objects.snakeCase()}}_storage/{{objects.snakeCase()}}_storage.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:collection/collection.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for a {{objects.lowerCase()}} storage
├─ THAT uses an Sembast database
WHEN the constructor is called
THEN an instance of the storage is returned
''',
    () async {
      final storage = {{objects.pascalCase()}}SembastStorage(
        database: await newDatabaseFactoryMemory().openDatabase(''),
      );
      expect(storage, isNotNull);
      expect(storage, isA<{{objects.pascalCase()}}Storage>());
    },
  );

  group(
    '''

GIVEN an {{objects.lowerCase()}} storage
├─ THAT uses an Sembast database''',
    () {
      late Database database;
      late {{objects.pascalCase()}}SembastStorage storage;
      late {{objects.pascalCase()}}StoreRef store;

      setUp(() async {
        final databaseFactoryMemory = newDatabaseFactoryMemory();
        database = await databaseFactoryMemory.openDatabase('/a/path');
        storage = {{objects.pascalCase()}}SembastStorage(database: database);
        store = storage.store;
      });

      tearDown(() async {
        await database.close();
      });

      test(
        '''

│  ├─ THAT does not have {{object.lowerCase()}} records
AND the valid data for a new {{object.lowerCase()}}
WHEN the {{object.lowerCase()}} is created
THEN a {{object.lowerCase()}} record is registered
''',
        () async {
          const new{{object.pascalCase()}} = New{{object.pascalCase()}}(
            name: 'name',
            description: 'description',
          );
          final existing{{objects.pascalCase()}}Count = await store.count(database);
          expect(existing{{objects.pascalCase()}}Count, isZero);
          await storage.create(new{{object.pascalCase()}}: new{{object.pascalCase()}});
          final resultingMatching{{objects.pascalCase()}}Count =
              await storage.store.count(
            database,
            filter: Filter.and([
              Filter.equals(
                Sembast{{object.pascalCase()}}.nameJsonKey,
                new{{object.pascalCase()}}.name,
              ),
              Filter.equals(
                Sembast{{object.pascalCase()}}.descriptionJsonKey,
                new{{object.pascalCase()}}.description,
              ),
            ]),
          );
          expect(
            resultingMatching{{objects.pascalCase()}}Count,
            existing{{objects.pascalCase()}}Count + 1,
          );
        },
      );

      test(
        '''

│  ├─ THAT has {{object.lowerCase()}} records
AND the valid data for a new {{object.lowerCase()}}
WHEN the {{object.lowerCase()}} is created
THEN a {{object.lowerCase()}} record is registered
''',
        () async {
          const existing{{object.pascalCase()}} = New{{object.pascalCase()}}(
            name: 'existing',
            description: 'description',
          );
          await store.add(database, existing{{object.pascalCase()}}.toSembastJson());
          final initial{{objects.pascalCase()}}Count = await store.count(database);
          expect(initial{{objects.pascalCase()}}Count, 1);
          const new{{object.pascalCase()}} = New{{object.pascalCase()}}(
            name: 'new',
            description: 'description',
          );
          await storage.create(new{{object.pascalCase()}}: new{{object.pascalCase()}});
          final resultingMatching{{objects.pascalCase()}}Count = await store.count(
            database,
            filter: Filter.and([
              Filter.equals(
                Sembast{{object.pascalCase()}}.nameJsonKey,
                new{{object.pascalCase()}}.name,
              ),
              Filter.equals(
                Sembast{{object.pascalCase()}}.descriptionJsonKey,
                new{{object.pascalCase()}}.description,
              ),
            ]),
          );
          expect(resultingMatching{{objects.pascalCase()}}Count, 1);
        },
      );

      test(
        '''

AND the invalid data for a new {{object.lowerCase()}}
WHEN the {{object.lowerCase()}} is created
THEN an exception is thrown
AND no {{object.lowerCase()}} record is registered
''',
        () async {
          const new{{object.pascalCase()}} = New{{object.pascalCase()}}(
            name: '',
            description: 'description',
          );
          final existing{{objects.pascalCase()}}Count = await store.count(database);
          expect(existing{{objects.pascalCase()}}Count, isZero);
          expect(
            () async => storage.create(new{{object.pascalCase()}}: new{{object.pascalCase()}}),
            throwsA(isA<Create{{object.pascalCase()}}FailureEmptyName>()),
          );
          final resulting{{objects.pascalCase()}}Count = await store.count(database);
          expect(resulting{{objects.pascalCase()}}Count, isZero);
        },
      );

      test(
        '''

│  ├─ THAT has {{object.lowerCase()}} records
AND the ID of a registered {{object.lowerCase()}}
WHEN the {{object.lowerCase()}} is deleted
THEN the {{object.lowerCase()}} record is dropped
AND the deleted {{object.lowerCase()}} is returned
''',
        () async {
          const {{object.camelCase()}}Id = 13;
          const new{{object.pascalCase()}} =
              New{{object.pascalCase()}}(name: 'name', description: 'description');
          await store
              .record({{object.camelCase()}}Id)
              .put(database, new{{object.pascalCase()}}.toSembastJson());
          final filter = Filter.byKey({{object.camelCase()}}Id);
          final initialMatching{{objects.pascalCase()}}Count = await store.count(
            database,
            filter: filter,
          );
          expect(initialMatching{{objects.pascalCase()}}Count, 1);
          final deleted{{object.pascalCase()}} = await storage.deleteById({{object.camelCase()}}Id);
          expect(deleted{{object.pascalCase()}}, isNotNull);
          expect(deleted{{object.pascalCase()}}?.id, {{object.camelCase()}}Id);
          final resultingMatching{{objects.pascalCase()}}Count =
              await store.count(database, filter: filter);
          expect(resultingMatching{{objects.pascalCase()}}Count, isZero);
        },
      );

      test(
        '''

│  ├─ THAT has {{object.lowerCase()}} records
AND the ID of an unregistered {{object.lowerCase()}}
WHEN the {{object.lowerCase()}} is deleted
THEN no {{object.lowerCase()}} record is dropped
AND null is returned
''',
        () async {
          const {{object.camelCase()}}Id = 17;
          const new{{object.pascalCase()}} =
              New{{object.pascalCase()}}(name: 'name', description: 'description');
          await store.add(database, new{{object.pascalCase()}}.toSembastJson());
          final initial{{objects.pascalCase()}} = await store.find(database);
          expect(initial{{objects.pascalCase()}}, hasLength(1));
          final initial{{object.pascalCase()}} =
              initial{{objects.pascalCase()}}.single.to{{object.pascalCase()}}();
          expect(initial{{object.pascalCase()}}.id, isNot({{object.camelCase()}}Id));
          final deleted{{object.pascalCase()}} = await storage.deleteById({{object.camelCase()}}Id);
          expect(deleted{{object.pascalCase()}}, isNull);
          final resulting{{objects.pascalCase()}} = await store.find(database);
          expect(resulting{{objects.pascalCase()}}, hasLength(1));
          final resulting{{object.pascalCase()}} = resulting{{objects.pascalCase()}}.single;
          expect(
            resulting{{object.pascalCase()}}.to{{object.pascalCase()}}(),
            initial{{object.pascalCase()}},
          );
        },
      );

      test(
        '''

│  ├─ THAT has several {{object.lowerCase()}} records
AND a reference {{object.lowerCase()}}
├─ THAT includes a non-null name matcher
├─ AND includes a non-null description matcher
WHEN a delete operation is performed with the reference {{object.lowerCase()}}
THEN the {{object.lowerCase()}} records matching the reference {{object.lowerCase()}} are dropped
AND the {{object.lowerCase()}} records not matching the reference {{object.lowerCase()}} are kept
''',
        () async {
          final {{objects.camelCase()}} = [
            const {{object.pascalCase()}}(
              id: 0,
              name: 'name 0',
              description: 'description 0',
            ),
            const {{object.pascalCase()}}(
              id: 1,
              name: 'name 1 matching-pattern',
              description: 'description 1',
            ),
            const {{object.pascalCase()}}(
              id: 2,
              name: 'name 2',
              description: 'description 2 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 3,
              name: 'name 3 matching-pattern',
              description: 'description 3 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 4,
              name: 'name 4',
              description: 'description 4',
            ),
            const {{object.pascalCase()}}(
              id: 5,
              name: 'name 5 matching-pattern',
              description: 'description 5',
            ),
            const {{object.pascalCase()}}(
              id: 6,
              name: 'name 6',
              description: 'description 6 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 7,
              name: 'name 7 matching-pattern',
              description: 'description 7 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 8,
              name: 'name 8',
              description: 'description 8',
            ),
            const {{object.pascalCase()}}(
              id: 9,
              name: 'name 9 matching-pattern',
              description: 'description 9',
            ),
            const {{object.pascalCase()}}(
              id: 10,
              name: 'name 10',
              description: 'description 10 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 11,
              name: 'name 11 matching-pattern',
              description: 'description 11 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 12,
              name: 'name 12',
              description: 'description 12',
            ),
            const {{object.pascalCase()}}(
              id: 13,
              name: 'name 13 matching-pattern',
              description: 'description 13',
            ),
            const {{object.pascalCase()}}(
              id: 14,
              name: 'name 14',
              description: 'description 14 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 15,
              name: 'name 15 matching-pattern',
              description: 'description 15 matching-pattern',
            ),
          ];
          await store
              .records(
                {{objects.camelCase()}}.map(
                  ({{object.camelCase()}}) => {{object.camelCase()}}.id,
                ),
              )
              .add(
                database,
                {{objects.camelCase()}}
                    .map(({{object.camelCase()}}) => {{object.camelCase()}}.toSembastJson())
                    .toList(),
              );
          final initial{{objects.pascalCase()}}Count = await store.count(database);
          expect(initial{{objects.pascalCase()}}Count, {{objects.camelCase()}}.length);
          const reference{{object.pascalCase()}} = Partial{{object.pascalCase()}}(
            name: Some('matching-pattern'),
            description: Some('matching-pattern'),
          );
          await storage.deleteAll(reference{{object.pascalCase()}}: reference{{object.pascalCase()}});
          final resultingSembast{{objects.pascalCase()}} = await store.find(database);

          bool shouldBeKept({{object.pascalCase()}} {{object.camelCase()}}) {
            final {{object.pascalCase()}}(:name, :description) = {{object.camelCase()}};
            final noMatchInTitle = !name.contains('matching-pattern');
            if (noMatchInTitle) return true;
            if (description == null) return true;
            final noMatchInDescription =
                !description.contains('matching-pattern');
            return noMatchInDescription;
          }

          final expectedResulting{{objects.pascalCase()}} = [
            for (final {{object.camelCase()}} in {{objects.camelCase()}})
              if (shouldBeKept({{object.camelCase()}})) {{object.camelCase()}},
          ];
          expect(
            resultingSembast{{objects.pascalCase()}},
            hasLength(expectedResulting{{objects.pascalCase()}}.length),
          );
          final resulting{{objects.pascalCase()}} = [
            for (final sembast{{object.pascalCase()}} in resultingSembast{{objects.pascalCase()}})
              sembast{{object.pascalCase()}}.to{{object.pascalCase()}}(),
          ];
          expect(
            resulting{{objects.pascalCase()}},
            unorderedEquals(expectedResulting{{objects.pascalCase()}}),
          );
        },
      );

      test(
        '''

│  ├─ THAT has several {{object.lowerCase()}} records
AND a reference {{object.lowerCase()}}
├─ THAT does not include a name matcher
├─ AND includes a non-null description matcher
WHEN a delete operation is performed with the reference {{object.lowerCase()}}
THEN the {{object.lowerCase()}} records matching the reference {{object.lowerCase()}} are dropped
AND the {{object.lowerCase()}} records not matching the reference {{object.lowerCase()}} are kept
''',
        () async {
          final {{objects.camelCase()}} = [
            const {{object.pascalCase()}}(
              id: 0,
              name: 'name 0',
              description: 'description 0',
            ),
            const {{object.pascalCase()}}(
              id: 1,
              name: 'name 1 matching-pattern',
              description: 'description 1',
            ),
            const {{object.pascalCase()}}(
              id: 2,
              name: 'name 2',
              description: 'description 2 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 3,
              name: 'name 3 matching-pattern',
              description: 'description 3 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 4,
              name: 'name 4',
              description: 'description 4',
            ),
            const {{object.pascalCase()}}(
              id: 5,
              name: 'name 5 matching-pattern',
              description: 'description 5',
            ),
            const {{object.pascalCase()}}(
              id: 6,
              name: 'name 6',
              description: 'description 6 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 7,
              name: 'name 7 matching-pattern',
              description: 'description 7 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 8,
              name: 'name 8',
              description: 'description 8',
            ),
            const {{object.pascalCase()}}(
              id: 9,
              name: 'name 9 matching-pattern',
              description: 'description 9',
            ),
            const {{object.pascalCase()}}(
              id: 10,
              name: 'name 10',
              description: 'description 10 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 11,
              name: 'name 11 matching-pattern',
              description: 'description 11 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 12,
              name: 'name 12',
              description: 'description 12',
            ),
            const {{object.pascalCase()}}(
              id: 13,
              name: 'name 13 matching-pattern',
              description: 'description 13',
            ),
            const {{object.pascalCase()}}(
              id: 14,
              name: 'name 14',
              description: 'description 14 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 15,
              name: 'name 15 matching-pattern',
              description: 'description 15 matching-pattern',
            ),
          ];
          await store
              .records(
                {{objects.camelCase()}}.map(
                  ({{object.camelCase()}}) => {{object.camelCase()}}.id,
                ),
              )
              .add(
                database,
                {{objects.camelCase()}}
                    .map(({{object.camelCase()}}) => {{object.camelCase()}}.toSembastJson())
                    .toList(),
              );
          final initial{{objects.pascalCase()}}Count = await store.count(database);
          expect(initial{{objects.pascalCase()}}Count, {{objects.camelCase()}}.length);
          const reference{{object.pascalCase()}} = Partial{{object.pascalCase()}}(
            description: Some('matching-pattern'),
          );
          await storage.deleteAll(reference{{object.pascalCase()}}: reference{{object.pascalCase()}});
          final resultingSembast{{objects.pascalCase()}} = await store.find(database);

          bool shouldBeKept({{object.pascalCase()}} {{object.camelCase()}}) {
            final {{object.pascalCase()}}(:description) = {{object.camelCase()}};
            if (description == null) return true;
            final noMatchInDescription =
                !description.contains('matching-pattern');
            return noMatchInDescription;
          }

          final expectedResulting{{objects.pascalCase()}} = [
            for (final {{object.camelCase()}} in {{objects.camelCase()}})
              if (shouldBeKept({{object.camelCase()}})) {{object.camelCase()}},
          ];
          expect(
            resultingSembast{{objects.pascalCase()}},
            hasLength(expectedResulting{{objects.pascalCase()}}.length),
          );
          final resulting{{objects.pascalCase()}} = [
            for (final sembast{{object.pascalCase()}} in resultingSembast{{objects.pascalCase()}})
              sembast{{object.pascalCase()}}.to{{object.pascalCase()}}(),
          ];
          expect(
            resulting{{objects.pascalCase()}},
            unorderedEquals(expectedResulting{{objects.pascalCase()}}),
          );
        },
      );

      test(
        '''

│  ├─ THAT has several {{object.lowerCase()}} records
AND a reference {{object.lowerCase()}}
├─ THAT includes a non-null name matcher
├─ AND includes a null description matcher
WHEN a delete operation is performed with the reference {{object.lowerCase()}}
THEN the {{object.lowerCase()}} records matching the reference {{object.lowerCase()}} are dropped
AND the {{object.lowerCase()}} records not matching the reference {{object.lowerCase()}} are kept
''',
        () async {
          final {{objects.camelCase()}} = [
            const {{object.pascalCase()}}(
              id: 0,
              name: 'name 0',
              description: 'description 0',
            ),
            const {{object.pascalCase()}}(
              id: 1,
              name: 'name 1 matching-pattern',
              description: 'description 1',
            ),
            const {{object.pascalCase()}}(
              id: 2,
              name: 'name 2',
              description: 'description 2 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 3,
              name: 'name 3 matching-pattern',
              description: 'description 3 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 4,
              name: 'name 4',
              description: 'description 4',
            ),
            const {{object.pascalCase()}}(
              id: 5,
              name: 'name 5 matching-pattern',
              description: 'description 5',
            ),
            const {{object.pascalCase()}}(
              id: 6,
              name: 'name 6',
              description: 'description 6 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 7,
              name: 'name 7 matching-pattern',
              description: 'description 7 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 8,
              name: 'name 8',
              description: 'description 8',
            ),
            const {{object.pascalCase()}}(
              id: 9,
              name: 'name 9 matching-pattern',
              description: 'description 9',
            ),
            const {{object.pascalCase()}}(
              id: 10,
              name: 'name 10',
              description: 'description 10 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 11,
              name: 'name 11 matching-pattern',
              description: 'description 11 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 12,
              name: 'name 12',
              description: 'description 12',
            ),
            const {{object.pascalCase()}}(
              id: 13,
              name: 'name 13 matching-pattern',
              description: 'description 13',
            ),
            const {{object.pascalCase()}}(
              id: 14,
              name: 'name 14',
              description: 'description 14 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 15,
              name: 'name 15 matching-pattern',
              description: 'description 15 matching-pattern',
            ),
          ];
          await store
              .records(
                {{objects.camelCase()}}.map(
                  ({{object.camelCase()}}) => {{object.camelCase()}}.id,
                ),
              )
              .add(
                database,
                {{objects.camelCase()}}
                    .map(({{object.camelCase()}}) => {{object.camelCase()}}.toSembastJson())
                    .toList(),
              );
          final initial{{objects.pascalCase()}}Count = await store.count(database);
          expect(initial{{objects.pascalCase()}}Count, {{objects.camelCase()}}.length);
          const reference{{object.pascalCase()}} = Partial{{object.pascalCase()}}(
            name: Some('matching-pattern'),
            description: Some(null),
          );
          await storage.deleteAll(reference{{object.pascalCase()}}: reference{{object.pascalCase()}});
          final resultingSembast{{objects.pascalCase()}} = await store.find(database);

          bool shouldBeKept({{object.pascalCase()}} {{object.camelCase()}}) {
            final {{object.pascalCase()}}(:name, :description) = {{object.camelCase()}};
            final noMatchInTitle = !name.contains('matching-pattern');
            if (noMatchInTitle) return true;
            return description != null;
          }

          final expectedResulting{{objects.pascalCase()}} = [
            for (final {{object.camelCase()}} in {{objects.camelCase()}})
              if (shouldBeKept({{object.camelCase()}})) {{object.camelCase()}},
          ];
          expect(
            resultingSembast{{objects.pascalCase()}},
            hasLength(expectedResulting{{objects.pascalCase()}}.length),
          );
          final resulting{{objects.pascalCase()}} = [
            for (final sembast{{object.pascalCase()}} in resultingSembast{{objects.pascalCase()}})
              sembast{{object.pascalCase()}}.to{{object.pascalCase()}}(),
          ];
          expect(
            resulting{{objects.pascalCase()}},
            unorderedEquals(expectedResulting{{objects.pascalCase()}}),
          );
        },
      );

      test(
        '''

│  ├─ THAT has several {{object.lowerCase()}} records
AND a reference {{object.lowerCase()}}
├─ THAT includes a non-null name matcher
├─ AND includes a non-null empty description matcher
WHEN a delete operation is performed with the reference {{object.lowerCase()}}
THEN the {{object.lowerCase()}} records matching the reference {{object.lowerCase()}} are dropped
AND the {{object.lowerCase()}} records not matching the reference {{object.lowerCase()}} are kept
''',
        () async {
          final {{objects.camelCase()}} = [
            const {{object.pascalCase()}}(
              id: 0,
              name: 'name 0',
              description: 'description 0',
            ),
            const {{object.pascalCase()}}(
              id: 1,
              name: 'name 1 matching-pattern',
              description: 'description 1',
            ),
            const {{object.pascalCase()}}(
              id: 2,
              name: 'name 2',
              description: 'description 2 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 3,
              name: 'name 3 matching-pattern',
              description: 'description 3 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 4,
              name: 'name 4',
              description: 'description 4',
            ),
            const {{object.pascalCase()}}(
              id: 5,
              name: 'name 5 matching-pattern',
              description: 'description 5',
            ),
            const {{object.pascalCase()}}(
              id: 6,
              name: 'name 6',
              description: 'description 6 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 7,
              name: 'name 7 matching-pattern',
              description: 'description 7 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 8,
              name: 'name 8',
              description: 'description 8',
            ),
            const {{object.pascalCase()}}(
              id: 9,
              name: 'name 9 matching-pattern',
              description: 'description 9',
            ),
            const {{object.pascalCase()}}(
              id: 10,
              name: 'name 10',
              description: 'description 10 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 11,
              name: 'name 11 matching-pattern',
              description: 'description 11 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 12,
              name: 'name 12',
              description: 'description 12',
            ),
            const {{object.pascalCase()}}(
              id: 13,
              name: 'name 13 matching-pattern',
              description: 'description 13',
            ),
            const {{object.pascalCase()}}(
              id: 14,
              name: 'name 14',
              description: 'description 14 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 15,
              name: 'name 15 matching-pattern',
              description: 'description 15 matching-pattern',
            ),
          ];
          await store
              .records(
                {{objects.camelCase()}}.map(
                  ({{object.camelCase()}}) => {{object.camelCase()}}.id,
                ),
              )
              .add(
                database,
                {{objects.camelCase()}}
                    .map(({{object.camelCase()}}) => {{object.camelCase()}}.toSembastJson())
                    .toList(),
              );
          final initial{{objects.pascalCase()}}Count = await store.count(database);
          expect(initial{{objects.pascalCase()}}Count, {{objects.camelCase()}}.length);
          const reference{{object.pascalCase()}} = Partial{{object.pascalCase()}}(
            name: Some('matching-pattern'),
            description: Some(''),
          );
          await storage.deleteAll(reference{{object.pascalCase()}}: reference{{object.pascalCase()}});
          final resultingSembast{{objects.pascalCase()}} = await store.find(database);

          bool shouldBeKept({{object.pascalCase()}} {{object.camelCase()}}) {
            final {{object.pascalCase()}}(:name) = {{object.camelCase()}};
            final noMatchInTitle = !name.contains('matching-pattern');
            return noMatchInTitle;
          }

          final expectedResulting{{objects.pascalCase()}} = [
            for (final {{object.camelCase()}} in {{objects.camelCase()}})
              if (shouldBeKept({{object.camelCase()}})) {{object.camelCase()}},
          ];
          expect(
            resultingSembast{{objects.pascalCase()}},
            hasLength(expectedResulting{{objects.pascalCase()}}.length),
          );
          final resulting{{objects.pascalCase()}} = [
            for (final sembast{{object.pascalCase()}} in resultingSembast{{objects.pascalCase()}})
              sembast{{object.pascalCase()}}.to{{object.pascalCase()}}(),
          ];
          expect(
            resulting{{objects.pascalCase()}},
            unorderedEquals(expectedResulting{{objects.pascalCase()}}),
          );
        },
      );

      test(
        '''

│  ├─ THAT has several {{object.lowerCase()}} records
AND a reference {{object.lowerCase()}}
├─ THAT includes a non-null name matcher
├─ THAT includes an empty description matcher
WHEN a delete operation is performed with the reference {{object.lowerCase()}}
THEN the {{object.lowerCase()}} records matching the reference {{object.lowerCase()}} are dropped
AND the {{object.lowerCase()}} records not matching the reference {{object.lowerCase()}} are kept
''',
        () async {
          final {{objects.camelCase()}} = [
            const {{object.pascalCase()}}(
              id: 0,
              name: 'name 0',
              description: 'description 0',
            ),
            const {{object.pascalCase()}}(
              id: 1,
              name: 'name 1 matching-pattern',
              description: 'description 1',
            ),
            const {{object.pascalCase()}}(
              id: 2,
              name: 'name 2',
              // ignore: avoid_redundant_argument_values
              description: null,
            ),
            const {{object.pascalCase()}}(
              id: 3,
              name: 'name 3 matching-pattern',
              // ignore: avoid_redundant_argument_values
              description: null,
            ),
            const {{object.pascalCase()}}(
              id: 4,
              name: 'name 4',
              description: 'description 4',
            ),
            const {{object.pascalCase()}}(
              id: 5,
              name: 'name 5 matching-pattern',
              description: 'description 5',
            ),
            const {{object.pascalCase()}}(
              id: 6,
              name: 'name 6',
              // ignore: avoid_redundant_argument_values
              description: null,
            ),
            const {{object.pascalCase()}}(
              id: 7,
              name: 'name 7 matching-pattern',
              // ignore: avoid_redundant_argument_values
              description: null,
            ),
            const {{object.pascalCase()}}(
              id: 8,
              name: 'name 8',
              description: 'description 8',
            ),
            const {{object.pascalCase()}}(
              id: 9,
              name: 'name 9 matching-pattern',
              description: 'description 9',
            ),
            const {{object.pascalCase()}}(
              id: 10,
              name: 'name 10',
              // ignore: avoid_redundant_argument_values
              description: null,
            ),
            const {{object.pascalCase()}}(
              id: 11,
              name: 'name 11 matching-pattern',
              // ignore: avoid_redundant_argument_values
              description: null,
            ),
            const {{object.pascalCase()}}(
              id: 12,
              name: 'name 12',
              description: 'description 12',
            ),
            const {{object.pascalCase()}}(
              id: 13,
              name: 'name 13 matching-pattern',
              description: 'description 13',
            ),
            const {{object.pascalCase()}}(
              id: 14,
              name: 'name 14',
              // ignore: avoid_redundant_argument_values
              description: null,
            ),
            const {{object.pascalCase()}}(
              id: 15,
              name: 'name 15 matching-pattern',
              // ignore: avoid_redundant_argument_values
              description: null,
            ),
          ];
          await store
              .records(
                {{objects.camelCase()}}.map(
                  ({{object.camelCase()}}) => {{object.camelCase()}}.id,
                ),
              )
              .add(
                database,
                {{objects.camelCase()}}
                    .map(({{object.camelCase()}}) => {{object.camelCase()}}.toSembastJson())
                    .toList(),
              );
          final initial{{objects.pascalCase()}}Count = await store.count(database);
          expect(initial{{objects.pascalCase()}}Count, {{objects.camelCase()}}.length);
          const reference{{object.pascalCase()}} = Partial{{object.pascalCase()}}(
            name: Some('matching-pattern'),
            description: Some(null),
          );
          await storage.deleteAll(reference{{object.pascalCase()}}: reference{{object.pascalCase()}});
          final resultingSembast{{objects.pascalCase()}} = await store.find(database);

          bool shouldBeKept({{object.pascalCase()}} {{object.camelCase()}}) {
            final {{object.pascalCase()}}(:name, :description) = {{object.camelCase()}};
            final noMatchInTitle = !name.contains('matching-pattern');
            if (noMatchInTitle) return true;
            final noMatchInDescription =
                description != null && description.isNotEmpty;
            return noMatchInDescription;
          }

          final expectedResulting{{objects.pascalCase()}} = [
            for (final {{object.camelCase()}} in {{objects.camelCase()}})
              if (shouldBeKept({{object.camelCase()}})) {{object.camelCase()}},
          ];
          expect(
            resultingSembast{{objects.pascalCase()}},
            hasLength(expectedResulting{{objects.pascalCase()}}.length),
          );
          final resulting{{objects.pascalCase()}} = [
            for (final sembast{{object.pascalCase()}} in resultingSembast{{objects.pascalCase()}})
              sembast{{object.pascalCase()}}.to{{object.pascalCase()}}(),
          ];
          expect(
            resulting{{objects.pascalCase()}},
            unorderedEquals(expectedResulting{{objects.pascalCase()}}),
          );
        },
      );

      test(
        '''

│  ├─ THAT has several {{object.lowerCase()}} records
WHEN a delete operation is performed with no reference {{object.lowerCase()}}
THEN all {{object.lowerCase()}} records are dropped
''',
        () async {
          final {{objects.camelCase()}} = List.generate(
            30,
            (index) => {{object.pascalCase()}}(
              id: index,
              name: 'name $index',
              description: 'description $index',
            ),
          );
          await store.addAll(
            database,
            {{objects.camelCase()}}
                .map(({{object.camelCase()}}) => {{object.camelCase()}}.toSembastJson())
                .toList(),
          );
          final initial{{objects.pascalCase()}}Count = await store.count(database);
          expect(initial{{objects.pascalCase()}}Count, {{objects.camelCase()}}.length);
          await storage.deleteAll();
          final resultingSembast{{objects.pascalCase()}}Count =
              await store.count(database);
          expect(resultingSembast{{objects.pascalCase()}}Count, isZero);
        },
      );

      test(
        '''

AND a {{object.lowerCase()}}
WHEN the {{object.lowerCase()}} is inserted
THEN a {{object.lowerCase()}} record is registered
''',
        () async {
          const {{object.camelCase()}} = {{object.pascalCase()}}(
            id: 83,
            name: 'name',
            description: 'description',
          );
          final existing{{objects.pascalCase()}}Count = await store.count(database);
          expect(existing{{objects.pascalCase()}}Count, isZero);
          await storage.insert({{object.camelCase()}}: {{object.camelCase()}});
          final resultingSembast{{objects.pascalCase()}} = await store.find(database);
          expect(resultingSembast{{objects.pascalCase()}}, hasLength(1));
          final resultingSembast{{object.pascalCase()}} =
              resultingSembast{{objects.pascalCase()}}.single;
          expect(resultingSembast{{object.pascalCase()}}.to{{object.pascalCase()}}(), {{object.camelCase()}});
        },
      );

      test(
        '''

AND the ID of a registered {{object.lowerCase()}}
AND the valid partial {{object.lowerCase()}} data
WHEN the {{object.lowerCase()}} is updated
THEN a {{object.lowerCase()}} record is updated
''',
        () async {
          const {{object.camelCase()}} = {{object.pascalCase()}}(
            id: 31,
            name: 'name',
            description: 'description',
          );
          await store
              .record({{object.camelCase()}}.id)
              .add(database, {{object.camelCase()}}.toSembastJson());
          final existing{{objects.pascalCase()}}Count = await store.count(database);
          expect(existing{{objects.pascalCase()}}Count, 1);
          const newName = 'new name';
          const newDescription = 'new description';
          final filter = Filter.and([
            Filter.byKey({{object.camelCase()}}.id),
            Filter.equals(
              Sembast{{object.pascalCase()}}.nameJsonKey,
              newName,
            ),
            Filter.equals(
              Sembast{{object.pascalCase()}}.descriptionJsonKey,
              newDescription,
            ),
          ]);
          final existingMatching{{objects.pascalCase()}}Count = await store.count(
            database,
            filter: filter,
          );
          expect(existingMatching{{objects.pascalCase()}}Count, isZero);
          await storage.update(
            {{object.camelCase()}}Id: {{object.camelCase()}}.id,
            partial{{object.pascalCase()}}: const Partial{{object.pascalCase()}}(
              name: Some(newName),
              description: Some(newDescription),
            ),
          );
          final resultingMatching{{objects.pascalCase()}}Count = await store.count(
            database,
            filter: filter,
          );
          expect(
            resultingMatching{{objects.pascalCase()}}Count,
            existingMatching{{objects.pascalCase()}}Count + 1,
          );
        },
      );

      test(
        '''

AND the invalid data for a new {{object.lowerCase()}}
WHEN the {{object.lowerCase()}} is created
THEN an exception is thrown
AND no {{object.lowerCase()}} record is registered
''',
        () async {
          const new{{object.pascalCase()}} = New{{object.pascalCase()}}(
            name: '',
            description: 'description',
          );
          final existing{{objects.pascalCase()}}Count = await store.count(database);
          expect(existing{{objects.pascalCase()}}Count, isZero);
          expect(
            () async => storage.create(new{{object.pascalCase()}}: new{{object.pascalCase()}}),
            throwsA(isA<Create{{object.pascalCase()}}FailureEmptyName>()),
          );
          final resulting{{objects.pascalCase()}}Count = await store.count(database);
          expect(resulting{{objects.pascalCase()}}Count, isZero);
        },
      );

      test(
        '''

AND the ID of a registered {{object.lowerCase()}}
AND the invalid partial {{object.lowerCase()}} data
WHEN the {{object.lowerCase()}} is updated
THEN an exception is thrown
AND no {{object.lowerCase()}} record is updated
''',
        () async {
          const {{object.camelCase()}} = {{object.pascalCase()}}(
            id: 103,
            name: 'name',
            description: 'description',
          );
          await store.add(database, {{object.camelCase()}}.toSembastJson());
          final existing{{objects.pascalCase()}}Count = await store.count(database);
          expect(existing{{objects.pascalCase()}}Count, 1);
          const newName = '';
          const newDescription = 'new description';
          final filter = Filter.and([
            Filter.byKey({{object.camelCase()}}.id),
            Filter.equals(
              Sembast{{object.pascalCase()}}.nameJsonKey,
              newName,
            ),
            Filter.equals(
              Sembast{{object.pascalCase()}}.descriptionJsonKey,
              newDescription,
            ),
          ]);
          final existingMatching{{objects.pascalCase()}}Count =
              await store.count(database, filter: filter);
          expect(existingMatching{{objects.pascalCase()}}Count, isZero);
          expect(
            () async => storage.update(
              {{object.camelCase()}}Id: {{object.camelCase()}}.id,
              partial{{object.pascalCase()}}: const Partial{{object.pascalCase()}}(
                name: Some(newName),
                description: Some(newDescription),
              ),
            ),
            throwsA(isA<Update{{object.pascalCase()}}FailureEmptyName>()),
          );
          final resultingMatching{{objects.pascalCase()}}Count =
              await store.count(database, filter: filter);
          expect(resultingMatching{{objects.pascalCase()}}Count, isZero);
        },
      );

      test(
        '''

│  ├─ THAT has {{object.lowerCase()}} records
AND the ID of a registered {{object.lowerCase()}}
WHEN the {{object.lowerCase()}} is requested
THEN the {{object.lowerCase()}} is returned
''',
        () async {
          const {{object.camelCase()}}Id = 991;
          const {{object.camelCase()}} = {{object.pascalCase()}}(
            id: {{object.camelCase()}}Id,
            name: 'name',
            description: 'description',
          );
          await store
              .record({{object.camelCase()}}Id)
              .add(database, {{object.camelCase()}}.toSembastJson());
          final filter = Filter.byKey({{object.camelCase()}}Id);
          final initialMatching{{objects.pascalCase()}}Count =
              await store.count(database, filter: filter);
          expect(initialMatching{{objects.pascalCase()}}Count, 1);
          final retrieved{{object.pascalCase()}} = await storage.getById({{object.camelCase()}}Id);
          expect(retrieved{{object.pascalCase()}}, isNotNull);
          expect(retrieved{{object.pascalCase()}}, {{object.camelCase()}});
        },
      );

      test(
        '''

│  ├─ THAT has {{object.lowerCase()}} records
AND the ID of an unregistered {{object.lowerCase()}}
WHEN the {{object.lowerCase()}} is requested
THEN null is returned
''',
        () async {
          const {{object.camelCase()}}Id = 325;
          final filter = Filter.byKey({{object.camelCase()}}Id);
          final initialMatching{{objects.pascalCase()}}Count = await store.count(
            database,
            filter: filter,
          );
          expect(initialMatching{{objects.pascalCase()}}Count, isZero);
          final retrieved{{object.pascalCase()}} = await storage.getById({{object.camelCase()}}Id);
          expect(retrieved{{object.pascalCase()}}, isNull);
        },
      );

      test(
        '''

│  ├─ THAT has {{object.lowerCase()}} records
WHEN a {{objects.lowerCase()}} page is watched
├─ THAT are not filtered by their content
THEN the {{objects.lowerCase()}} are continuously emitted as they change
''',
        () async {
          final stream = storage.watch();

          // Stage 00
          final {{objects.camelCase()}}ForStage00 = <{{object.pascalCase()}}>[
            const {{object.pascalCase()}}(
              id: 0,
              name: 'name 00',
              description: 'description 00',
            ),
            const {{object.pascalCase()}}(
              id: 1,
              name: 'name 01',
            ),
            const {{object.pascalCase()}}(
              id: 2,
              name: 'name 02',
            ),
          ];
          final sorted{{objects.pascalCase()}}ForStage00 = [...{{objects.camelCase()}}ForStage00]
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          // Stage 01
          const new{{object.pascalCase()}}InStage01 = {{object.pascalCase()}}(
            id: 3,
            name: 'name 03',
          );
          final {{objects.camelCase()}}ForStage01 = <{{object.pascalCase()}}>[
            ...{{objects.camelCase()}}ForStage00,
            new{{object.pascalCase()}}InStage01,
          ];
          final sorted{{objects.pascalCase()}}ForStage01 = [...{{objects.camelCase()}}ForStage01]
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          // Stage 02
          final {{objects.camelCase()}}ForStage02 = <{{object.pascalCase()}}>[
            for (final {{object.camelCase()}} in {{objects.camelCase()}}ForStage01)
              if (!{{object.camelCase()}}.name.contains('01')) {{object.camelCase()}},
          ];
          final sorted{{objects.pascalCase()}}ForStage02 = [...{{objects.camelCase()}}ForStage02]
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          // Stage 03
          final {{objects.camelCase()}}ForStage03 = <{{object.pascalCase()}}>[
            for (final {{object.camelCase()}} in {{objects.camelCase()}}ForStage02)
              if ({{object.camelCase()}}.description == null)
                {{object.pascalCase()}}(
                  id: {{object.camelCase()}}.id,
                  name: {{object.camelCase()}}.name,
                  description: 'updated description',
                )
              else
                {{object.camelCase()}},
          ];
          final sorted{{objects.pascalCase()}}ForStage03 = [...{{objects.camelCase()}}ForStage03]
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          unawaited(
            expectLater(
              stream,
              emitsInOrder(
                [
                  List<{{object.pascalCase()}}>.empty(), // initially empty
                  orderedEquals(sorted{{objects.pascalCase()}}ForStage00),
                  orderedEquals(sorted{{objects.pascalCase()}}ForStage01),
                  orderedEquals(sorted{{objects.pascalCase()}}ForStage02),
                  orderedEquals(sorted{{objects.pascalCase()}}ForStage03),
                ],
              ),
            ),
          );

          // Stage 00
          await store
              .records(
            {{objects.camelCase()}}ForStage00.map(
              (element) => element.id,
            ),
          )
              .add(
            database,
            [
              for (final {{object.camelCase()}} in {{objects.camelCase()}}ForStage00)
                {{object.camelCase()}}.toSembastJson(),
            ],
          );

          // Stage 01
          await store.record(new{{object.pascalCase()}}InStage01.id).add(
                database,
                new{{object.pascalCase()}}InStage01.toSembastJson(),
              );

          // Stage 02
          await store.delete(
            database,
            finder: Finder(
              filter: Filter.matches(
                Sembast{{object.pascalCase()}}.nameJsonKey,
                '01',
              ),
            ),
          );

          // Stage 03
          await store.update(
            database,
            {Sembast{{object.pascalCase()}}.descriptionJsonKey: 'updated description'},
            finder: Finder(
              filter: Filter.isNull(Sembast{{object.pascalCase()}}.descriptionJsonKey),
            ),
          );
        },
      );

      test(
        '''

│  ├─ THAT has {{object.lowerCase()}} records
WHEN a {{objects.lowerCase()}} are watched
├─ THAT are filtered by their content
THEN the {{objects.lowerCase()}} are continuously emitted as they change
''',
        () async {
          final stream = storage.watch(searchTerm: 'matching-pattern');
          bool match({{object.pascalCase()}} {{object.camelCase()}}) =>
              {{object.camelCase()}}.name.contains('matching-pattern') ||
              ({{object.camelCase()}}.description?.contains('matching-pattern') ?? false);

          // Stage 00
          final {{objects.camelCase()}}ForStage00 = <{{object.pascalCase()}}>[
            const {{object.pascalCase()}}(
              id: 0,
              name: 'name 00',
            ),
            const {{object.pascalCase()}}(
              id: 1,
              name: 'name 01 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 2,
              name: 'name 02',
              description: 'description 02 matching-pattern',
            ),
          ];
          final expected{{objects.pascalCase()}}ForStage00 = {{objects.camelCase()}}ForStage00
              .where(match)
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          // Stage 01
          const new{{object.pascalCase()}}InStage01 = {{object.pascalCase()}}(
            id: 3,
            name: 'name 03 matching-pattern',
          );
          final {{objects.camelCase()}}ForStage01 = <{{object.pascalCase()}}>[
            ...{{objects.camelCase()}}ForStage00,
            new{{object.pascalCase()}}InStage01,
          ];
          final expected{{objects.pascalCase()}}ForStage01 = {{objects.camelCase()}}ForStage01
              .where(match)
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          // Stage 02
          final {{objects.camelCase()}}ForStage02 = <{{object.pascalCase()}}>[
            for (final {{object.camelCase()}} in {{objects.camelCase()}}ForStage01)
              if (!{{object.camelCase()}}.name.contains('01')) {{object.camelCase()}},
          ];
          final expected{{objects.pascalCase()}}ForStage02 = {{objects.camelCase()}}ForStage02
              .where(match)
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          // Stage 03
          final {{objects.camelCase()}}ForStage03 = <{{object.pascalCase()}}>[
            for (final {{object.camelCase()}} in {{objects.camelCase()}}ForStage02)
              if ({{object.camelCase()}}.description == null)
                {{object.pascalCase()}}(
                  id: {{object.camelCase()}}.id,
                  name: {{object.camelCase()}}.name,
                  description: 'updated description matching-pattern',
                )
              else
                {{object.camelCase()}},
          ];
          final expected{{objects.pascalCase()}}ForStage03 = {{objects.camelCase()}}ForStage03
              .where(match)
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          unawaited(
            expectLater(
              stream,
              emitsInOrder([
                List<{{object.pascalCase()}}>.empty(), // initially empty
                orderedEquals(expected{{objects.pascalCase()}}ForStage00),
                orderedEquals(expected{{objects.pascalCase()}}ForStage01),
                orderedEquals(expected{{objects.pascalCase()}}ForStage02),
                orderedEquals(expected{{objects.pascalCase()}}ForStage03),
              ]),
            ),
          );

          // Stage 00
          await store
              .records(
            {{objects.camelCase()}}ForStage00.map(
              (element) => element.id,
            ),
          )
              .add(
            database,
            [
              for (final {{object.camelCase()}} in {{objects.camelCase()}}ForStage00)
                {{object.camelCase()}}.toSembastJson(),
            ],
          );

          // Stage 01
          await store.record(new{{object.pascalCase()}}InStage01.id).add(
                database,
                new{{object.pascalCase()}}InStage01.toSembastJson(),
              );

          // Stage 02
          await store.delete(
            database,
            finder: Finder(
              filter: Filter.matches(
                Sembast{{object.pascalCase()}}.nameJsonKey,
                '01',
              ),
            ),
          );

          // Stage 03
          await store.update(
            database,
            {
              Sembast{{object.pascalCase()}}.descriptionJsonKey:
                  'updated description matching-pattern',
            },
            finder: Finder(
              filter: Filter.isNull(Sembast{{object.pascalCase()}}.descriptionJsonKey),
            ),
          );
        },
      );

      test(
        '''

│  ├─ THAT has {{object.lowerCase()}} records
WHEN the {{objects.lowerCase()}} count is watched
├─ THAT are not filtered by their content
THEN the quantity of persisted {{objects.lowerCase()}} are continuously emitted as it changes
''',
        () async {
          final stream = storage.watchCount();

          // Stage 00
          final {{objects.camelCase()}}ForStage00 = <{{object.pascalCase()}}>[
            const {{object.pascalCase()}}(
              id: 0,
              name: 'name 00',
              description: 'description 00',
            ),
            const {{object.pascalCase()}}(
              id: 1,
              name: 'name 01',
            ),
            const {{object.pascalCase()}}(
              id: 2,
              name: 'name 02',
              description: 'description 02',
            ),
          ];

          // Stage 01
          const new{{object.pascalCase()}}InStage01 = {{object.pascalCase()}}(
            id: 3,
            name: 'name 03',
          );
          final {{objects.camelCase()}}ForStage01 = <{{object.pascalCase()}}>[
            ...{{objects.camelCase()}}ForStage00,
            new{{object.pascalCase()}}InStage01,
          ];

          // Stage 02
          final {{objects.camelCase()}}ForStage02 = <{{object.pascalCase()}}>[
            for (final {{object.camelCase()}} in {{objects.camelCase()}}ForStage01)
              if (!{{object.camelCase()}}.name.contains('01')) {{object.camelCase()}},
          ];

          // Stage 03
          // final {{objects.camelCase()}}ForStage03 = <{{object.pascalCase()}}>[
          //   for (final {{object.camelCase()}} in {{objects.camelCase()}}ForStage02)
          //     if ({{object.camelCase()}}.description == null)
          //       {{object.pascalCase()}}(
          //         id: {{object.camelCase()}}.id,
          //         name: {{object.camelCase()}}.name,
          //         description: 'updated description',
          //       )
          //     else
          //       {{object.camelCase()}},
          // ];

          unawaited(
            expectLater(
              stream,
              emitsInOrder([
                0, // initially empty
                {{objects.camelCase()}}ForStage00.length,
                {{objects.camelCase()}}ForStage01.length,
                {{objects.camelCase()}}ForStage02.length,

                // Not emitted as the {{objects.lowerCase()}} count has not changed
                // {{objects.camelCase()}}ForStage03.length,
              ]),
            ),
          );

          // Stage 00
          await store
              .records(
            {{objects.camelCase()}}ForStage00.map(
              (element) => element.id,
            ),
          )
              .add(
            database,
            [
              for (final {{object.camelCase()}} in {{objects.camelCase()}}ForStage00)
                {{object.camelCase()}}.toSembastJson(),
            ],
          );

          // Stage 01
          await store.record(new{{object.pascalCase()}}InStage01.id).add(
                database,
                new{{object.pascalCase()}}InStage01.toSembastJson(),
              );

          // Stage 02
          await store.delete(
            database,
            finder: Finder(
              filter: Filter.matches(
                Sembast{{object.pascalCase()}}.nameJsonKey,
                '01',
              ),
            ),
          );

          // Stage 03
          await store.update(
            database,
            {Sembast{{object.pascalCase()}}.descriptionJsonKey: 'updated description'},
            finder: Finder(
              filter: Filter.isNull(Sembast{{object.pascalCase()}}.descriptionJsonKey),
            ),
          );
        },
      );

      test(
        '''

│  ├─ THAT has {{object.lowerCase()}} records
WHEN the {{objects.lowerCase()}} count is watched
├─ THAT are filtered by their content
THEN the quantity of persisted {{objects.lowerCase()}} that match the conditions is continuously emitted as it changes
''',
        () async {
          final stream = storage.watchCount(searchTerm: 'matching-pattern');
          bool match({{object.pascalCase()}} {{object.camelCase()}}) =>
              {{object.camelCase()}}.name.contains('matching-pattern') ||
              ({{object.camelCase()}}.description?.contains('matching-pattern') ?? false);

          // Stage 00
          final {{objects.camelCase()}}ForStage00 = <{{object.pascalCase()}}>[
            const {{object.pascalCase()}}(
              id: 0,
              name: 'name 00',
              description: 'description 00',
            ),
            const {{object.pascalCase()}}(
              id: 1,
              name: 'name 01 matching-pattern',
            ),
            const {{object.pascalCase()}}(
              id: 2,
              name: 'name 02',
              description: 'description 02 matching-pattern',
            ),
          ];
          final expected{{objects.pascalCase()}}ForStage00 =
              {{objects.camelCase()}}ForStage00.where(match);

          // Stage 01
          const new{{object.pascalCase()}}InStage01 = {{object.pascalCase()}}(
            id: 3,
            name: 'name 03 matching-pattern',
          );
          final {{objects.camelCase()}}ForStage01 = <{{object.pascalCase()}}>[
            ...{{objects.camelCase()}}ForStage00,
            new{{object.pascalCase()}}InStage01,
          ];
          final expected{{objects.pascalCase()}}ForStage01 =
              {{objects.camelCase()}}ForStage01.where(match);

          // Stage 02
          final {{objects.camelCase()}}ForStage02 = <{{object.pascalCase()}}>[
            for (final {{object.camelCase()}} in {{objects.camelCase()}}ForStage01)
              if (!{{object.camelCase()}}.name.contains('01')) {{object.camelCase()}},
          ];
          final expected{{objects.pascalCase()}}ForStage02 =
              {{objects.camelCase()}}ForStage02.where(match);

          // Stage 03
          // final {{objects.camelCase()}}ForStage03 = <{{object.pascalCase()}}>[
          //   for (final {{object.camelCase()}} in {{objects.camelCase()}}ForStage02)
          //     if ({{object.camelCase()}}.description == null)
          //       {{object.pascalCase()}}(
          //         id: {{object.camelCase()}}.id,
          //         name: {{object.camelCase()}}.name,
          //         description: 'updated description',
          //       )
          //     else
          //       {{object.camelCase()}},
          // ];
          // final expected{{objects.pascalCase()}}ForStage03 =
          //     {{objects.camelCase()}}ForStage03.where(match);

          unawaited(
            expectLater(
              stream,
              emitsInOrder(
                [
                  0, // initially empty
                  expected{{objects.pascalCase()}}ForStage00.length,
                  expected{{objects.pascalCase()}}ForStage01.length,
                  expected{{objects.pascalCase()}}ForStage02.length,

                  // Not emitted as the {{objects.lowerCase()}} count has not changed
                  // expected{{objects.pascalCase()}}ForStage03.length,
                ],
              ),
            ),
          );

          // Stage 00
          await store
              .records(
            {{objects.camelCase()}}ForStage00.map(
              (element) => element.id,
            ),
          )
              .add(
            database,
            [
              for (final {{object.camelCase()}} in {{objects.camelCase()}}ForStage00)
                {{object.camelCase()}}.toSembastJson(),
            ],
          );

          // Stage 01
          await store.record(new{{object.pascalCase()}}InStage01.id).add(
                database,
                new{{object.pascalCase()}}InStage01.toSembastJson(),
              );

          // Stage 02
          await store.delete(
            database,
            finder: Finder(
              filter: Filter.matches(
                Sembast{{object.pascalCase()}}.nameJsonKey,
                '01',
              ),
            ),
          );

          // Stage 03
          await store.update(
            database,
            {Sembast{{object.pascalCase()}}.descriptionJsonKey: 'updated description'},
            finder: Finder(
              filter: Filter.isNull(Sembast{{object.pascalCase()}}.descriptionJsonKey),
            ),
          );
        },
      );
    },
  );
}
