/*{{^ use_hive_database}}*/
import 'package:altoke_app/external/external.dart'
    show
/*remove-start*/
        DatabasePackage,
/*remove-end*/
/*w 1> w*/
/*{{#use_realm_database}}*/
        realmDb,
        realmDbPod
/*{{/use_realm_database}}*/
/*remove-start*/
        ,
/*remove-end*/
/*{{#use_sembast_database}}*/
        sembastDb,
        sembastDbPod
/*{{/use_sembast_database}}*/
    ;
/*{{/use_hive_database}}*/
/*{{#use_hive_database}}*/
import 'package:altoke_app/tasks/tasks.dart' show tasksBox, tasksBoxPod;
/*{{/use_hive_database}}*/
import 'package:riverpod_annotation/riverpod_annotation.dart';
/*{{#use_hive_database}}*/
import 'package:tasks_hive_storage/tasks_hive_storage.dart'
    show TasksHiveStorage;
/*{{/use_hive_database}}*/
/*{{#use_realm_database}}*/
import 'package:tasks_realm_storage/tasks_realm_storage.dart'
    show TasksRealmStorage;
/*{{/use_realm_database}}*/
/*{{#use_sembast_database}}*/
import 'package:tasks_sembast_storage/tasks_sembast_storage.dart'
    show TasksSembastStorage;
/*{{/use_sembast_database}}*/
import 'package:tasks_storage/tasks_storage.dart' show TasksStorage;

part 'tasks_storage.pod.g.dart';

@Riverpod(
  dependencies: [
    /*{{#use_hive_database}}*/
    tasksBox,
    /*{{/use_hive_database}}*/
    /*{{#use_realm_database}}*/
    realmDb,
    /*{{/use_realm_database}}*/
    /*{{#use_sembast_database}}*/
    sembastDb,
    /*{{/use_sembast_database}}*/
  ],
)
TasksStorage tasksStorage(TasksStorageRef ref) {
  /*w 1v w*/
  /*{{#use_hive_database}}*/
  final tasksBox = ref.watch(tasksBoxPod);
  /*{{/use_hive_database}}*/
  /*{{#use_realm_database}}*/
  final realmDb = ref.watch(realmDbPod);
  /*{{/use_realm_database}}*/
  /*{{#use_sembast_database}}*/
  final sembastDb = ref.watch(sembastDbPod);
  /*{{/use_sembast_database}}*/
  /*remove-start*/
  final databasePackage = DatabasePackage.fromEnv;
  /*remove-end*/
  final storage = /*remove-start*/ switch (databasePackage) {
    DatabasePackage.hive =>
      /*remove-end*/
      /*{{#use_hive_database}}*/
      TasksHiveStorage(
        box: tasksBox,
      )
    /*{{/use_hive_database}}*/
    /*remove-start*/,
    DatabasePackage.realm =>
      /*remove-end*/
      /*{{#use_realm_database}}*/
      TasksRealmStorage(
        database: realmDb,
      )
    /*{{/use_realm_database}}*/
    /*remove-start*/,
    DatabasePackage.sembast =>
      /*remove-end*/
      /*{{#use_sembast_database}}*/
      TasksSembastStorage(
        database: sembastDb,
      )
    /*{{/use_sembast_database}}*/
    /*remove-start*/,
  } /*remove-end*/;
  return storage;
}
