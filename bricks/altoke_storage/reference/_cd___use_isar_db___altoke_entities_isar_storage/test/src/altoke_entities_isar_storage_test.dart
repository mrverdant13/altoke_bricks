import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:altoke_common/common.dart';
import 'package:altoke_entities_isar_storage/altoke_entities_isar_storage.dart';
import 'package:altoke_entities_storage/altoke_entities_storage.dart';
import 'package:altoke_entity/altoke_entity.dart';
import 'package:collection/collection.dart';
import 'package:isar/isar.dart';
import 'package:test/test.dart';

Future<Isar> openIsar(Directory dbDir) async {
  final isar = Isar.getInstance() ??
      await Isar.open(
        [IsarAltokeEntitySchema],
        directory: dbDir.path,
        inspector: false,
        relaxedDurability: false,
      );
  return isar;
}

extension on Abi {
  String get localName {
    switch (this) {
      case Abi.macosArm64 || Abi.macosX64:
        // cspell: disable-next-line
        return 'libisar.dylib';
      case Abi.linuxX64:
        // cspell: disable-next-line
        return 'libisar.so';
      case Abi.windowsArm64 || Abi.windowsX64:
        return 'isar.dll';
      default:
        throw UnsupportedError(
          'Unsupported processor architecture "$this" for tests',
        );
    }
  }
}

