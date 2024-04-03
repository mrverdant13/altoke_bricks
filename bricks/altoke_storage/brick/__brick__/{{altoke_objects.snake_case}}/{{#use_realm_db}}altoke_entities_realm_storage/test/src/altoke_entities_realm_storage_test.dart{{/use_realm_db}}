import 'dart:async';

import 'package:altoke_common/common.dart';
import 'package:altoke_entities_realm_storage/altoke_entities_realm_storage.dart';
import 'package:altoke_entities_storage/altoke_entities_storage.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:collection/collection.dart';
import 'package:realm/realm.dart';
import 'package:test/test.dart';

Future<Realm> openRealm() async {
  final realm = Realm(
    Configuration.inMemory(
      [RealmAltokeEntitySchema],
    ),
  );
  return realm;
}

void main() {
  test(
    '''

GIVEN a constructor for an altoke entities storage
├─ THAT uses a Realm database
WHEN the constructor is called
THEN an instance of the storage is returned
''',
    () async {
      final realm = await openRealm();
      final storage = AltokeEntitiesRealmStorage(database: realm);
      expect(storage, isNotNull);
      expect(storage, isA<AltokeEntitiesStorage>());
      realm.close();
    },
  );

  group(
    '''

GIVEN an altoke entities storage
├─ THAT uses a Realm database''',
    () {
      late Realm database;
      late AltokeEntitiesRealmStorage storage;

      setUp(() async {
        database = await openRealm();
        storage = AltokeEntitiesRealmStorage(database: database);
      });

      tearDown(() async {
        database.close();
      });

      test(
        '''

│  ├─ THAT does not have altoke entity records
AND the valid data for a new altoke entity
WHEN the altoke entity is created
THEN a altoke entity record is registered
''',
        () async {
          const newAltokeEntity = NewAltokeEntity(
            name: 'name',
            description: 'description',
          );
          final existingAltokeEntitiesCount =
              database.all<RealmAltokeEntity>().length;
          expect(existingAltokeEntitiesCount, isZero);
          await storage.create(newAltokeEntity: newAltokeEntity);
          final query = ' '
              'name == ${newAltokeEntity.name} '
              'AND '
              'description == ${newAltokeEntity.description}';
          final resultingMatchingAltokeEntitiesCount =
              database.query<RealmAltokeEntity>(query).length;
          expect(
            resultingMatchingAltokeEntitiesCount,
            existingAltokeEntitiesCount + 1,
          );
        },
      );

      test(
        '''

│  ├─ THAT has altoke entity records
AND the valid data for a new altoke entity
WHEN the altoke entity is created
THEN a altoke entity record is registered
''',
        () async {
          const existingAltokeEntityId = 13;
          const existingAltokeEntity = NewAltokeEntity(
            name: 'existing',
            description: 'description',
          );
          await database.write(
            () async => database.add<RealmAltokeEntity>(
              existingAltokeEntity.toRealmWithId(
                existingAltokeEntityId,
              ),
            ),
          );
          final initialAltokeEntitiesCount =
              database.all<RealmAltokeEntity>().length;
          expect(initialAltokeEntitiesCount, 1);
          const newAltokeEntity = NewAltokeEntity(
            name: 'new',
            description: 'description',
          );
          await storage.create(newAltokeEntity: newAltokeEntity);
          final query = ' '
              'name == "${newAltokeEntity.name}" '
              'AND '
              'description == "${newAltokeEntity.description}"';
          final resultingMatchingAltokeEntitiesCount =
              database.query<RealmAltokeEntity>(query).length;
          expect(resultingMatchingAltokeEntitiesCount, 1);
        },
      );

      test(
        '''

AND the invalid data for a new altoke entity
WHEN the altoke entity is created
THEN an exception is thrown
AND no altoke entity record is registered
''',
        () async {
          const newAltokeEntity = NewAltokeEntity(
            name: '',
            description: 'description',
          );
          final existingAltokeEntitiesCount =
              database.all<RealmAltokeEntity>().length;
          expect(existingAltokeEntitiesCount, isZero);
          expect(
            () async => storage.create(newAltokeEntity: newAltokeEntity),
            throwsA(isA<CreateAltokeEntityFailureEmptyName>()),
          );
          final resultingAltokeEntitiesCount =
              database.all<RealmAltokeEntity>().length;
          expect(resultingAltokeEntitiesCount, isZero);
        },
      );

      test(
        '''

│  ├─ THAT has altoke entity records
AND the ID of a registered altoke entity
WHEN the altoke entity is deleted
THEN the altoke entity record is dropped
AND the deleted altoke entity is returned
''',
        () async {
          const altokeEntityId = 1;
          const newAltokeEntity = NewAltokeEntity(
            name: 'name',
            description: 'description',
          );
          await database.write(
            () async => database.add<RealmAltokeEntity>(
              newAltokeEntity.toRealmWithId(
                altokeEntityId,
              ),
            ),
          );
          const query = 'id == $altokeEntityId';
          final initialMatchingAltokeEntitiesCount =
              database.query<RealmAltokeEntity>(query).length;
          expect(initialMatchingAltokeEntitiesCount, 1);
          final deletedAltokeEntity = await storage.deleteById(altokeEntityId);
          expect(deletedAltokeEntity, isNotNull);
          expect(deletedAltokeEntity!.id, altokeEntityId);
          final resultingMatchingAltokeEntitiesCount =
              database.query<RealmAltokeEntity>(query).length;
          expect(resultingMatchingAltokeEntitiesCount, isZero);
        },
      );

      test(
        '''

│  ├─ THAT has altoke entity records
AND the ID of an unregistered altoke entity
WHEN the altoke entity is deleted
THEN no altoke entity record is dropped
AND null is returned
''',
        () async {
          const altokeEntityId = 13;
          const newAltokeEntity =
              NewAltokeEntity(name: 'name', description: 'description');
          await database.write(
            () async => database.add<RealmAltokeEntity>(
              newAltokeEntity.toRealmWithId(altokeEntityId + 1),
            ),
          );
          final initialAltokeEntities = database.all<RealmAltokeEntity>();
          expect(initialAltokeEntities, hasLength(1));
          final initialAltokeEntity = initialAltokeEntities.single;
          expect(initialAltokeEntity.id, isNot(altokeEntityId));
          final deletedAltokeEntity = await storage.deleteById(altokeEntityId);
          expect(deletedAltokeEntity, isNull);
          final resultingAltokeEntities = database.all<RealmAltokeEntity>();
          expect(resultingAltokeEntities, hasLength(1));
          final resultingAltokeEntity = resultingAltokeEntities.single;
          expect(
            resultingAltokeEntity.toAltokeEntity(),
            initialAltokeEntity.toAltokeEntity(),
          );
        },
      );

      test(
        '''

│  ├─ THAT has several altoke entity records
AND a reference altoke entity
├─ THAT includes a non-null name matcher
├─ AND includes a non-null description matcher
WHEN a delete operation is performed with the reference altoke entity
THEN the altoke entity records matching the reference altoke entity are dropped
AND the altoke entity records not matching the reference altoke entity are kept
''',
        () async {
          final altokeEntities = [
            const AltokeEntity(
              id: 0,
              name: 'name 0',
              description: 'description 0',
            ),
            const AltokeEntity(
              id: 1,
              name: 'name 1 matching-pattern',
              description: 'description 1',
            ),
            const AltokeEntity(
              id: 2,
              name: 'name 2',
              description: 'description 2 matching-pattern',
            ),
            const AltokeEntity(
              id: 3,
              name: 'name 3 matching-pattern',
              description: 'description 3 matching-pattern',
            ),
            const AltokeEntity(
              id: 4,
              name: 'name 4',
              description: 'description 4',
            ),
            const AltokeEntity(
              id: 5,
              name: 'name 5 matching-pattern',
              description: 'description 5',
            ),
            const AltokeEntity(
              id: 6,
              name: 'name 6',
              description: 'description 6 matching-pattern',
            ),
            const AltokeEntity(
              id: 7,
              name: 'name 7 matching-pattern',
              description: 'description 7 matching-pattern',
            ),
            const AltokeEntity(
              id: 8,
              name: 'name 8',
              description: 'description 8',
            ),
            const AltokeEntity(
              id: 9,
              name: 'name 9 matching-pattern',
              description: 'description 9',
            ),
            const AltokeEntity(
              id: 10,
              name: 'name 10',
              description: 'description 10 matching-pattern',
            ),
            const AltokeEntity(
              id: 11,
              name: 'name 11 matching-pattern',
              description: 'description 11 matching-pattern',
            ),
            const AltokeEntity(
              id: 12,
              name: 'name 12',
              description: 'description 12',
            ),
            const AltokeEntity(
              id: 13,
              name: 'name 13 matching-pattern',
              description: 'description 13',
            ),
            const AltokeEntity(
              id: 14,
              name: 'name 14',
              description: 'description 14 matching-pattern',
            ),
            const AltokeEntity(
              id: 15,
              name: 'name 15 matching-pattern',
              description: 'description 15 matching-pattern',
            ),
          ];
          await database.write(
            () async => database.addAll([
              for (final altokeEntity in altokeEntities) altokeEntity.toRealm(),
            ]),
          );
          final initialAltokeEntitiesCount =
              database.all<RealmAltokeEntity>().length;
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          const referenceAltokeEntity = PartialAltokeEntity(
            name: Some('matching-pattern'),
            description: Some('matching-pattern'),
          );
          await storage.deleteAll(referenceAltokeEntity: referenceAltokeEntity);
          final resultingRealmAltokeEntities =
              database.all<RealmAltokeEntity>();

          bool shouldBeKept(AltokeEntity altokeEntity) {
            final AltokeEntity(:name, :description) = altokeEntity;
            final noMatchInTitle = !name.contains('matching-pattern');
            if (noMatchInTitle) return true;
            if (description == null) return true;
            final noMatchInDescription =
                !description.contains('matching-pattern');
            return noMatchInDescription;
          }

          final expectedResultingAltokeEntities = [
            for (final altokeEntity in altokeEntities)
              if (shouldBeKept(altokeEntity)) altokeEntity,
          ];
          expect(
            resultingRealmAltokeEntities,
            hasLength(expectedResultingAltokeEntities.length),
          );
          final resultingAltokeEntities = [
            for (final realmAltokeEntity in resultingRealmAltokeEntities)
              realmAltokeEntity.toAltokeEntity(),
          ];
          expect(
            resultingAltokeEntities,
            unorderedEquals(expectedResultingAltokeEntities),
          );
        },
      );

      test(
        '''

│  ├─ THAT has several altoke entity records
AND a reference altoke entity
├─ THAT does not include a name matcher
├─ AND includes a non-null description matcher
WHEN a delete operation is performed with the reference altoke entity
THEN the altoke entity records matching the reference altoke entity are dropped
AND the altoke entity records not matching the reference altoke entity are kept
''',
        () async {
          final altokeEntities = [
            const AltokeEntity(
              id: 0,
              name: 'name 0',
              description: 'description 0',
            ),
            const AltokeEntity(
              id: 1,
              name: 'name 1 matching-pattern',
              description: 'description 1',
            ),
            const AltokeEntity(
              id: 2,
              name: 'name 2',
              description: 'description 2 matching-pattern',
            ),
            const AltokeEntity(
              id: 3,
              name: 'name 3 matching-pattern',
              description: 'description 3 matching-pattern',
            ),
            const AltokeEntity(
              id: 4,
              name: 'name 4',
              description: 'description 4',
            ),
            const AltokeEntity(
              id: 5,
              name: 'name 5 matching-pattern',
              description: 'description 5',
            ),
            const AltokeEntity(
              id: 6,
              name: 'name 6',
              description: 'description 6 matching-pattern',
            ),
            const AltokeEntity(
              id: 7,
              name: 'name 7 matching-pattern',
              description: 'description 7 matching-pattern',
            ),
            const AltokeEntity(
              id: 8,
              name: 'name 8',
              description: 'description 8',
            ),
            const AltokeEntity(
              id: 9,
              name: 'name 9 matching-pattern',
              description: 'description 9',
            ),
            const AltokeEntity(
              id: 10,
              name: 'name 10',
              description: 'description 10 matching-pattern',
            ),
            const AltokeEntity(
              id: 11,
              name: 'name 11 matching-pattern',
              description: 'description 11 matching-pattern',
            ),
            const AltokeEntity(
              id: 12,
              name: 'name 12',
              description: 'description 12',
            ),
            const AltokeEntity(
              id: 13,
              name: 'name 13 matching-pattern',
              description: 'description 13',
            ),
            const AltokeEntity(
              id: 14,
              name: 'name 14',
              description: 'description 14 matching-pattern',
            ),
            const AltokeEntity(
              id: 15,
              name: 'name 15 matching-pattern',
              description: 'description 15 matching-pattern',
            ),
          ];
          await database.write(
            () async => database.addAll([
              for (final altokeEntity in altokeEntities) altokeEntity.toRealm(),
            ]),
          );
          final initialAltokeEntitiesCount =
              database.all<RealmAltokeEntity>().length;
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          const referenceAltokeEntity = PartialAltokeEntity(
            description: Some('matching-pattern'),
          );
          await storage.deleteAll(referenceAltokeEntity: referenceAltokeEntity);
          final resultingRealmAltokeEntities =
              database.all<RealmAltokeEntity>();

          bool shouldBeKept(AltokeEntity altokeEntity) {
            final AltokeEntity(:description) = altokeEntity;
            if (description == null) return true;
            final noMatchInDescription =
                !description.contains('matching-pattern');
            return noMatchInDescription;
          }

          final expectedResultingAltokeEntities = [
            for (final altokeEntity in altokeEntities)
              if (shouldBeKept(altokeEntity)) altokeEntity,
          ];
          expect(
            resultingRealmAltokeEntities,
            hasLength(expectedResultingAltokeEntities.length),
          );
          final resultingAltokeEntities = [
            for (final realmAltokeEntity in resultingRealmAltokeEntities)
              realmAltokeEntity.toAltokeEntity(),
          ];
          expect(
            resultingAltokeEntities,
            unorderedEquals(expectedResultingAltokeEntities),
          );
        },
      );

      test(
        '''

│  ├─ THAT has several altoke entity records
AND a reference altoke entity
├─ THAT includes a non-null name matcher
├─ AND includes a null description matcher
WHEN a delete operation is performed with the reference altoke entity
THEN the altoke entity records matching the reference altoke entity are dropped
AND the altoke entity records not matching the reference altoke entity are kept
''',
        () async {
          final altokeEntities = [
            const AltokeEntity(
              id: 0,
              name: 'name 0',
              description: 'description 0',
            ),
            const AltokeEntity(
              id: 1,
              name: 'name 1 matching-pattern',
              description: 'description 1',
            ),
            const AltokeEntity(
              id: 2,
              name: 'name 2',
              description: 'description 2 matching-pattern',
            ),
            const AltokeEntity(
              id: 3,
              name: 'name 3 matching-pattern',
              description: 'description 3 matching-pattern',
            ),
            const AltokeEntity(
              id: 4,
              name: 'name 4',
              description: 'description 4',
            ),
            const AltokeEntity(
              id: 5,
              name: 'name 5 matching-pattern',
              description: 'description 5',
            ),
            const AltokeEntity(
              id: 6,
              name: 'name 6',
              description: 'description 6 matching-pattern',
            ),
            const AltokeEntity(
              id: 7,
              name: 'name 7 matching-pattern',
              description: 'description 7 matching-pattern',
            ),
            const AltokeEntity(
              id: 8,
              name: 'name 8',
              description: 'description 8',
            ),
            const AltokeEntity(
              id: 9,
              name: 'name 9 matching-pattern',
              description: 'description 9',
            ),
            const AltokeEntity(
              id: 10,
              name: 'name 10',
              description: 'description 10 matching-pattern',
            ),
            const AltokeEntity(
              id: 11,
              name: 'name 11 matching-pattern',
              description: 'description 11 matching-pattern',
            ),
            const AltokeEntity(
              id: 12,
              name: 'name 12',
              description: 'description 12',
            ),
            const AltokeEntity(
              id: 13,
              name: 'name 13 matching-pattern',
              description: 'description 13',
            ),
            const AltokeEntity(
              id: 14,
              name: 'name 14',
              description: 'description 14 matching-pattern',
            ),
            const AltokeEntity(
              id: 15,
              name: 'name 15 matching-pattern',
              description: 'description 15 matching-pattern',
            ),
          ];
          await database.write(
            () async => database.addAll([
              for (final altokeEntity in altokeEntities) altokeEntity.toRealm(),
            ]),
          );
          final initialAltokeEntitiesCount =
              database.all<RealmAltokeEntity>().length;
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          const referenceAltokeEntity = PartialAltokeEntity(
            name: Some('matching-pattern'),
            description: Some(null),
          );
          await storage.deleteAll(referenceAltokeEntity: referenceAltokeEntity);
          final resultingRealmAltokeEntities =
              database.all<RealmAltokeEntity>();

          bool shouldBeKept(AltokeEntity altokeEntity) {
            final AltokeEntity(:name, :description) = altokeEntity;
            final noMatchInTitle = !name.contains('matching-pattern');
            if (noMatchInTitle) return true;
            return description != null;
          }

          final expectedResultingAltokeEntities = [
            for (final altokeEntity in altokeEntities)
              if (shouldBeKept(altokeEntity)) altokeEntity,
          ];
          expect(
            resultingRealmAltokeEntities,
            hasLength(expectedResultingAltokeEntities.length),
          );
          final resultingAltokeEntities = [
            for (final realmAltokeEntity in resultingRealmAltokeEntities)
              realmAltokeEntity.toAltokeEntity(),
          ];
          expect(
            resultingAltokeEntities,
            unorderedEquals(expectedResultingAltokeEntities),
          );
        },
      );

      test(
        '''

│  ├─ THAT has several altoke entity records
AND a reference altoke entity
├─ THAT includes a non-null name matcher
├─ AND includes a non-null empty description matcher
WHEN a delete operation is performed with the reference altoke entity
THEN the altoke entity records matching the reference altoke entity are dropped
AND the altoke entity records not matching the reference altoke entity are kept
''',
        () async {
          final altokeEntities = [
            const AltokeEntity(
              id: 0,
              name: 'name 0',
              description: 'description 0',
            ),
            const AltokeEntity(
              id: 1,
              name: 'name 1 matching-pattern',
              description: 'description 1',
            ),
            const AltokeEntity(
              id: 2,
              name: 'name 2',
              description: 'description 2 matching-pattern',
            ),
            const AltokeEntity(
              id: 3,
              name: 'name 3 matching-pattern',
              description: 'description 3 matching-pattern',
            ),
            const AltokeEntity(
              id: 4,
              name: 'name 4',
              description: 'description 4',
            ),
            const AltokeEntity(
              id: 5,
              name: 'name 5 matching-pattern',
              description: 'description 5',
            ),
            const AltokeEntity(
              id: 6,
              name: 'name 6',
              description: 'description 6 matching-pattern',
            ),
            const AltokeEntity(
              id: 7,
              name: 'name 7 matching-pattern',
              description: 'description 7 matching-pattern',
            ),
            const AltokeEntity(
              id: 8,
              name: 'name 8',
              description: 'description 8',
            ),
            const AltokeEntity(
              id: 9,
              name: 'name 9 matching-pattern',
              description: 'description 9',
            ),
            const AltokeEntity(
              id: 10,
              name: 'name 10',
              description: 'description 10 matching-pattern',
            ),
            const AltokeEntity(
              id: 11,
              name: 'name 11 matching-pattern',
              description: 'description 11 matching-pattern',
            ),
            const AltokeEntity(
              id: 12,
              name: 'name 12',
              description: 'description 12',
            ),
            const AltokeEntity(
              id: 13,
              name: 'name 13 matching-pattern',
              description: 'description 13',
            ),
            const AltokeEntity(
              id: 14,
              name: 'name 14',
              description: 'description 14 matching-pattern',
            ),
            const AltokeEntity(
              id: 15,
              name: 'name 15 matching-pattern',
              description: 'description 15 matching-pattern',
            ),
          ];
          await database.write(
            () async => database.addAll([
              for (final altokeEntity in altokeEntities) altokeEntity.toRealm(),
            ]),
          );
          final initialAltokeEntitiesCount =
              database.all<RealmAltokeEntity>().length;
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          const referenceAltokeEntity = PartialAltokeEntity(
            name: Some('matching-pattern'),
            description: Some(''),
          );
          await storage.deleteAll(referenceAltokeEntity: referenceAltokeEntity);
          final resultingRealmAltokeEntities =
              database.all<RealmAltokeEntity>();

          bool shouldBeKept(AltokeEntity altokeEntity) {
            final AltokeEntity(:name) = altokeEntity;
            final noMatchInTitle = !name.contains('matching-pattern');
            return noMatchInTitle;
          }

          final expectedResultingAltokeEntities = [
            for (final altokeEntity in altokeEntities)
              if (shouldBeKept(altokeEntity)) altokeEntity,
          ];
          expect(
            resultingRealmAltokeEntities,
            hasLength(expectedResultingAltokeEntities.length),
          );
          final resultingAltokeEntities = [
            for (final realmAltokeEntity in resultingRealmAltokeEntities)
              realmAltokeEntity.toAltokeEntity(),
          ];
          expect(
            resultingAltokeEntities,
            unorderedEquals(expectedResultingAltokeEntities),
          );
        },
      );

      test(
        '''

│  ├─ THAT has several altoke entity records
AND a reference altoke entity
├─ AND includes non-null name matcher
├─ AND includes empty description matcher
WHEN a delete operation is performed with the reference altoke entity
THEN the altoke entity records matching the reference altoke entity are dropped
AND the altoke entity records not matching the reference altoke entity are kept
''',
        () async {
          final altokeEntities = [
            const AltokeEntity(
              id: 0,
              name: 'name 0',
              description: 'description 0',
            ),
            const AltokeEntity(
              id: 1,
              name: 'name 1 matching-pattern',
              description: 'description 1',
            ),
            const AltokeEntity(
              id: 2,
              name: 'name 2',
              // ignore: avoid_redundant_argument_values
              description: null,
            ),
            const AltokeEntity(
              id: 3,
              name: 'name 3 matching-pattern',
              // ignore: avoid_redundant_argument_values
              description: null,
            ),
            const AltokeEntity(
              id: 4,
              name: 'name 4',
              description: 'description 4',
            ),
            const AltokeEntity(
              id: 5,
              name: 'name 5 matching-pattern',
              description: 'description 5',
            ),
            const AltokeEntity(
              id: 6,
              name: 'name 6',
              // ignore: avoid_redundant_argument_values
              description: null,
            ),
            const AltokeEntity(
              id: 7,
              name: 'name 7 matching-pattern',
              // ignore: avoid_redundant_argument_values
              description: null,
            ),
            const AltokeEntity(
              id: 8,
              name: 'name 8',
              description: 'description 8',
            ),
            const AltokeEntity(
              id: 9,
              name: 'name 9 matching-pattern',
              description: 'description 9',
            ),
            const AltokeEntity(
              id: 10,
              name: 'name 10',
              // ignore: avoid_redundant_argument_values
              description: null,
            ),
            const AltokeEntity(
              id: 11,
              name: 'name 11 matching-pattern',
              // ignore: avoid_redundant_argument_values
              description: null,
            ),
            const AltokeEntity(
              id: 12,
              name: 'name 12',
              description: 'description 12',
            ),
            const AltokeEntity(
              id: 13,
              name: 'name 13 matching-pattern',
              description: 'description 13',
            ),
            const AltokeEntity(
              id: 14,
              name: 'name 14',
              // ignore: avoid_redundant_argument_values
              description: null,
            ),
            const AltokeEntity(
              id: 15,
              name: 'name 15 matching-pattern',
              // ignore: avoid_redundant_argument_values
              description: null,
            ),
          ];
          await database.write(
            () async => database.addAll([
              for (final altokeEntity in altokeEntities) altokeEntity.toRealm(),
            ]),
          );
          final initialAltokeEntitiesCount =
              database.all<RealmAltokeEntity>().length;
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          const referenceAltokeEntity = PartialAltokeEntity(
            name: Some('matching-pattern'),
            description: Some(null),
          );
          await storage.deleteAll(referenceAltokeEntity: referenceAltokeEntity);
          final resultingRealmAltokeEntities =
              database.all<RealmAltokeEntity>();

          bool shouldBeKept(AltokeEntity altokeEntity) {
            final AltokeEntity(:name, :description) = altokeEntity;
            final noMatchInTitle = !name.contains('matching-pattern');
            if (noMatchInTitle) return true;
            final noMatchInDescription =
                description != null && description.isNotEmpty;
            return noMatchInDescription;
          }

          final expectedResultingAltokeEntities = [
            for (final altokeEntity in altokeEntities)
              if (shouldBeKept(altokeEntity)) altokeEntity,
          ];
          expect(
            resultingRealmAltokeEntities,
            hasLength(expectedResultingAltokeEntities.length),
          );
          final resultingAltokeEntities = [
            for (final realmAltokeEntity in resultingRealmAltokeEntities)
              realmAltokeEntity.toAltokeEntity(),
          ];
          expect(
            resultingAltokeEntities,
            unorderedEquals(expectedResultingAltokeEntities),
          );
        },
      );

      test(
        '''

│  ├─ THAT has several altoke entity records
WHEN a delete operation is performed with no reference altoke entity
THEN all altoke entity records are dropped
''',
        () async {
          final altokeEntities = List.generate(
            30,
            (index) => AltokeEntity(
              id: index,
              name: 'name $index',
              description: 'description $index',
            ),
          );
          await database.write(
            () async => database.addAll([
              for (final altokeEntity in altokeEntities) altokeEntity.toRealm(),
            ]),
          );
          final initialAltokeEntitiesCount =
              database.all<RealmAltokeEntity>().length;
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          await storage.deleteAll();
          final resultingRealmAltokeEntitiesCount =
              database.all<RealmAltokeEntity>().length;
          expect(resultingRealmAltokeEntitiesCount, isZero);
        },
      );

      test(
        '''

AND a altoke entity
WHEN the altoke entity is inserted
THEN a altoke entity record is registered
''',
        () async {
          const altokeEntity = AltokeEntity(
            id: 1,
            name: 'name',
            description: 'description',
          );
          final existingAltokeEntitiesCount =
              database.all<RealmAltokeEntity>().length;
          expect(existingAltokeEntitiesCount, isZero);
          await storage.insert(altokeEntity: altokeEntity);
          final resultingRealmAltokeEntities =
              database.all<RealmAltokeEntity>();
          expect(resultingRealmAltokeEntities, hasLength(1));
          final resultingRealmAltokeEntity =
              resultingRealmAltokeEntities.single;
          expect(resultingRealmAltokeEntity.toAltokeEntity(), altokeEntity);
        },
      );

      test(
        '''

AND the ID of a registered altoke entity
AND the valid partial altoke entity data
WHEN the altoke entity is updated
THEN a altoke entity record is updated
''',
        () async {
          const altokeEntity = AltokeEntity(
            id: 13,
            name: 'name',
            description: 'description',
          );
          await database.write(
            () async => database.add(
              altokeEntity.toRealm(),
            ),
          );
          final existingAltokeEntitiesCount =
              database.all<RealmAltokeEntity>().length;
          expect(existingAltokeEntitiesCount, 1);
          const newName = 'new name';
          const newDescription = 'new description';
          final query = ' '
              'id == ${altokeEntity.id} '
              'AND '
              'name == "$newName" '
              'AND '
              'description == "$newDescription"';
          final existingMatchingAltokeEntitiesCount =
              database.query<RealmAltokeEntity>(query).length;
          expect(existingMatchingAltokeEntitiesCount, isZero);
          await storage.update(
            altokeEntityId: altokeEntity.id,
            partialAltokeEntity: const PartialAltokeEntity(
              name: Some(newName),
              description: Some(newDescription),
            ),
          );
          final resultingMatchingAltokeEntitiesCount =
              database.query<RealmAltokeEntity>(query).length;
          expect(
            resultingMatchingAltokeEntitiesCount,
            existingMatchingAltokeEntitiesCount + 1,
          );
        },
      );

      test(
        '''

AND the invalid data for a new altoke entity
WHEN the altoke entity is created
THEN an exception is thrown
AND no altoke entity record is registered
''',
        () async {
          const newAltokeEntity = NewAltokeEntity(
            name: '',
            description: 'description',
          );
          final existingAltokeEntitiesCount =
              database.all<RealmAltokeEntity>().length;
          expect(existingAltokeEntitiesCount, isZero);
          expect(
            () async => storage.create(newAltokeEntity: newAltokeEntity),
            throwsA(isA<CreateAltokeEntityFailureEmptyName>()),
          );
          final resultingAltokeEntitiesCount =
              database.all<RealmAltokeEntity>().length;
          expect(resultingAltokeEntitiesCount, isZero);
        },
      );

      test(
        '''

AND the ID of a registered altoke entity
AND the invalid partial altoke entity data
WHEN the altoke entity is updated
THEN an exception is thrown
AND no altoke entity record is updated
''',
        () async {
          const altokeEntity = AltokeEntity(
            id: 76,
            name: 'name',
            description: 'description',
          );
          await database.write(
            () async => database.add(
              altokeEntity.toRealm(),
            ),
          );
          final existingAltokeEntitiesCount =
              database.all<RealmAltokeEntity>().length;
          expect(existingAltokeEntitiesCount, 1);
          const newName = '';
          const newDescription = 'new description';
          final query = ' '
              'id == ${altokeEntity.id} '
              'AND '
              'name == "$newName" '
              'AND '
              'description == "$newDescription"';
          final existingMatchingAltokeEntitiesCount =
              database.query<RealmAltokeEntity>(query).length;
          expect(existingMatchingAltokeEntitiesCount, isZero);
          expect(
            () async => storage.update(
              altokeEntityId: altokeEntity.id,
              partialAltokeEntity: const PartialAltokeEntity(
                name: Some(newName),
                description: Some(newDescription),
              ),
            ),
            throwsA(isA<UpdateAltokeEntityFailureEmptyName>()),
          );
          final resultingMatchingAltokeEntitiesCount =
              database.query<RealmAltokeEntity>(query).length;
          expect(resultingMatchingAltokeEntitiesCount, isZero);
        },
      );

      test(
        '''

│  ├─ THAT has altoke entity records
AND the ID of a registered altoke entity
WHEN the altoke entity is requested
THEN the altoke entity is returned
''',
        () async {
          const altokeEntityId = 8;
          const altokeEntity = AltokeEntity(
            id: altokeEntityId,
            name: 'name',
            description: 'description',
          );
          await database.write(
            () async => database.add(altokeEntity.toRealm()),
          );
          final initialMatchingAltokeEntitiesCount =
              database.query<RealmAltokeEntity>('id == $altokeEntityId').length;
          expect(initialMatchingAltokeEntitiesCount, 1);
          final retrievedAltokeEntity = await storage.getById(altokeEntityId);
          expect(retrievedAltokeEntity, isNotNull);
          expect(retrievedAltokeEntity, altokeEntity);
        },
      );

      test(
        '''

│  ├─ THAT has altoke entity records
AND the ID of an unregistered altoke entity
WHEN the altoke entity is requested
THEN null is returned
''',
        () async {
          const altokeEntityId = 7;
          final initialMatchingAltokeEntitiesCount =
              database.query<RealmAltokeEntity>('id == $altokeEntityId').length;
          expect(initialMatchingAltokeEntitiesCount, isZero);
          final retrievedAltokeEntity = await storage.getById(altokeEntityId);
          expect(retrievedAltokeEntity, isNull);
        },
      );

      test(
        '''

│  ├─ THAT has altoke entity records
WHEN the altoke entities are watched
├─ AND are not filtered by their content
THEN the altoke entities that match the conditions are continuously emitted as they change
''',
        () async {
          final stream = storage.watch();

          // Stage 00
          final altokeEntitiesForStage00 = <AltokeEntity>[
            const AltokeEntity(
              id: 0,
              name: 'name 00',
              description: 'description 00',
            ),
            const AltokeEntity(
              id: 1,
              name: 'name 01',
            ),
            const AltokeEntity(
              id: 2,
              name: 'name 02',
            ),
          ];
          final sortedAltokeEntitiesForStage00 = [...altokeEntitiesForStage00]
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          // Stage 01
          const newAltokeEntityInStage01 = AltokeEntity(
            id: 3,
            name: 'name 03',
          );
          final altokeEntitiesForStage01 = <AltokeEntity>[
            ...altokeEntitiesForStage00,
            newAltokeEntityInStage01,
          ];
          final sortedAltokeEntitiesForStage01 = [...altokeEntitiesForStage01]
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          // Stage 02
          final altokeEntitiesForStage02 = <AltokeEntity>[
            for (final altokeEntity in altokeEntitiesForStage01)
              if (!altokeEntity.name.contains('01')) altokeEntity,
          ];
          final sortedAltokeEntitiesForStage02 = [...altokeEntitiesForStage02]
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          // Stage 03
          final altokeEntitiesForStage03 = <AltokeEntity>[
            for (final altokeEntity in altokeEntitiesForStage02)
              if (altokeEntity.description == null)
                AltokeEntity(
                  id: altokeEntity.id,
                  name: altokeEntity.name,
                  description: 'updated description',
                )
              else
                altokeEntity,
          ];
          final sortedAltokeEntitiesForStage03 = [...altokeEntitiesForStage03]
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          unawaited(
            expectLater(
              stream,
              emitsInOrder(
                [
                  orderedEquals(sortedAltokeEntitiesForStage00),
                  orderedEquals(sortedAltokeEntitiesForStage01),
                  orderedEquals(sortedAltokeEntitiesForStage02),
                  orderedEquals(sortedAltokeEntitiesForStage03),
                ],
              ),
            ),
          );

          // Stage 00
          await database.write(
            () async => database.addAll<RealmAltokeEntity>([
              for (final altokeEntity in altokeEntitiesForStage00)
                altokeEntity.toRealm(),
            ]),
          );

          // Stage 01
          await database.write(
            () async => database
                .add<RealmAltokeEntity>(newAltokeEntityInStage01.toRealm()),
          );

          // Stage 02
          await database.write(
            () async {
              final matchingAltokeEntities =
                  database.query<RealmAltokeEntity>('name CONTAINS "01"');
              database.deleteMany<RealmAltokeEntity>(matchingAltokeEntities);
            },
          );

          // Stage 03
          await database.write(
            () async {
              final altokeEntitiesWithNullDescription =
                  database.query<RealmAltokeEntity>('description == null');
              for (final altokeEntity in altokeEntitiesWithNullDescription) {
                altokeEntity.description = 'updated description';
              }
            },
          );
        },
      );

      test(
        '''

│  ├─ THAT has altoke entity records
WHEN the altoke entities are watched
├─ AND are filtered by their content
THEN the altoke entities that match the conditions are continuously emitted as they change
''',
        () async {
          final stream = storage.watch(searchTerm: 'matching-pattern');

          bool matches(AltokeEntity altokeEntity) =>
              altokeEntity.name.contains('matching-pattern') ||
              (altokeEntity.description?.contains('matching-pattern') ?? false);

          // Stage 00
          final altokeEntitiesForStage00 = <AltokeEntity>[
            const AltokeEntity(
              id: 0,
              name: 'name 00',
              description: 'description 00 matching-pattern',
            ),
            const AltokeEntity(
              id: 1,
              name: 'name 01',
            ),
            const AltokeEntity(
              id: 2,
              name: 'name 02',
            ),
            const AltokeEntity(
              id: 3,
              name: 'name 03',
              description: 'description 03 matching-pattern',
            ),
            const AltokeEntity(
              id: 4,
              name: 'name 04',
            ),
            const AltokeEntity(
              id: 5,
              name: 'name 05',
              description: 'description 05 matching-pattern',
            ),
          ];
          final sortedAltokeEntitiesForStage00 = [...altokeEntitiesForStage00]
              .where(matches)
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          // Stage 01
          const newAltokeEntityInStage01 = AltokeEntity(
            id: 6,
            name: 'name 06 matching-pattern',
          );
          final altokeEntitiesForStage01 = <AltokeEntity>[
            ...altokeEntitiesForStage00,
            newAltokeEntityInStage01,
          ];
          final sortedAltokeEntitiesForStage01 = [...altokeEntitiesForStage01]
              .where(matches)
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          // Stage 02
          final altokeEntitiesForStage02 = <AltokeEntity>[
            for (final altokeEntity in altokeEntitiesForStage01)
              if (!altokeEntity.name.contains('00')) altokeEntity,
          ];
          final sortedAltokeEntitiesForStage02 = [...altokeEntitiesForStage02]
              .where(matches)
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          // Stage 03
          final altokeEntitiesForStage03 = <AltokeEntity>[
            for (final altokeEntity in altokeEntitiesForStage02)
              if (altokeEntity.description == null)
                AltokeEntity(
                  id: altokeEntity.id,
                  name: altokeEntity.name,
                  description: 'updated description matching-pattern',
                )
              else
                altokeEntity,
          ];
          final sortedAltokeEntitiesForStage03 = [...altokeEntitiesForStage03]
              .where(matches)
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          unawaited(
            expectLater(
              stream,
              emitsInOrder(
                [
                  orderedEquals(sortedAltokeEntitiesForStage00),
                  orderedEquals(sortedAltokeEntitiesForStage01),
                  orderedEquals(sortedAltokeEntitiesForStage02),
                  orderedEquals(sortedAltokeEntitiesForStage03),
                ],
              ),
            ),
          );

          // Stage 00
          await database.write(
            () async => database.addAll<RealmAltokeEntity>([
              for (final altokeEntity in altokeEntitiesForStage00)
                altokeEntity.toRealm(),
            ]),
          );

          // Stage 01
          await database.write(
            () async => database
                .add<RealmAltokeEntity>(newAltokeEntityInStage01.toRealm()),
          );

          // Stage 02
          await database.write(
            () async {
              final altokeEntityToDelete =
                  database.query<RealmAltokeEntity>('name CONTAINS "00"');
              database.deleteMany<RealmAltokeEntity>(altokeEntityToDelete);
            },
          );

          // Stage 03
          await database.write(
            () async {
              final altokeEntitiesWithNullDescription =
                  database.query<RealmAltokeEntity>('description == null');
              for (final altokeEntity in altokeEntitiesWithNullDescription) {
                altokeEntity.description =
                    'updated description matching-pattern';
              }
            },
          );
        },
      );

      test(
        '''

│  ├─ THAT has altoke entity records
WHEN the altoke entities count is watched
├─ AND are not filtered by their content
THEN the quantity of persisted altoke entities that match the conditions is continuously emitted as it changes
''',
        () async {
          final stream = storage.watchCount();

          // Stage 00
          final altokeEntitiesForStage00 = <AltokeEntity>[
            const AltokeEntity(
              id: 0,
              name: 'name 00',
              description: 'description 00',
            ),
            const AltokeEntity(
              id: 1,
              name: 'name 01',
            ),
            const AltokeEntity(
              id: 2,
              name: 'name 02',
              description: 'description 02',
            ),
          ];

          // Stage 01
          const newAltokeEntityInStage01 = AltokeEntity(
            id: 3,
            name: 'name 03',
          );
          final altokeEntitiesForStage01 = <AltokeEntity>[
            ...altokeEntitiesForStage00,
            newAltokeEntityInStage01,
          ];

          // Stage 02
          final altokeEntitiesForStage02 = <AltokeEntity>[
            for (final altokeEntity in altokeEntitiesForStage01)
              if (!altokeEntity.name.contains('01')) altokeEntity,
          ];

          // Stage 03
          // final altokeEntitiesForStage03 = <AltokeEntity>[
          //   for (final altokeEntity in altokeEntitiesForStage02)
          //     if (altokeEntity.description == null)
          //       AltokeEntity(
          //         id: altokeEntity.id,
          //         name: altokeEntity.name,
          //         description: 'updated description',
          //       )
          //     else
          //       altokeEntity,
          // ];

          unawaited(
            expectLater(
              stream,
              emitsInOrder([
                altokeEntitiesForStage00.length,
                altokeEntitiesForStage01.length,
                altokeEntitiesForStage02.length,

                // Not emitted as the altoke entities count has not changed
                // altokeEntitiesForStage03.length,
              ]),
            ),
          );

          // Stage 00
          await database.write(
            () async => database.addAll([
              for (final altokeEntity in altokeEntitiesForStage00)
                altokeEntity.toRealm(),
            ]),
          );

          // Stage 01
          await database.write(
            () async => database.add(
              newAltokeEntityInStage01.toRealm(),
            ),
          );

          // Stage 02
          await database.write(
            () async {
              final altokeEntitiesToDelete =
                  database.query<RealmAltokeEntity>('name CONTAINS "01"');
              database.deleteMany<RealmAltokeEntity>(altokeEntitiesToDelete);
            },
          );

          // Stage 03
          await database.write(
            () async {
              final altokeEntitiesWithNullDescription =
                  database.query<RealmAltokeEntity>('description == null');
              for (final altokeEntity in altokeEntitiesWithNullDescription) {
                altokeEntity.description = 'updated description';
              }
            },
          );
        },
      );

      test(
        '''

│  ├─ THAT has altoke entity records
WHEN the altoke entities count is watched
├─ AND are filtered by their content
THEN the quantity of persisted altoke entities that match the conditions is continuously emitted as it changes
''',
        () async {
          final stream = storage.watchCount(searchTerm: 'matching-pattern');
          bool match(AltokeEntity altokeEntity) =>
              altokeEntity.name.contains('matching-pattern') ||
              (altokeEntity.description?.contains('matching-pattern') ?? false);

          // Stage 00
          final altokeEntitiesForStage00 = <AltokeEntity>[
            const AltokeEntity(
              id: 0,
              name: 'name 00',
              description: 'description 00',
            ),
            const AltokeEntity(
              id: 1,
              name: 'name 01 matching-pattern',
            ),
            const AltokeEntity(
              id: 2,
              name: 'name 02',
              description: 'description 02 matching-pattern',
            ),
          ];
          final expectedAltokeEntitiesForStage00 =
              altokeEntitiesForStage00.where(match);

          // Stage 01
          const newAltokeEntityInStage01 = AltokeEntity(
            id: 3,
            name: 'name 03 matching-pattern',
          );
          final altokeEntitiesForStage01 = <AltokeEntity>[
            ...altokeEntitiesForStage00,
            newAltokeEntityInStage01,
          ];
          final expectedAltokeEntitiesForStage01 =
              altokeEntitiesForStage01.where(match);

          // Stage 02
          final altokeEntitiesForStage02 = <AltokeEntity>[
            for (final altokeEntity in altokeEntitiesForStage01)
              if (!altokeEntity.name.contains('01')) altokeEntity,
          ];
          final expectedAltokeEntitiesForStage02 =
              altokeEntitiesForStage02.where(match);

          // Stage 03
          // final altokeEntitiesForStage03 = <AltokeEntity>[
          //   for (final altokeEntity in altokeEntitiesForStage02)
          //     if (altokeEntity.description == null)
          //       AltokeEntity(
          //         id: altokeEntity.id,
          //         name: altokeEntity.name,
          //         description: 'updated description',
          //       )
          //     else
          //       altokeEntity,
          // ];
          // final expectedAltokeEntitiesForStage03 =
          //     altokeEntitiesForStage03.where(match);

          unawaited(
            expectLater(
              stream,
              emitsInOrder(
                [
                  expectedAltokeEntitiesForStage00.length,
                  expectedAltokeEntitiesForStage01.length,
                  expectedAltokeEntitiesForStage02.length,

                  // Not emitted as the altoke entities count has not changed
                  // expectedAltokeEntitiesForStage03.length,
                ],
              ),
            ),
          );

          // Stage 00
          await database.write(
            () async => database.addAll([
              for (final altokeEntity in altokeEntitiesForStage00)
                altokeEntity.toRealm(),
            ]),
          );

          // Stage 01
          await database.write(
            () async => database.add(
              newAltokeEntityInStage01.toRealm(),
            ),
          );

          // Stage 02
          await database.write(
            () async {
              final altokeEntityToDelete =
                  database.query<RealmAltokeEntity>('name CONTAINS "01"');
              database.deleteMany<RealmAltokeEntity>(altokeEntityToDelete);
            },
          );

          // Stage 03
          await database.write(
            () async {
              final altokeEntitiesWithNullDescription =
                  database.query<RealmAltokeEntity>('description == null');
              for (final altokeEntity in altokeEntitiesWithNullDescription) {
                altokeEntity.description = 'updated description';
              }
            },
          );
        },
      );
    },
  );
}
