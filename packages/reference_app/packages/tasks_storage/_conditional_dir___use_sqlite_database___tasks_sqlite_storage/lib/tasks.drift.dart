// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:tasks_sqlite_storage/tasks.drift.dart' as i1;
import 'package:drift/internal/modular.dart' as i2;

class Tasks extends i0.Table with i0.TableInfo<Tasks, i1.Task> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Tasks(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: i0.DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const i0.VerificationMeta _titleMeta =
      const i0.VerificationMeta('title');
  late final i0.GeneratedColumn<String> title = i0.GeneratedColumn<String>(
      'title', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _isCompletedMeta =
      const i0.VerificationMeta('isCompleted');
  late final i0.GeneratedColumn<bool> isCompleted = i0.GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: i0.DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT FALSE',
      defaultValue: const i0.CustomExpression('FALSE'));
  static const i0.VerificationMeta _createdAtMeta =
      const i0.VerificationMeta('createdAt');
  late final i0.GeneratedColumn<int> createdAt = i0.GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: i0.DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (STRFTIME(\'%s\', \'now\') * 1000)',
      defaultValue:
          const i0.CustomExpression('STRFTIME(\'%s\', \'now\') * 1000'));
  static const i0.VerificationMeta _descriptionMeta =
      const i0.VerificationMeta('description');
  late final i0.GeneratedColumn<String> description =
      i0.GeneratedColumn<String>('description', aliasedName, true,
          type: i0.DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  @override
  List<i0.GeneratedColumn> get $columns =>
      [id, title, isCompleted, createdAt, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.Task> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Task(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}title'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      createdAt: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      description: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  Tasks createAlias(String alias) {
    return Tasks(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Task extends i0.DataClass implements i0.Insertable<i1.Task> {
  final int id;
  final String title;
  final bool isCompleted;
  final int createdAt;
  final String? description;
  const Task(
      {required this.id,
      required this.title,
      required this.isCompleted,
      required this.createdAt,
      this.description});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['title'] = i0.Variable<String>(title);
    map['is_completed'] = i0.Variable<bool>(isCompleted);
    map['created_at'] = i0.Variable<int>(createdAt);
    if (!nullToAbsent || description != null) {
      map['description'] = i0.Variable<String>(description);
    }
    return map;
  }

  i1.TasksCompanion toCompanion(bool nullToAbsent) {
    return i1.TasksCompanion(
      id: i0.Value(id),
      title: i0.Value(title),
      isCompleted: i0.Value(isCompleted),
      createdAt: i0.Value(createdAt),
      description: description == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(description),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      isCompleted: serializer.fromJson<bool>(json['is_completed']),
      createdAt: serializer.fromJson<int>(json['created_at']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'is_completed': serializer.toJson<bool>(isCompleted),
      'created_at': serializer.toJson<int>(createdAt),
      'description': serializer.toJson<String?>(description),
    };
  }

  i1.Task copyWith(
          {int? id,
          String? title,
          bool? isCompleted,
          int? createdAt,
          i0.Value<String?> description = const i0.Value.absent()}) =>
      i1.Task(
        id: id ?? this.id,
        title: title ?? this.title,
        isCompleted: isCompleted ?? this.isCompleted,
        createdAt: createdAt ?? this.createdAt,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, isCompleted, createdAt, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.isCompleted == this.isCompleted &&
          other.createdAt == this.createdAt &&
          other.description == this.description);
}

class TasksCompanion extends i0.UpdateCompanion<i1.Task> {
  final i0.Value<int> id;
  final i0.Value<String> title;
  final i0.Value<bool> isCompleted;
  final i0.Value<int> createdAt;
  final i0.Value<String?> description;
  const TasksCompanion({
    this.id = const i0.Value.absent(),
    this.title = const i0.Value.absent(),
    this.isCompleted = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
    this.description = const i0.Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const i0.Value.absent(),
    required String title,
    this.isCompleted = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
    this.description = const i0.Value.absent(),
  }) : title = i0.Value(title);
  static i0.Insertable<i1.Task> custom({
    i0.Expression<int>? id,
    i0.Expression<String>? title,
    i0.Expression<bool>? isCompleted,
    i0.Expression<int>? createdAt,
    i0.Expression<String>? description,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (createdAt != null) 'created_at': createdAt,
      if (description != null) 'description': description,
    });
  }

  i1.TasksCompanion copyWith(
      {i0.Value<int>? id,
      i0.Value<String>? title,
      i0.Value<bool>? isCompleted,
      i0.Value<int>? createdAt,
      i0.Value<String?>? description}) {
    return i1.TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
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
    if (isCompleted.present) {
      map['is_completed'] = i0.Variable<bool>(isCompleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<int>(createdAt.value);
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
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class TasksDrift extends i2.ModularAccessor {
  TasksDrift(i0.GeneratedDatabase db) : super(db);
  Future<int> add(String title, String? description, bool isCompleted) {
    return customInsert(
      'INSERT INTO tasks (title, description, is_completed) VALUES (?1, ?2, ?3)',
      variables: [
        i0.Variable<String>(title),
        i0.Variable<String>(description),
        i0.Variable<bool>(isCompleted)
      ],
      updates: {tasks},
    );
  }

  Future<int> deleteById(int id) {
    return customUpdate(
      'DELETE FROM tasks WHERE id = ?1',
      variables: [i0.Variable<int>(id)],
      updates: {tasks},
      updateKind: i0.UpdateKind.delete,
    );
  }

  Future<int> insert(int id, String title, bool isCompleted, int createdAt,
      String? description) {
    return customInsert(
      'INSERT INTO tasks (id, title, is_completed, created_at, description) VALUES (?1, ?2, ?3, ?4, ?5)',
      variables: [
        i0.Variable<int>(id),
        i0.Variable<String>(title),
        i0.Variable<bool>(isCompleted),
        i0.Variable<int>(createdAt),
        i0.Variable<String>(description)
      ],
      updates: {tasks},
    );
  }

  Future<int> markAllAsCompleted() {
    return customUpdate(
      'UPDATE tasks SET is_completed = TRUE WHERE is_completed = FALSE',
      variables: [],
      updates: {tasks},
      updateKind: i0.UpdateKind.update,
    );
  }

  i0.Selectable<i1.Task> getById(int id) {
    return customSelect('SELECT * FROM tasks WHERE id = ?1', variables: [
      i0.Variable<int>(id)
    ], readsFrom: {
      tasks,
    }).asyncMap(tasks.mapFromRow);
  }

  i1.Tasks get tasks => this.resultSet<i1.Tasks>('tasks');
}