void main() {
  setUpAll(
    () async {
      // This step is a workaround to avoid issues affecting test suits.
      // See: https://github.com/isar/isar/issues/1518
      final isarLibDir = Directory.systemTemp.createTempSync('isar-test-lib-');
      final abi = Abi.current();
      await Isar.initializeIsarCore(
        download: true,
        libraries: {
          abi: '${isarLibDir.path}${Platform.pathSeparator}${abi.localName}',
        },
      );
    },
  );

  test(
    '''

GIVEN a constructor for a altoke entities storage
├─ THAT uses an Isar database
WHEN the constructor is called
THEN an instance of the storage is returned
''',
    () async {
      final databaseDir = Directory.systemTemp.createTempSync('isar-testing-');
      final database = await openIsar(databaseDir);
      final storage = AltokeEntitiesIsarStorage(database: database);
      expect(storage, isNotNull);
      expect(storage, isA<AltokeEntitiesStorage>());
      await database.close(deleteFromDisk: true);
      await databaseDir.delete(recursive: true);
    },
  );

  group(
    '''

GIVEN an altoke entities storage
├─ THAT uses an Isar database''',
    () {
      late Directory databaseDir;
      late Isar database;
      late AltokeEntitiesIsarStorage storage;
      late IsarAltokeEntitiesCollection isarAltokeEntities;

      setUp(() async {
        databaseDir = Directory.systemTemp.createTempSync(
          'isar-testing-',
        );
        database = await openIsar(databaseDir);
        storage = AltokeEntitiesIsarStorage(database: database);
        isarAltokeEntities = database.isarAltokeEntities;
      });

      tearDown(() async {
        await database.close();
        await databaseDir.delete(recursive: true);
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
          final existingAltokeEntitiesCount = await isarAltokeEntities.count();
          expect(existingAltokeEntitiesCount, isZero);
          await storage.create(newAltokeEntity: newAltokeEntity);
          final resultingMatchingAltokeEntitiesCount = await isarAltokeEntities
              .filter()
              .nameEqualTo(newAltokeEntity.name)
              .descriptionEqualTo(newAltokeEntity.description)
              .count();
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
          const existingAltokeEntity = NewAltokeEntity(
            name: 'existing',
            description: 'description',
          );
          await database.writeTxn(
            () async => isarAltokeEntities.put(
              existingAltokeEntity.toIsar(),
            ),
          );
          final initialAltokeEntitiesCount = await isarAltokeEntities.count();
          expect(initialAltokeEntitiesCount, 1);
          const newAltokeEntity = NewAltokeEntity(
            name: 'new',
            description: 'description',
          );
          await storage.create(newAltokeEntity: newAltokeEntity);
          final resultingMatchingAltokeEntitiesCount = await isarAltokeEntities
              .filter()
              .nameEqualTo(newAltokeEntity.name)
              .descriptionEqualTo(newAltokeEntity.description)
              .count();
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
          final existingAltokeEntitiesCount = await isarAltokeEntities.count();
          expect(existingAltokeEntitiesCount, isZero);
          expect(
            () async => storage.create(newAltokeEntity: newAltokeEntity),
            throwsA(isA<CreateAltokeEntityFailureEmptyName>()),
          );
          final resultingAltokeEntitiesCount = await isarAltokeEntities.count();
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
          const altokeEntityId = 13;
          const newAltokeEntity =
              NewAltokeEntity(name: 'name', description: 'description');
          await database.writeTxn(
            () async => isarAltokeEntities.put(
              newAltokeEntity.toIsar()..id = altokeEntityId,
            ),
          );
          final initialMatchingAltokeEntitiesCount = await isarAltokeEntities
              .filter()
              .idEqualTo(altokeEntityId)
              .count();
          expect(initialMatchingAltokeEntitiesCount, 1);
          final deletedAltokeEntity = await storage.deleteById(altokeEntityId);
          expect(deletedAltokeEntity, isNotNull);
          expect(deletedAltokeEntity?.id, altokeEntityId);
          final resultingMatchingAltokeEntitiesCount = await isarAltokeEntities
              .filter()
              .idEqualTo(altokeEntityId)
              .count();
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
          const altokeEntityId = 17;
          const newAltokeEntity =
              NewAltokeEntity(name: 'name', description: 'description');
          await database.writeTxn(
            () async => isarAltokeEntities.put(
              newAltokeEntity.toIsar(),
            ),
          );
          final initialAltokeEntities =
              await isarAltokeEntities.where().findAll();
          expect(initialAltokeEntities, hasLength(1));
          final initialAltokeEntity = initialAltokeEntities.single;
          expect(initialAltokeEntity.id, isNot(altokeEntityId));
          final deletedAltokeEntity = await storage.deleteById(altokeEntityId);
          expect(deletedAltokeEntity, isNull);
          final resultingAltokeEntities =
              await isarAltokeEntities.where().findAll();
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
          await database.writeTxn(
            () async => isarAltokeEntities.putAll([
              for (final altokeEntity in altokeEntities) altokeEntity.toIsar(),
            ]),
          );
          final initialAltokeEntitiesCount = await isarAltokeEntities.count();
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          const referenceAltokeEntity = PartialAltokeEntity(
            name: Some('matching-pattern'),
            description: Some('matching-pattern'),
          );
          await storage.deleteAll(referenceAltokeEntity: referenceAltokeEntity);
          final resultingIsarAltokeEntities =
              await isarAltokeEntities.where().findAll();

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
            resultingIsarAltokeEntities,
            hasLength(expectedResultingAltokeEntities.length),
          );
          final resultingAltokeEntities = [
            for (final isarAltokeEntity in resultingIsarAltokeEntities)
              isarAltokeEntity.toAltokeEntity(),
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
          await database.writeTxn(
            () async => isarAltokeEntities.putAll([
              for (final altokeEntity in altokeEntities) altokeEntity.toIsar(),
            ]),
          );
          final initialAltokeEntitiesCount = await isarAltokeEntities.count();
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          const referenceAltokeEntity = PartialAltokeEntity(
            description: Some('matching-pattern'),
          );
          await storage.deleteAll(referenceAltokeEntity: referenceAltokeEntity);
          final resultingIsarAltokeEntities =
              await isarAltokeEntities.where().findAll();

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
            resultingIsarAltokeEntities,
            hasLength(expectedResultingAltokeEntities.length),
          );
          final resultingAltokeEntities = [
            for (final isarAltokeEntity in resultingIsarAltokeEntities)
              isarAltokeEntity.toAltokeEntity(),
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
          await database.writeTxn(
            () async => isarAltokeEntities.putAll(
              [
                for (final altokeEntity in altokeEntities)
                  altokeEntity.toIsar(),
              ],
            ),
          );
          final initialAltokeEntitiesCount = await isarAltokeEntities.count();
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          const referenceAltokeEntity = PartialAltokeEntity(
            name: Some('matching-pattern'),
            description: Some(null),
          );
          await storage.deleteAll(referenceAltokeEntity: referenceAltokeEntity);
          final resultingIsarAltokeEntities =
              await isarAltokeEntities.where().findAll();

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
            resultingIsarAltokeEntities,
            hasLength(expectedResultingAltokeEntities.length),
          );
          final resultingAltokeEntities = [
            for (final isarAltokeEntity in resultingIsarAltokeEntities)
              isarAltokeEntity.toAltokeEntity(),
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
          await database.writeTxn(
            () async => isarAltokeEntities.putAll(
              [
                for (final altokeEntity in altokeEntities)
                  altokeEntity.toIsar(),
              ],
            ),
          );
          final initialAltokeEntitiesCount = await isarAltokeEntities.count();
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          const referenceAltokeEntity = PartialAltokeEntity(
            name: Some('matching-pattern'),
            description: Some(''),
          );
          await storage.deleteAll(referenceAltokeEntity: referenceAltokeEntity);
          final resultingIsarAltokeEntities =
              await isarAltokeEntities.where().findAll();

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
            resultingIsarAltokeEntities,
            hasLength(expectedResultingAltokeEntities.length),
          );
          final resultingAltokeEntities = [
            for (final isarAltokeEntity in resultingIsarAltokeEntities)
              isarAltokeEntity.toAltokeEntity(),
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
          await database.writeTxn(
            () async => isarAltokeEntities.putAll(
              [
                for (final altokeEntity in altokeEntities)
                  altokeEntity.toIsar(),
              ],
            ),
          );
          final initialAltokeEntitiesCount = await isarAltokeEntities.count();
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          const referenceAltokeEntity = PartialAltokeEntity(
            name: Some('matching-pattern'),
            description: Some(null),
          );
          await storage.deleteAll(referenceAltokeEntity: referenceAltokeEntity);
          final resultingIsarAltokeEntities =
              await isarAltokeEntities.where().findAll();

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
            resultingIsarAltokeEntities,
            hasLength(expectedResultingAltokeEntities.length),
          );
          final resultingAltokeEntities = [
            for (final isarAltokeEntity in resultingIsarAltokeEntities)
              isarAltokeEntity.toAltokeEntity(),
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
          await database.writeTxn(
            () async => isarAltokeEntities.putAll([
              for (final altokeEntity in altokeEntities) altokeEntity.toIsar(),
            ]),
          );
          final initialAltokeEntitiesCount = await isarAltokeEntities.count();
          expect(initialAltokeEntitiesCount, altokeEntities.length);
          await storage.deleteAll();
          final resultingIsarAltokeEntitiesCount =
              await isarAltokeEntities.count();
          expect(resultingIsarAltokeEntitiesCount, isZero);
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
            id: 83,
            name: 'name',
            description: 'description',
          );
          final existingAltokeEntitiesCount = await isarAltokeEntities.count();
          expect(existingAltokeEntitiesCount, isZero);
          await storage.insert(altokeEntity: altokeEntity);
          final resultingIsarAltokeEntities =
              await isarAltokeEntities.where().findAll();
          expect(resultingIsarAltokeEntities, hasLength(1));
          final resultingIsarAltokeEntity = resultingIsarAltokeEntities.single;
          expect(resultingIsarAltokeEntity.toAltokeEntity(), altokeEntity);
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
          await database.writeTxn(
            () async => isarAltokeEntities.put(altokeEntity.toIsar()),
          );
          final existingAltokeEntitiesCount = await isarAltokeEntities.count();
          expect(existingAltokeEntitiesCount, 1);
          const newTitle = 'new name';
          const newDescription = 'new description';
          final query = isarAltokeEntities
              .filter()
              .idEqualTo(altokeEntity.id)
              .and()
              .nameEqualTo(newTitle)
              .and()
              .descriptionEqualTo(newDescription);
          final existingMatchingAltokeEntitiesCount = await query.count();
          expect(existingMatchingAltokeEntitiesCount, isZero);
          await storage.update(
            altokeEntityId: altokeEntity.id,
            partialAltokeEntity: const PartialAltokeEntity(
              name: Some(newTitle),
              description: Some(newDescription),
            ),
          );
          final resultingMatchingAltokeEntitiesCount = await query.count();
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
          final existingAltokeEntitiesCount = await isarAltokeEntities.count();
          expect(existingAltokeEntitiesCount, isZero);
          expect(
            () async => storage.create(newAltokeEntity: newAltokeEntity),
            throwsA(isA<CreateAltokeEntityFailureEmptyName>()),
          );
          final resultingAltokeEntitiesCount = await isarAltokeEntities.count();
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
          await database.writeTxn(
            () async => isarAltokeEntities.put(altokeEntity.toIsar()),
          );
          final existingAltokeEntitiesCount = await isarAltokeEntities.count();
          expect(existingAltokeEntitiesCount, 1);
          const newTitle = '';
          const newDescription = 'new description';
          final query = isarAltokeEntities
              .filter()
              .idEqualTo(altokeEntity.id)
              .and()
              .nameEqualTo(newTitle)
              .and()
              .descriptionEqualTo(newDescription);
          final existingMatchingAltokeEntitiesCount = await query.count();
          expect(existingMatchingAltokeEntitiesCount, isZero);
          expect(
            () async => storage.update(
              altokeEntityId: altokeEntity.id,
              partialAltokeEntity: const PartialAltokeEntity(
                name: Some(newTitle),
                description: Some(newDescription),
              ),
            ),
            throwsA(isA<UpdateAltokeEntityFailureEmptyName>()),
          );
          final resultingMatchingAltokeEntitiesCount = await query.count();
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
          const altokeEntityId = 991;
          const altokeEntity = AltokeEntity(
            id: altokeEntityId,
            name: 'name',
            description: 'description',
          );
          await database.writeTxn(
            () async => isarAltokeEntities.put(altokeEntity.toIsar()),
          );
          final query = isarAltokeEntities.filter().idEqualTo(altokeEntityId);
          final initialMatchingAltokeEntitiesCount = await query.count();
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
          const altokeEntityId = 325;
          final query = isarAltokeEntities.filter().idEqualTo(altokeEntityId);
          final initialMatchingAltokeEntitiesCount = await query.count();
          expect(initialMatchingAltokeEntitiesCount, isZero);
          final retrievedAltokeEntity = await storage.getById(altokeEntityId);
          expect(retrievedAltokeEntity, isNull);
        },
      );

      test(
        '''

│  ├─ THAT has altoke entity records
WHEN a altoke entities page is watched
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
                  List<AltokeEntity>.empty(), // initially empty
                  orderedEquals(sortedAltokeEntitiesForStage00),
                  orderedEquals(sortedAltokeEntitiesForStage01),
                  orderedEquals(sortedAltokeEntitiesForStage02),
                  orderedEquals(sortedAltokeEntitiesForStage03),
                ],
              ),
            ),
          );

          // Stage 00
          await database.writeTxn(
            () async => isarAltokeEntities.putAll([
              for (final altokeEntity in altokeEntitiesForStage00)
                altokeEntity.toIsar(),
            ]),
          );

          // Stage 01
          await database.writeTxn(
            () async => isarAltokeEntities.put(
              newAltokeEntityInStage01.toIsar(),
            ),
          );

          // Stage 02
          await database.writeTxn(
            () async =>
                isarAltokeEntities.filter().nameContains('01').deleteAll(),
          );

          // Stage 03
          await database.writeTxn(
            () async {
              final altokeEntitiesWithoutDescription = await isarAltokeEntities
                  .filter()
                  .descriptionIsNull()
                  .findAll();
              await isarAltokeEntities.putAll([
                for (final altokeEntity in altokeEntitiesWithoutDescription)
                  altokeEntity..description = 'updated description',
              ]);
            },
          );
        },
      );

      test(
        '''

│  ├─ THAT has altoke entity records
WHEN a altoke entities are watched
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
                List<AltokeEntity>.empty(), // initially empty
                orderedEquals(expectedAltokeEntitiesForStage00),
                orderedEquals(expectedAltokeEntitiesForStage01),
                orderedEquals(expectedAltokeEntitiesForStage02),
                orderedEquals(expectedAltokeEntitiesForStage03),
              ]),
            ),
          );

          // Stage 00
          await database.writeTxn(
            () async => isarAltokeEntities.putAll([
              for (final altokeEntity in altokeEntitiesForStage00)
                altokeEntity.toIsar(),
            ]),
          );

          // Stage 01
          await database.writeTxn(
            () async => isarAltokeEntities.put(
              newAltokeEntityInStage01.toIsar(),
            ),
          );

          // Stage 02
          await database.writeTxn(
            () async =>
                isarAltokeEntities.filter().nameContains('01').deleteAll(),
          );

          // Stage 03
          await database.writeTxn(
            () async {
              final altokeEntitiesWithoutDescription = await isarAltokeEntities
                  .filter()
                  .descriptionIsNull()
                  .findAll();
              await isarAltokeEntities.putAll([
                for (final altokeEntity in altokeEntitiesWithoutDescription)
                  altokeEntity
                    ..description = 'updated description matching-pattern',
              ]);
            },
          );
        },
      );

      test(
        '''

│  ├─ THAT has altoke entity records
WHEN the altoke entities count is watched
├─ THAT are not filtered by their content
THEN the quantity of persisted altoke entities are continuously emitted as it changes
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
                0, // initially empty
                altokeEntitiesForStage00.length,
                altokeEntitiesForStage01.length,
                altokeEntitiesForStage02.length,

                // Not emitted as the altoke entities count has not changed
                // altokeEntitiesForStage03.length,
              ]),
            ),
          );

          // Stage 00
          {
            await database.writeTxn(
              () async => isarAltokeEntities.putAll([
                for (final altokeEntity in altokeEntitiesForStage00)
                  altokeEntity.toIsar(),
              ]),
            );
          }

          // Stage 01
          {
            await database.writeTxn(
              () async => isarAltokeEntities.put(
                newAltokeEntityInStage01.toIsar(),
              ),
            );
          }

          // Stage 02
          await database.writeTxn(
            () async =>
                isarAltokeEntities.filter().nameContains('01').deleteAll(),
          );

          // Stage 03
          await database.writeTxn(
            () async {
              final altokeEntitiesWithoutDescription = await isarAltokeEntities
                  .filter()
                  .descriptionIsNull()
                  .findAll();
              await isarAltokeEntities.putAll(
                [
                  for (final altokeEntity in altokeEntitiesWithoutDescription)
                    altokeEntity..description = 'updated description',
                ],
              );
            },
          );
        },
      );

      test(
        '''

│  ├─ THAT has altoke entity records
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
                  0, // initially empty
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
          {
            await database.writeTxn(
              () async => isarAltokeEntities.putAll([
                for (final altokeEntity in altokeEntitiesForStage00)
                  altokeEntity.toIsar(),
              ]),
            );
          }

          // Stage 01
          {
            await database.writeTxn(
              () async => isarAltokeEntities.put(
                newAltokeEntityInStage01.toIsar(),
              ),
            );
          }

          // Stage 02
          await database.writeTxn(
            () async =>
                isarAltokeEntities.filter().nameContains('01').deleteAll(),
          );

          // Stage 03
          await database.writeTxn(
            () async {
              final altokeEntitiesWithoutDescription = await isarAltokeEntities
                  .filter()
                  .descriptionIsNull()
                  .findAll();
              await isarAltokeEntities.putAll(
                [
                  for (final altokeEntity in altokeEntitiesWithoutDescription)
                    altokeEntity..description = 'updated description',
                ],
              );
            },
          );
        },
      );
    },
  );
}
