import 'dart:developer';

import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/external/external.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
/*{{#use_go_router_router}}*/
import 'package:go_router/go_router.dart';
/*{{/use_go_router_router}}*/
/*{{#use_hive_database}}*/
import 'package:hive/hive.dart';
/*{{/use_hive_database}}*/
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
/*{{#use_realm_database}}*/
import 'package:realm/realm.dart';
/*{{/use_realm_database}}*/
/*{{#use_sembast_database}}*/
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';
/*{{/use_sembast_database}}*/
/*{{#use_hive_database}}*/
import 'package:tasks_hive_storage/tasks_hive_storage.dart';
/*{{/use_hive_database}}*/
/*{{#use_realm_database}}*/
import 'package:tasks_realm_storage/tasks_realm_storage.dart';
/*{{/use_realm_database}}*/
import 'package:universal_io/io.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*remove-start*/
  final routerPackage = RouterPackage.fromEnv;
  /*remove-end*/
  final routerConfig = /*remove-start*/ switch (routerPackage) {
    RouterPackage.autoRoute =>
      /*remove-end*/
      /*{{#use_auto_route_router}}*/
      AppRouter().config()
    /*{{/use_auto_route_router}}*/
    /*remove-start*/,
    RouterPackage.goRouter => /*remove-end*/
      /*{{#use_go_router_router}}*/
      GoRouter(routes: $appRoutes)
    /*{{/use_go_router_router}}*/
    /*remove-start*/,
  } /*remove-end*/;
  /*remove-start*/
  final databasePackage = DatabasePackage.fromEnv;
  /*remove-end*/
  /*{{#use_hive_database}}*/
  await initHiveDatabase(
    version: 1,
  );
  final tasksBox =
      await Hive.openBox<Map<dynamic, dynamic>>(TasksHiveStorage.boxName);
  /*{{/use_hive_database}}*/
  /*{{#use_realm_database}}*/
  final realmDb = await initRealmDatabase(
    version: 1,
  );
  /*{{/use_realm_database}}*/
  /*{{#use_sembast_database}}*/
  final sembastDb = await initSembastDatabase(
    version: 1,
  );
  /*{{/use_sembast_database}}*/
  runApp(
    ProviderScope(
      overrides: [
        /*remove-start*/
        routerPod.overrideWithValue(routerPackage),
        databasePod.overrideWithValue(databasePackage),
        /*remove-end*/
        /*{{#use_hive_database}}*/
        tasksBoxPod.overrideWithValue(tasksBox),
        /*{{/use_hive_database}}*/
        /*{{#use_realm_database}}*/
        realmDbPod.overrideWithValue(realmDb),
        /*{{/use_realm_database}}*/
        /*{{#use_sembast_database}}*/
        sembastDbPod.overrideWithValue(sembastDb),
        /*{{/use_sembast_database}}*/
      ],
      child: MyApp(
        routerConfig: routerConfig as RouterConfig<Object>,
      ),
    ),
  );
}

/*{{#use_hive_database}}*/
Future<void> initHiveDatabase({
  required int version,
}) async {
  final docsDir = await getApplicationDocumentsDirectory();
  final appDocsDir = Directory(path.join(docsDir.path, 'altoke-app'));
  final hiveDbDir = Directory(path.join(appDocsDir.path, 'hive-db'));
  if (!hiveDbDir.existsSync()) hiveDbDir.createSync(recursive: true);
  log('Hive DB dir: ${hiveDbDir.path}');
  if (!kIsWeb) Hive.init(hiveDbDir.path);
  await runHiveMigrations(
    newVersion: version,
    isDebugMode: kDebugMode,
  );
}
/*{{/use_hive_database}}*/

/*{{#use_realm_database}}*/
Future<Realm> initRealmDatabase({
  required int version,
}) async {
  if (kIsWeb) {
    log('Using in-memory Realm DB');
    return Realm(
      Configuration.inMemory([
        RealmTaskSchema,
      ]),
    );
  }
  final docsDir = await getApplicationDocumentsDirectory();
  final appDocsDir = Directory(path.join(docsDir.path, 'altoke-app'));
  final realmDbDir = Directory(path.join(appDocsDir.path, 'realm-db'));
  if (!realmDbDir.existsSync()) realmDbDir.createSync(recursive: true);
  log('Realm DB dir: ${realmDbDir.path}');
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
}
/*{{/use_realm_database}}*/

/*{{#use_sembast_database}}*/
Future<Database> initSembastDatabase({
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
  final appDocsDir = Directory(path.join(docsDir.path, 'altoke-app'));
  final sembastDbDir = Directory(path.join(appDocsDir.path, 'sembast-db'));
  if (!sembastDbDir.existsSync()) sembastDbDir.createSync(recursive: true);
  log('Sembast DB dir: ${sembastDbDir.path}');
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
}
/*{{/use_sembast_database}}*/
