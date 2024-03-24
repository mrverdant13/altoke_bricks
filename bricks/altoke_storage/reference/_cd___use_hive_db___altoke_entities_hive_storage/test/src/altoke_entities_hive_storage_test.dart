import 'dart:async';
import 'dart:io';

import 'package:altoke_common/common.dart';
import 'package:altoke_entities_hive_storage/altoke_entities_hive_storage.dart';
import 'package:altoke_entities_storage/altoke_entities_storage.dart';
import 'package:altoke_entity/altoke_entity.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for a altoke entities storage
WHEN the constructor is called
THEN an instance of the storage is returned
''',
    () async {
      final databaseDir = Directory.systemTemp.createTempSync('hive-testing-');
      Hive.init(databaseDir.path);
      final storage = AltokeEntitiesHiveStorage();
      final box = await storage.asyncAltokeEntitiesBox;
      expect(storage, isNotNull);
      expect(storage, isA<AltokeEntitiesStorage>());
      await storage.dispose();
      expect(box.isOpen, isFalse);
      await Hive.close();
      await databaseDir.delete(recursive: true);
    },
  );

  group(
    '''

GIVEN a altoke entities storage''',
    () {
      late Directory databaseDir;
      late AltokeEntitiesHiveStorage storage;
      late Box<Map<dynamic, dynamic>> box;

      setUp(() async {
        databaseDir = Directory.systemTemp.createTempSync(
          'hive-testing-',
        );
        Hive.init(databaseDir.path);
        storage = AltokeEntitiesHiveStorage();
        box = await storage.asyncAltokeEntitiesBox;
      });

      tearDown(() async {
        await storage.dispose();
        await Hive.close();
        await databaseDir.delete(recursive: true);
      });

      test(
        '''

├─ THAT does not have altoke entity records
AND the valid data for a new altoke entity
WHEN the altoke entity is created
THEN a altoke entity record is registered
''',
        () async {
          const newAltokeEntity = NewAltokeEntity(
            name: 'name',
            description: 'description',
          );
          final existingAltokeEntitiesCount = box.length;
          expect(existingAltokeEntitiesCount, isZero);
          await storage.create(newAltokeEntity: newAltokeEntity);
          bool filter(Map<dynamic, dynamic> rawAltokeEntity) =>
              rawAltokeEntity[HiveAltokeEntity.nameJsonKey] ==
                  newAltokeEntity.name &&
              rawAltokeEntity[HiveAltokeEntity.descriptionJsonKey] ==
                  newAltokeEntity.description;
          final resultingMatchingAltokeEntitiesCount =
              box.values.where(filter).length;
          expect(
            resultingMatchingAltokeEntitiesCount,
            existingAltokeEntitiesCount + 1,
          );
        },
      );

      test(
        '''

├─ THAT has altoke entity records
AND the valid data for a new altoke entity
WHEN the altoke entity is created
THEN a altoke entity record is registered
''',
        () async {
          const existingAltokeEntity = NewAltokeEntity(
            name: 'existing',
            description: 'description',
          );
          await box.add(
            existingAltokeEntity.toHiveJson(),
          );
          final initialAltokeEntitiesCount = box.length;
          expect(initialAltokeEntitiesCount, 1);
          const newAltokeEntity = NewAltokeEntity(
            name: 'new',
            description: 'description',
          );
          await storage.create(newAltokeEntity: newAltokeEntity);
          bool filter(Map<dynamic, dynamic> rawAltokeEntity) =>
              rawAltokeEntity[HiveAltokeEntity.nameJsonKey] ==
                  newAltokeEntity.name &&
              rawAltokeEntity[HiveAltokeEntity.descriptionJsonKey] ==
                  newAltokeEntity.description;
          final resultingMatchingAltokeEntitiesCount =
              box.values.where(filter).length;
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
          final existingAltokeEntitiesCount = box.length;
          expect(existingAltokeEntitiesCount, isZero);
          expect(
            () async => storage.create(newAltokeEntity: newAltokeEntity),
            throwsA(isA<CreateAltokeEntityFailureEmptyName>()),
          );
          final resultingAltokeEntitiesCount = box.length;
          expect(resultingAltokeEntitiesCount, isZero);
        },
      );

      test(
        '''

