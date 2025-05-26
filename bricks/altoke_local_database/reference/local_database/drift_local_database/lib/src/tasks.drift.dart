// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:local_database/src/models/task.dart' as i1;
import 'package:local_database/src/models/task_priority.dart' as i2;
import 'package:drift_local_database/src/tasks.drift.dart' as i3;
import 'package:drift_local_database/src/type_converters/task_priority_converter.dart'
    as i4;
import 'package:drift/internal/modular.dart' as i5;

typedef $TasksCreateCompanionBuilder =
    i3.TasksCompanion Function({
      i0.Value<int> id,
      required String title,
      required i2.TaskPriority priority,
      i0.Value<bool> completed,
      i0.Value<String?> description,
    });
typedef $TasksUpdateCompanionBuilder =
    i3.TasksCompanion Function({
      i0.Value<int> id,
      i0.Value<String> title,
      i0.Value<i2.TaskPriority> priority,
      i0.Value<bool> completed,
      i0.Value<String?> description,
    });

class $TasksFilterComposer extends i0.Composer<i0.GeneratedDatabase, i3.Tasks> {
  $TasksFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnWithTypeConverterFilters<i2.TaskPriority, i2.TaskPriority, String>
  get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => i0.ColumnWithTypeConverterFilters(column),
  );

  i0.ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $TasksOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i3.Tasks> {
  $TasksOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $TasksAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i3.Tasks> {
  $TasksAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  i0.GeneratedColumnWithTypeConverter<i2.TaskPriority, String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  i0.GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  i0.GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );
}

class $TasksTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i3.Tasks,
          i1.Task,
          i3.$TasksFilterComposer,
          i3.$TasksOrderingComposer,
          i3.$TasksAnnotationComposer,
          $TasksCreateCompanionBuilder,
          $TasksUpdateCompanionBuilder,
          (i1.Task, i0.BaseReferences<i0.GeneratedDatabase, i3.Tasks, i1.Task>),
          i1.Task,
          i0.PrefetchHooks Function()
        > {
  $TasksTableManager(i0.GeneratedDatabase db, i3.Tasks table)
    : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i3.$TasksFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i3.$TasksOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i3.$TasksAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<String> title = const i0.Value.absent(),
                i0.Value<i2.TaskPriority> priority = const i0.Value.absent(),
                i0.Value<bool> completed = const i0.Value.absent(),
                i0.Value<String?> description = const i0.Value.absent(),
              }) => i3.TasksCompanion(
                id: id,
                title: title,
                priority: priority,
                completed: completed,
                description: description,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required String title,
                required i2.TaskPriority priority,
                i0.Value<bool> completed = const i0.Value.absent(),
                i0.Value<String?> description = const i0.Value.absent(),
              }) => i3.TasksCompanion.insert(
                id: id,
                title: title,
                priority: priority,
                completed: completed,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $TasksProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i3.Tasks,
      i1.Task,
      i3.$TasksFilterComposer,
      i3.$TasksOrderingComposer,
      i3.$TasksAnnotationComposer,
      $TasksCreateCompanionBuilder,
      $TasksUpdateCompanionBuilder,
      (i1.Task, i0.BaseReferences<i0.GeneratedDatabase, i3.Tasks, i1.Task>),
      i1.Task,
      i0.PrefetchHooks Function()
    >;

class Tasks extends i0.Table with i0.TableInfo<Tasks, i1.Task> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Tasks(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  static const i0.VerificationMeta _titleMeta = const i0.VerificationMeta(
    'title',
  );
  late final i0.GeneratedColumn<String> title = i0.GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final i0.GeneratedColumnWithTypeConverter<i2.TaskPriority, String>
  priority = i0.GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  ).withConverter<i2.TaskPriority>(i3.Tasks.$converterpriority);
  static const i0.VerificationMeta _completedMeta = const i0.VerificationMeta(
    'completed',
  );
  late final i0.GeneratedColumn<bool> completed = i0.GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: i0.DriftSqlType.bool,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT FALSE',
    defaultValue: const i0.CustomExpression('FALSE'),
  );
  static const i0.VerificationMeta _descriptionMeta = const i0.VerificationMeta(
    'description',
  );
  late final i0.GeneratedColumn<String> description =
      i0.GeneratedColumn<String>(
        'description',
        aliasedName,
        true,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: false,
        $customConstraints: '',
      );
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    title,
    priority,
    completed,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.Task> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Task(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      priority: i3.Tasks.$converterpriority.fromSql(
        attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string,
          data['${effectivePrefix}priority'],
        )!,
      ),
      completed: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      description: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  Tasks createAlias(String alias) {
    return Tasks(attachedDatabase, alias);
  }

  static i0.TypeConverter<i2.TaskPriority, String> $converterpriority =
      const i4.TaskPriorityConverter();
  @override
  bool get dontWriteConstraints => true;
}

class TasksCompanion extends i0.UpdateCompanion<i1.Task> {
  final i0.Value<int> id;
  final i0.Value<String> title;
  final i0.Value<i2.TaskPriority> priority;
  final i0.Value<bool> completed;
  final i0.Value<String?> description;
  const TasksCompanion({
    this.id = const i0.Value.absent(),
    this.title = const i0.Value.absent(),
    this.priority = const i0.Value.absent(),
    this.completed = const i0.Value.absent(),
    this.description = const i0.Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const i0.Value.absent(),
    required String title,
    required i2.TaskPriority priority,
    this.completed = const i0.Value.absent(),
    this.description = const i0.Value.absent(),
  }) : title = i0.Value(title),
       priority = i0.Value(priority);
  static i0.Insertable<i1.Task> custom({
    i0.Expression<int>? id,
    i0.Expression<String>? title,
    i0.Expression<String>? priority,
    i0.Expression<bool>? completed,
    i0.Expression<String>? description,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (priority != null) 'priority': priority,
      if (completed != null) 'completed': completed,
      if (description != null) 'description': description,
    });
  }

  i3.TasksCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<String>? title,
    i0.Value<i2.TaskPriority>? priority,
    i0.Value<bool>? completed,
    i0.Value<String?>? description,
  }) {
    return i3.TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      priority: priority ?? this.priority,
      completed: completed ?? this.completed,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = i0.Variable<String>(title.value);
    }
    if (priority.present) {
      map['priority'] = i0.Variable<String>(
        i3.Tasks.$converterpriority.toSql(priority.value),
      );
    }
    if (completed.present) {
      map['completed'] = i0.Variable<bool>(completed.value);
    }
    if (description.present) {
      map['description'] = i0.Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('priority: $priority, ')
          ..write('completed: $completed, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class TasksDrift extends i5.ModularAccessor {
  TasksDrift(i0.GeneratedDatabase db) : super(db);
  Future<int> createTask({
    required String title,
    required i2.TaskPriority priority,
    String? description,
  }) {
    return customInsert(
      'INSERT INTO tasks (title, priority, description) VALUES (?1, ?2, ?3)',
      variables: [
        i0.Variable<String>(title),
        i0.Variable<String>(i3.Tasks.$converterpriority.toSql(priority)),
        i0.Variable<String>(description),
      ],
      updates: {tasks},
    );
  }

  i0.Selectable<i1.Task> getTaskById({required int id}) {
    return customSelect(
      'SELECT * FROM tasks WHERE id = ?1',
      variables: [i0.Variable<int>(id)],
      readsFrom: {tasks},
    ).asyncMap(tasks.mapFromRow);
  }

  i3.Tasks get tasks =>
      i5.ReadDatabaseContainer(attachedDatabase).resultSet<i3.Tasks>('tasks');
}
