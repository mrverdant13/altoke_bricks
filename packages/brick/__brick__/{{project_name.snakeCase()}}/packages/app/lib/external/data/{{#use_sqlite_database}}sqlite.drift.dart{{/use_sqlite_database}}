// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:tasks_sqlite_storage/tasks.drift.dart' as i1;
import 'package:drift/internal/modular.dart' as i2;

abstract class $SqliteDatabase extends i0.GeneratedDatabase {
  $SqliteDatabase(i0.QueryExecutor e) : super(e);
  late final i1.Tasks tasks = i1.Tasks(this);
  i1.TasksDrift get tasksDrift =>
      i2.ReadDatabaseContainer(this).accessor<i1.TasksDrift>(i1.TasksDrift.new);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [tasks];
}