├─ THAT has altoke entity records
AND the ID of a registered altoke entity
WHEN the altoke entity is deleted
THEN the altoke entity record is dropped
AND the deleted altoke entity is returned
''',
        () async {
          const altokeEntityId = 13;
          const newAltokeEntity =
              NewAltokeEntity(name: 'name', description: 'description');
          await box.put(altokeEntityId, newAltokeEntity.toHiveJson());
          bool filter(dynamic key) => key == altokeEntityId;
          final initialMatchingAltokeEntitiesCount =
              box.keys.where(filter).length;
          expect(initialMatchingAltokeEntitiesCount, 1);
          final deletedAltokeEntity = await storage.deleteById(altokeEntityId);
          expect(deletedAltokeEntity, isNotNull);
          expect(deletedAltokeEntity?.id, altokeEntityId);
          final resultingMatchingAltokeEntitiesCount =
              box.keys.where(filter).length;
          expect(resultingMatchingAltokeEntitiesCount, isZero);
        },
      );

      test(
        '''

├─ THAT has altoke entity records
AND the ID of an unregistered altoke entity
WHEN the altoke entity is deleted
THEN no altoke entity record is dropped
AND null is returned
''',
        () async {
          const altokeEntityId = 17;
          const newAltokeEntity =
              NewAltokeEntity(name: 'name', description: 'description');
          await box.add(newAltokeEntity.toHiveJson());
          final initialAltokeEntityEntries = box.toMap().entries;
          expect(initialAltokeEntityEntries, hasLength(1));
          final initialAltokeEntityEntry = initialAltokeEntityEntries.single;
          expect(initialAltokeEntityEntry.key, isNot(altokeEntityId));
          final deletedAltokeEntity = await storage.deleteById(altokeEntityId);
          expect(deletedAltokeEntity, isNull);
          final resultingAltokeEntityEntries = box.toMap().entries;
          expect(resultingAltokeEntityEntries, hasLength(1));
          final resultingAltokeEntityEntry =
              resultingAltokeEntityEntries.single;
          expect(
            resultingAltokeEntityEntry.toAltokeEntity(),
            initialAltokeEntityEntry.toAltokeEntity(),
          );
        },
      );

      test(
        '''

