import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/bootstrap/bootstrap.dart';
import 'package:altoke_app/counter/counter.dart';
/*x-remove-start*/
import 'package:altoke_app/external/external.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:altoke_app/tasks/tasks.dart';
/*remove-end*/
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([
  asyncInitialization,
  Counter,
  /*x-remove-start*/
  asyncTasks,
  localTasksDao,
  SelectedLocalDatabasePackage,
  SelectedRouterPackage,
  /*remove-end*/
])
Future<void> main() async {
  await bootstrap();
}
