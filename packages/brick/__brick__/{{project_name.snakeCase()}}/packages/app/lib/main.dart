import 'dart:developer';

import 'package:{{project_name.snakeCase()}}/app/app.dart';
import 'package:{{project_name.snakeCase()}}/external/external.dart';
import 'package:{{project_name.snakeCase()}}/routing/routing.dart';{{#use_hive_database}}import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';{{/use_hive_database}}{{#use_sqlite_database}}import 'package:drift/drift.dart';
import 'package:drift/native.dart';{{/use_sqlite_database}}import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';{{#use_go_router_router}}import 'package:go_router/go_router.dart';{{/use_go_router_router}}{{#use_hive_database}}import 'package:hive/hive.dart';{{/use_hive_database}}{{#use_isar_database}}import 'package:isar/isar.dart';{{/use_isar_database}}import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';{{#use_realm_database}}import 'package:realm/realm.dart';{{/use_realm_database}}{{#use_sembast_database}}import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';{{/use_sembast_database}}{{#use_sqlite_database}}import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';{{/use_sqlite_database}}{{#use_hive_database}}import 'package:tasks_hive_storage/tasks_hive_storage.dart';{{/use_hive_database}}{{#use_isar_database}}import 'package:tasks_isar_storage/tasks_isar_storage.dart';{{/use_isar_database}}{{#use_realm_database}}import 'package:tasks_realm_storage/tasks_realm_storage.dart';{{/use_realm_database}}import 'package:universal_io/io.dart';

class LoggerObserver extends ProviderObserver {
  const LoggerObserver();

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    if (!kDebugMode) return;
    log(
      'Provider failed\n$error',
      error: error,
      // stackTrace: stackTrace,
      name: provider.name ?? provider.runtimeType.toString(),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();final routerConfig ={{#use_auto_route_router}}AppRouter().config(){{/use_auto_route_router}}{{#use_go_router_router}}GoRouter(routes: $appRoutes){{/use_go_router_router}};{{#use_hive_database}}await initHiveDatabase(
    version: 1,
  );
  final tasksBox =
      await Hive.openBox<Map<dynamic, dynamic>>(TasksHiveStorage.boxName);{{/use_hive_database}}{{#use_isar_database}}final isarDb = await initIsarDatabase(
    version: 1,
  );{{/use_isar_database}}{{#use_realm_database}}final realmDb = await initRealmDatabase(
    version: 1,
  );{{/use_realm_database}}{{#use_sembast_database}}final sembastDb = await initSembastDatabase(
    version: 1,
  );{{/use_sembast_database}}{{#use_sqlite_database}}final sqliteDb = await initSqliteDatabase(
    version: 1,
  );{{/use_sqlite_database}}runApp(
    ProviderScope(
      observers: const [
        LoggerObserver(),
      ],
      overrides: [{{#use_hive_database}}tasksBoxPod.overrideWithValue(tasksBox),{{/use_hive_database}}{{#use_isar_database}}isarDbPod.overrideWithValue(isarDb),{{/use_isar_database}}{{#use_realm_database}}realmDbPod.overrideWithValue(realmDb),{{/use_realm_database}}{{#use_sembast_database}}sembastDbPod.overrideWithValue(sembastDb),{{/use_sembast_database}}{{#use_sqlite_database}}sqliteDbPod.overrideWithValue(sqliteDb),{{/use_sqlite_database}}],
      child: MyApp(
        routerConfig: routerConfig,
      ),
    ),
  );
}{{#use_hive_database}}Future<void> initHiveDatabase({
  required int version,
}) async {
  final docsDir = await getApplicationDocumentsDirectory();
  final appDocsDir = Directory(path.join(docsDir.path, '{{project_name.kebabCase()}}'));
  final hiveDbDir = Directory(path.join(appDocsDir.path, 'hive-db'));
  if (!hiveDbDir.existsSync()) hiveDbDir.createSync(recursive: true);
  if (kDebugMode) log('Hive DB dir: ${hiveDbDir.path}');
  if (!kIsWeb) Hive.init(hiveDbDir.path);
  await runHiveMigrations(
    newVersion: version,
    isDebugMode: kDebugMode,
  );
}{{/use_hive_database}}{{#use_isar_database}}Future<Isar> initIsarDatabase({
  required int version,
}) async {
  final docsDir = await getApplicationDocumentsDirectory();
  final appDocsDir = Directory(path.join(docsDir.path, '{{project_name.kebabCase()}}'));
  final isarDbDir = Directory(path.join(appDocsDir.path, 'isar-db'));
  if (!isarDbDir.existsSync()) isarDbDir.createSync(recursive: true);
  if (kDebugMode) log('Isar DB dir: ${isarDbDir.path}');
  final isar = await Isar.open(
    [
      IsarMetadataSchema,
      IsarTaskSchema,
    ],
    directory: isarDbDir.path,
  );
  await runIsarMigrations(
    database: isar,
    newVersion: version,
    isDebugMode: kDebugMode,
  );
  return isar;
}{{/use_isar_database}}{{#use_realm_database}}Future<Realm> initRealmDatabase({
  required int version,
}) async {
  if (kIsWeb) {
    if (kDebugMode) log('Using in-memory Realm DB');
    return Realm(
      Configuration.inMemory([
        RealmTaskSchema,
      ]),
    );
  }
  final docsDir = await getApplicationDocumentsDirectory();
  final appDocsDir = Directory(path.join(docsDir.path, '{{project_name.kebabCase()}}'));
  final realmDbDir = Directory(path.join(appDocsDir.path, 'realm-db'));
  if (!realmDbDir.existsSync()) realmDbDir.createSync(recursive: true);
  if (kDebugMode) log('Realm DB dir: ${realmDbDir.path}');
  final database = Realm(
    Configuration.local(
      [
        RealmTaskSchema,
      ],
      path: path.join(realmDbDir.path, 'db.realm'),
      schemaVersion: version,
      migrationCallback: (migration, oldVersion) async {
        await runRealmMigrations(
          migration: migration,
          oldVersion: oldVersion,
          newVersion: version,
          isDebugMode: kDebugMode,
        );
      },
    ),
  );
  return database;
}{{/use_realm_database}}{{#use_sembast_database}}Future<Database> initSembastDatabase({
  required int version,
}) async {
  if (kIsWeb) {
    return databaseFactoryWeb.openDatabase(
      'db.sembast',
      version: version,
      onVersionChanged: (database, oldVersion, newVersion) =>
          runSembastMigrations(
        database: database,
        oldVersion: oldVersion,
        newVersion: newVersion,
        isDebugMode: kDebugMode,
      ),
    );
  }
  final docsDir = await getApplicationDocumentsDirectory();
  final appDocsDir = Directory(path.join(docsDir.path, '{{project_name.kebabCase()}}'));
  final sembastDbDir = Directory(path.join(appDocsDir.path, 'sembast-db'));
  if (!sembastDbDir.existsSync()) sembastDbDir.createSync(recursive: true);
  if (kDebugMode) log('Sembast DB dir: ${sembastDbDir.path}');
  final database = await databaseFactoryIo.openDatabase(
    path.join(sembastDbDir.path, 'db.sembast'),
    version: version,
    onVersionChanged: (database, oldVersion, newVersion) =>
        runSembastMigrations(
      database: database,
      oldVersion: oldVersion,
      newVersion: newVersion,
      isDebugMode: kDebugMode,
    ),
  );
  return database;
}{{/use_sembast_database}}{{#use_sqlite_database}}Future<SqliteDatabase> initSqliteDatabase({
  required int version,
}) async {
  final docsDir = await getApplicationDocumentsDirectory();
  final tempDir = await getTemporaryDirectory();
  final appDocsDir = Directory(path.join(docsDir.path, '{{project_name.kebabCase()}}'));
  final sqliteDbDir = Directory(path.join(appDocsDir.path, 'sqlite-db'));
  if (!sqliteDbDir.existsSync()) sqliteDbDir.createSync(recursive: true);
  final sqliteDbFile = File(path.join(sqliteDbDir.path, 'db.sqlite'));
  if (kDebugMode) log('SQLite DB dir: ${sqliteDbDir.path}');
  final database = SqliteDatabase(
    openConnection: LazyDatabase(
      () async {
        if (Platform.isAndroid) {
          await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
        }
        sqlite3.tempDirectory = tempDir.path;
        return NativeDatabase.createInBackground(sqliteDbFile);
      },
    ),
    migrationStrategy: MigrationStrategy(
      onCreate: (migrator) async {
        if (kDebugMode) log('onCreate');
        await migrator.createAll();
        await runSqliteMigrations(
          migrator: migrator,
          oldVersion: 0,
          newVersion: version,
          isDebugMode: kDebugMode,
        );
      },
      onUpgrade: (migrator, from, to) async {
        if (kDebugMode) log('onUpgrade');
        await runSqliteMigrations(
          migrator: migrator,
          oldVersion: from,
          newVersion: to,
          isDebugMode: kDebugMode,
        );
      },
    ),
  );
  return database;
}{{/use_sqlite_database}}