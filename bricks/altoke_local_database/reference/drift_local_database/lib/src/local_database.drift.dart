// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:drift_local_database/src/tasks.drift.dart' as i1;
import 'package:drift/internal/modular.dart' as i2;

abstract class $LocalDatabase extends i0.GeneratedDatabase {
  $LocalDatabase(i0.QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final i1.Tasks tasks = i1.Tasks(this);
  i1.TasksDrift get tasksDrift =>
      i2.ReadDatabaseContainer(this).accessor<i1.TasksDrift>(i1.TasksDrift.new);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [tasks];
}

class $LocalDatabaseManager {
  final $LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  i1.$TasksTableManager get tasks => i1.$TasksTableManager(_db, _db.tasks);
}