├─ THAT has several altoke entity records
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
          await box.putAll({
            for (final altokeEntity in altokeEntities)
              altokeEntity.id: altokeEntity.toHive().toJson(),
          });
          final initialAltokeEntitiesCount = box.length;
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          const referenceAltokeEntity = PartialAltokeEntity(
            name: Some('matching-pattern'),
            description: Some('matching-pattern'),
          );
          await storage.deleteAll(referenceAltokeEntity: referenceAltokeEntity);
          final resultingAltokeEntityRecordEntries = box.toMap().entries;

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
            resultingAltokeEntityRecordEntries,
            hasLength(expectedResultingAltokeEntities.length),
          );
          final resultingAltokeEntities = [
            for (final altokeEntityRecordEntry
                in resultingAltokeEntityRecordEntries)
              altokeEntityRecordEntry.toAltokeEntity(),
          ];
          expect(
            resultingAltokeEntities,
            unorderedEquals(expectedResultingAltokeEntities),
          );
        },
      );

      test(
        '''

├─ THAT has several altoke entity records
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
          await box.putAll({
            for (final altokeEntity in altokeEntities)
              altokeEntity.id: altokeEntity.toHive().toJson(),
          });
          final initialAltokeEntitiesCount = box.length;
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          const referenceAltokeEntity = PartialAltokeEntity(
            description: Some('matching-pattern'),
          );
          await storage.deleteAll(referenceAltokeEntity: referenceAltokeEntity);
          final resultingAltokeEntityRecordEntries = box.toMap().entries;

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
            resultingAltokeEntityRecordEntries,
            hasLength(expectedResultingAltokeEntities.length),
          );
          final resultingAltokeEntities = [
            for (final altokeEntityRecordEntry
                in resultingAltokeEntityRecordEntries)
              altokeEntityRecordEntry.toAltokeEntity(),
          ];
          expect(
            resultingAltokeEntities,
            unorderedEquals(expectedResultingAltokeEntities),
          );
        },
      );

      test(
        '''

├─ THAT has several altoke entity records
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
          await box.putAll({
            for (final altokeEntity in altokeEntities)
              altokeEntity.id: altokeEntity.toHive().toJson(),
          });
          final initialAltokeEntitiesCount = box.length;
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          const referenceAltokeEntity = PartialAltokeEntity(
            name: Some('matching-pattern'),
            description: Some(null),
          );
          await storage.deleteAll(referenceAltokeEntity: referenceAltokeEntity);
          final resultingAltokeEntityRecordEntries = box.toMap().entries;

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
            resultingAltokeEntityRecordEntries,
            hasLength(expectedResultingAltokeEntities.length),
          );
          final resultingAltokeEntities = [
            for (final altokeEntityRecordEntry
                in resultingAltokeEntityRecordEntries)
              altokeEntityRecordEntry.toAltokeEntity(),
          ];
          expect(
            resultingAltokeEntities,
            unorderedEquals(expectedResultingAltokeEntities),
          );
        },
      );

      test(
        '''

├─ THAT has several altoke entity records
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
          await box.putAll({
            for (final altokeEntity in altokeEntities)
              altokeEntity.id: altokeEntity.toHive().toJson(),
          });
          final initialAltokeEntitiesCount = box.length;
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          const referenceAltokeEntity = PartialAltokeEntity(
            name: Some('matching-pattern'),
            description: Some(''),
          );
          await storage.deleteAll(referenceAltokeEntity: referenceAltokeEntity);
          final resultingAltokeEntityRecordEntries = box.toMap().entries;

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
            resultingAltokeEntityRecordEntries,
            hasLength(expectedResultingAltokeEntities.length),
          );
          final resultingAltokeEntities = [
            for (final altokeEntityRecordEntry
                in resultingAltokeEntityRecordEntries)
              altokeEntityRecordEntry.toAltokeEntity(),
          ];
          expect(
            resultingAltokeEntities,
            unorderedEquals(expectedResultingAltokeEntities),
          );
        },
      );

      test(
        '''

├─ THAT has several altoke entity records
AND a reference altoke entity
├─ THAT includes an empty description matcher
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
          await box.putAll({
            for (final altokeEntity in altokeEntities)
              altokeEntity.id: altokeEntity.toHive().toJson(),
          });
          final initialAltokeEntitiesCount = box.length;
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          const referenceAltokeEntity = PartialAltokeEntity(
            name: Some('matching-pattern'),
            description: Some(null),
          );
          await storage.deleteAll(referenceAltokeEntity: referenceAltokeEntity);
          final resultingAltokeEntitiesRecordEntries = box.toMap().entries;

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
            resultingAltokeEntitiesRecordEntries,
            hasLength(expectedResultingAltokeEntities.length),
          );
          final resultingAltokeEntities = [
            for (final altokeEntityRecordEntry
                in resultingAltokeEntitiesRecordEntries)
              altokeEntityRecordEntry.toAltokeEntity(),
          ];
          expect(
            resultingAltokeEntities,
            unorderedEquals(expectedResultingAltokeEntities),
          );
        },
      );

      test(
        '''

├─ THAT has several altoke entity records
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
          await box.putAll({
            for (final altokeEntity in altokeEntities)
              altokeEntity.id: altokeEntity.toHiveJson(),
          });
          final initialAltokeEntitiesCount = box.length;
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          await storage.deleteAll();
          final resultingAltokeEntityRecordEntriesCount = box.length;
          expect(resultingAltokeEntityRecordEntriesCount, isZero);
        },
      );

      test(
        '''

AND an altoke entity
WHEN the altoke entity is inserted
THEN a altoke entity record is registered
''',
        () async {
          const altokeEntity = AltokeEntity(
            id: 83,
            name: 'name',
            description: 'description',
          );
          final existingAltokeEntitiesCount = box.length;
          expect(existingAltokeEntitiesCount, isZero);
          await storage.insert(altokeEntity: altokeEntity);
          final resultingAltokeEntityRecordEntries = box.toMap().entries;
          expect(resultingAltokeEntityRecordEntries, hasLength(1));
          final resultingAltokeEntityRecordEntry =
              resultingAltokeEntityRecordEntries.single;
          expect(
            resultingAltokeEntityRecordEntry.toAltokeEntity(),
            altokeEntity,
          );
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
            id: 31,
            name: 'name',
            description: 'description',
          );
          await box.put(altokeEntity.id, altokeEntity.toHive().toJson());
          final existingAltokeEntitiesCount = box.length;
          expect(existingAltokeEntitiesCount, 1);
          const newName = 'new name';
          const newDescription = 'new description';
          bool filter(AltokeEntityEntry rawAltokeEntity) =>
              rawAltokeEntity.key == altokeEntity.id &&
              rawAltokeEntity.value[HiveAltokeEntity.nameJsonKey] == newName &&
              rawAltokeEntity.value[HiveAltokeEntity.descriptionJsonKey] ==
                  newDescription;
          final existingMatchingAltokeEntitiesCount =
              box.toMap().entries.where(filter).length;
          expect(existingMatchingAltokeEntitiesCount, isZero);
          await storage.update(
            altokeEntityId: altokeEntity.id,
            partialAltokeEntity: const PartialAltokeEntity(
              name: Some(newName),
              description: Some(newDescription),
            ),
          );
          final resultingMatchingAltokeEntitiesCount =
              box.toMap().entries.where(filter).length;
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
          final existingAltokeEntitiesCount = box.length;
          expect(existingAltokeEntitiesCount, isZero);
          expect(
            () async => storage.create(newAltokeEntity: newAltokeEntity),
            throwsA(isA<CreateAltokeEntityFailureEmptyName>()),
          );
          final resultingAltokeEntitiesCount = box.length;
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
            id: 103,
            name: 'name',
            description: 'description',
          );
          await box.put(altokeEntity.id, altokeEntity.toHiveJson());
          final existingAltokeEntitiesCount = box.length;
          expect(existingAltokeEntitiesCount, 1);
          const newName = '';
          const newDescription = 'new description';
          bool filter(AltokeEntityEntry rawAltokeEntity) =>
              rawAltokeEntity.key == altokeEntity.id &&
              rawAltokeEntity.value[HiveAltokeEntity.nameJsonKey] == newName &&
              rawAltokeEntity.value[HiveAltokeEntity.descriptionJsonKey] ==
                  newDescription;
          final existingMatchingAltokeEntitiesCount =
              box.toMap().entries.where(filter).length;
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
              box.toMap().entries.where(filter).length;
          expect(resultingMatchingAltokeEntitiesCount, isZero);
        },
      );

      test(
        '''

├─ THAT has altoke entity records
AND the ID of a registered altoke entity
WHEN the altoke entity is requested
THEN the altoke entity is returned
''',
        () async {
          const altokeEntityId = 991;
          const altokeEntity = AltokeEntity(
            id: altokeEntityId,
            name: 'name',
            description: 'description',
          );
          await box.put(altokeEntity.id, altokeEntity.toHive().toJson());
          bool filter(dynamic key) => key == altokeEntity.id;
          final initialMatchingAltokeEntitiesCount =
              box.keys.where(filter).length;
          expect(initialMatchingAltokeEntitiesCount, 1);
          final retrievedAltokeEntity = await storage.getById(altokeEntityId);
          expect(retrievedAltokeEntity, isNotNull);
          expect(retrievedAltokeEntity, altokeEntity);
        },
      );

      test(
        '''

├─ THAT has altoke entity records
AND the ID of an unregistered altoke entity
WHEN the altoke entity is requested
THEN null is returned
''',
        () async {
          const altokeEntityId = 325;
          bool filter(dynamic key) => key == altokeEntityId;
          final initialMatchingAltokeEntitiesCount =
              box.keys.where(filter).length;
          expect(initialMatchingAltokeEntitiesCount, isZero);
          final retrievedAltokeEntity = await storage.getById(altokeEntityId);
          expect(retrievedAltokeEntity, isNull);
        },
      );

      test(
        '''

├─ THAT has altoke entity records
WHEN the altoke entities are watched
├─ THAT are not filtered by their content
THEN the altoke entities are continuously emitted as they change
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
              description: 'description 02',
            ),
          ];
          final sortedAltokeEntitiesForStage00 = [...altokeEntitiesForStage00]
            ..sort((tA, tB) => tA.name.compareTo(tB.name));

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
            ..sort((tA, tB) => tA.name.compareTo(tB.name));

          // Stage 02
          final altokeEntitiesForStage02 = <AltokeEntity>[
            for (final altokeEntity in altokeEntitiesForStage01)
              if (!altokeEntity.name.contains('01')) altokeEntity,
          ];
          final sortedAltokeEntitiesForStage02 = [...altokeEntitiesForStage02]
            ..sort((tA, tB) => tA.name.compareTo(tB.name));

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
            ..sort((tA, tB) => tA.name.compareTo(tB.name));

          unawaited(
            expectLater(
              stream,
              emitsInOrder([
                orderedEquals(sortedAltokeEntitiesForStage00),
                orderedEquals(sortedAltokeEntitiesForStage01),
                orderedEquals(sortedAltokeEntitiesForStage02),
                orderedEquals(sortedAltokeEntitiesForStage03),
              ]),
            ),
          );

          // Stage 00
          await box.putAll({
            for (final altokeEntity in altokeEntitiesForStage00)
              altokeEntity.id: altokeEntity.toHive().toJson(),
          });

          // Stage 01
          await box.put(
            newAltokeEntityInStage01.id,
            newAltokeEntityInStage01.toHive().toJson(),
          );

          // Stage 02
          {
            final keysToDelete = box.toMap().entries.where(
              (entry) {
                final name = entry.value[HiveAltokeEntity.nameJsonKey];
                if (name is! String) return false;
                return name.contains('01');
              },
            ).map(
              (altokeEntityRecordEntry) => altokeEntityRecordEntry.key,
            );
            await box.deleteAll(keysToDelete);
          }

          // Stage 03
          {
            final updatedAltokeEntityRecordEntries = box
                .toMap()
                .entries
                .where(
                  (entry) =>
                      entry.value[HiveAltokeEntity.descriptionJsonKey] == null,
                )
                .map(
                  (entry) => entry
                    ..value[HiveAltokeEntity.descriptionJsonKey] =
                        'updated description',
                );
            await box.putAll(Map.fromEntries(updatedAltokeEntityRecordEntries));
          }
        },
      );

      test(
        '''

├─ THAT has altoke entity records
WHEN the altoke entities are watched
├─ THAT are filtered by their content
THEN the altoke entities are continuously emitted as they change
''',
        () async {
          final stream = storage.watch(searchTerm: 'matching-pattern');
          bool match(AltokeEntity altokeEntity) =>
              altokeEntity.name.contains('matching-pattern') ||
              (altokeEntity.description?.contains('matching-pattern') ?? false);

          // Stage 00
          final altokeEntitiesForStage00 = <AltokeEntity>[
            const AltokeEntity(
              id: 0,
              name: 'name 00',
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
          final expectedAltokeEntitiesForStage00 = altokeEntitiesForStage00
              .where(match)
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          // Stage 01
          const newAltokeEntityInStage01 = AltokeEntity(
            id: 3,
            name: 'name 03 matching-pattern',
          );
          final altokeEntitiesForStage01 = <AltokeEntity>[
            ...altokeEntitiesForStage00,
            newAltokeEntityInStage01,
          ];
          final expectedAltokeEntitiesForStage01 = altokeEntitiesForStage01
              .where(match)
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          // Stage 02
          final altokeEntitiesForStage02 = <AltokeEntity>[
            for (final altokeEntity in altokeEntitiesForStage01)
              if (!altokeEntity.name.contains('01')) altokeEntity,
          ];
          final expectedAltokeEntitiesForStage02 = altokeEntitiesForStage02
              .where(match)
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
          final expectedAltokeEntitiesForStage03 = altokeEntitiesForStage03
              .where(match)
              .sorted((tA, tB) => tA.name.compareTo(tB.name));

          unawaited(
            expectLater(
              stream,
              emitsInOrder([
                orderedEquals(expectedAltokeEntitiesForStage00),
                orderedEquals(expectedAltokeEntitiesForStage01),
                orderedEquals(expectedAltokeEntitiesForStage02),
                orderedEquals(expectedAltokeEntitiesForStage03),
              ]),
            ),
          );

          // Stage 00
          await box.putAll({
            for (final altokeEntity in altokeEntitiesForStage00)
              altokeEntity.id: altokeEntity.toHive().toJson(),
          });

          // Stage 01
          await box.put(
            newAltokeEntityInStage01.id,
            newAltokeEntityInStage01.toHive().toJson(),
          );

          // Stage 02
          {
            final keysToDelete = box.toMap().entries.where(
              (entry) {
                final name = entry.value[HiveAltokeEntity.nameJsonKey];
                if (name is! String) return false;
                return name.contains('01');
              },
            ).map(
              (altokeEntityRecordEntry) => altokeEntityRecordEntry.key,
            );
            await box.deleteAll(keysToDelete);
          }

          // Stage 03
          {
            final updatedAltokeEntityRecordEntries = box
                .toMap()
                .entries
                .where(
                  (entry) =>
                      entry.value[HiveAltokeEntity.descriptionJsonKey] == null,
                )
                .map(
                  (entry) => entry
                    ..value[HiveAltokeEntity.descriptionJsonKey] =
                        'updated description matching-pattern',
                );
            await box.putAll(Map.fromEntries(updatedAltokeEntityRecordEntries));
          }
        },
      );

      test(
        '''

├─ THAT has altoke entity records
WHEN the altoke entities count is watched
├─ THAT are not filtered by their content
THEN the quantity of altoke entities is continuously emitted as it changes
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
          await box.putAll({
            for (final altokeEntity in altokeEntitiesForStage00)
              altokeEntity.id: altokeEntity.toHive().toJson(),
          });

          // Stage 01
          await box.put(
            newAltokeEntityInStage01.id,
            newAltokeEntityInStage01.toHive().toJson(),
          );

          // Stage 02
          {
            final keysToDelete = box.toMap().entries.where(
              (entry) {
                final name = entry.value[HiveAltokeEntity.nameJsonKey];
                if (name is! String) return false;
                return name.contains('01');
              },
            ).map(
              (altokeEntityRecordEntry) => altokeEntityRecordEntry.key,
            );
            await box.deleteAll(keysToDelete);
          }

          // Stage 03
          {
            final updatedAltokeEntityRecordEntries = box
                .toMap()
                .entries
                .where(
                  (entry) =>
                      entry.value[HiveAltokeEntity.descriptionJsonKey] == null,
                )
                .map(
                  (entry) => entry
                    ..value[HiveAltokeEntity.descriptionJsonKey] =
                        'updated description',
                );
            await box.putAll(Map.fromEntries(updatedAltokeEntityRecordEntries));
          }
        },
      );

      test(
        '''

├─ THAT has altoke entity records
WHEN the altoke entities count is watched
├─ THAT are filtered by their content
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
          //         description: 'updated description matching-pattern',
          //       )
          //     else
          //       altokeEntity,
          // ];
          // final expectedAltokeEntitiesForStage03 =
          //     altokeEntitiesForStage03.where(match);

          unawaited(
            expectLater(
              stream,
              emitsInOrder([
                expectedAltokeEntitiesForStage00.length,
                expectedAltokeEntitiesForStage01.length,
                expectedAltokeEntitiesForStage02.length,

                // Not emitted as the altoke entities count has not changed
                // expectedAltokeEntitiesForStage03.length,
              ]),
            ),
          );

          // Stage 00
          await box.putAll({
            for (final altokeEntity in altokeEntitiesForStage00)
              altokeEntity.id: altokeEntity.toHiveJson(),
          });

          // Stage 01
          await box.put(
            newAltokeEntityInStage01.id,
            newAltokeEntityInStage01.toHiveJson(),
          );

          // Stage 02
          {
            final keysToDelete = box.toMap().entries.where(
              (entry) {
                final name = entry.value[HiveAltokeEntity.nameJsonKey];
                if (name is! String) return false;
                return name.contains('01');
              },
            ).map(
              (altokeEntityRecordEntry) => altokeEntityRecordEntry.key,
            );
            await box.deleteAll(keysToDelete);
          }

          // Stage 03
          {
            final updatedAltokeEntityRecordEntries = box
                .toMap()
                .entries
                .where(
                  (entry) =>
                      entry.value[HiveAltokeEntity.descriptionJsonKey] == null,
                )
                .map(
                  (entry) => entry
                    ..value[HiveAltokeEntity.descriptionJsonKey] =
                        'updated description matching-pattern',
                );
            await box.putAll(Map.fromEntries(updatedAltokeEntityRecordEntries));
          }
        },
      );
    },
  );
}
