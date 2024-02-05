{{^use_hive_database}}import 'package:{{project_name.snakeCase()}}/external/external.dart'
    show {{#use_isar_database}}isarDb,
        isarDbPod{{/use_isar_database}}{{#use_realm_database}}realmDb,
        realmDbPod{{/use_realm_database}}{{#use_sembast_database}}sembastDb,
        sembastDbPod{{/use_sembast_database}}{{#use_sqlite_database}}sqliteDb,
        sqliteDbPod{{/use_sqlite_database}};{{/use_hive_database}}{{#use_hive_database}}import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart' show tasksBox, tasksBoxPod;{{/use_hive_database}}import 'package:riverpod_annotation/riverpod_annotation.dart';{{#use_hive_database}}import 'package:tasks_hive_storage/tasks_hive_storage.dart'
    show TasksHiveStorage;{{/use_hive_database}}{{#use_isar_database}}import 'package:tasks_isar_storage/tasks_isar_storage.dart'
    show TasksIsarStorage;{{/use_isar_database}}{{#use_realm_database}}import 'package:tasks_realm_storage/tasks_realm_storage.dart'
    show TasksRealmStorage;{{/use_realm_database}}{{#use_sembast_database}}import 'package:tasks_sembast_storage/tasks_sembast_storage.dart'
    show TasksSembastStorage;{{/use_sembast_database}}{{#use_sqlite_database}}import 'package:tasks_sqlite_storage/tasks_sqlite_storage.dart'
    show TasksSqliteStorage;{{/use_sqlite_database}}import 'package:tasks_storage/tasks_storage.dart' show TasksStorage;

part 'tasks_storage.pod.g.dart';

@Riverpod(
  dependencies: [{{#use_isar_database}}isarDb,{{/use_isar_database}}{{#use_hive_database}}tasksBox,{{/use_hive_database}}{{#use_realm_database}}realmDb,{{/use_realm_database}}{{#use_sembast_database}}sembastDb,{{/use_sembast_database}}{{#use_sqlite_database}}sqliteDb,{{/use_sqlite_database}}],
)
TasksStorage tasksStorage(TasksStorageRef ref) {
final storage ={{#use_hive_database}}TasksHiveStorage(
        box: ref.watch(tasksBoxPod),
      ){{/use_hive_database}}{{#use_isar_database}}TasksIsarStorage(
        database: ref.watch(isarDbPod),
      ){{/use_isar_database}}{{#use_realm_database}}TasksRealmStorage(
        database: ref.watch(realmDbPod),
      ){{/use_realm_database}}{{#use_sembast_database}}TasksSembastStorage(
        database: ref.watch(sembastDbPod),
      ){{/use_sembast_database}}{{#use_sqlite_database}}TasksSqliteStorage(
        tasksDao: ref.watch(
          sqliteDbPod.select(
            (database) => database.tasksDrift,
          ),
        ),
      ){{/use_sqlite_database}};
  return storage;
}
