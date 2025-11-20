/*{{#use_riverpod}}*/
import 'package:altoke_app/app/app.dart';
/*{{/use_riverpod}}*/
import 'package:altoke_app/bootstrap/bootstrap.dart';
/*{{#use_riverpod}}*/
import 'package:altoke_app/counter/counter.dart';
/*{{/use_riverpod}}*/
/*x-remove-start*/
import 'package:altoke_app/external/external.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:altoke_app/tasks/tasks.dart';
/*remove-end*/
/*x{{#use_riverpod}}*/
import 'package:riverpod_annotation/experimental/scope.dart';
/*x{{/use_riverpod}}*/

@Dependencies([
  asyncInitialization,
  Counter,
  /*x-remove-start*/
  asyncTasks,
  localTasksDao,
  SelectedLocalDatabasePackage,
  SelectedRouterPackage,
  SelectedStateManagementPackage,
  /*remove-end*/
])
Future<void> main() async {
  await bootstrap();
}
