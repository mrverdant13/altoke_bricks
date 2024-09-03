// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:altoke_entities_drift_storage/altoke_entities.drift.dart' as i1;
import 'package:drift/internal/modular.dart' as i2;

class AltokeEntities extends i0.Table
    with i0.TableInfo<AltokeEntities, i1.AltokeEntity> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  AltokeEntities(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: i0.DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const i0.VerificationMeta _nameMeta =
      const i0.VerificationMeta('name');
  late final i0.GeneratedColumn<String> name = i0.GeneratedColumn<String>(
      'name', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _descriptionMeta =
      const i0.VerificationMeta('description');
  late final i0.GeneratedColumn<String> description =
      i0.GeneratedColumn<String>('description', aliasedName, true,
          type: i0.DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  @override
  List<i0.GeneratedColumn> get $columns => [id, name, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'altoke_entities';
  @override
  i0.VerificationContext validateIntegrity(
      i0.Insertable<i1.AltokeEntity> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
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
  i1.AltokeEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.AltokeEntity(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  AltokeEntities createAlias(String alias) {
    return AltokeEntities(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class AltokeEntity extends i0.DataClass
    implements i0.Insertable<i1.AltokeEntity> {
  final int id;
  final String name;
  final String? description;
  const AltokeEntity({required this.id, required this.name, this.description});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['name'] = i0.Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = i0.Variable<String>(description);
    }
    return map;
  }

  i1.AltokeEntitiesCompanion toCompanion(bool nullToAbsent) {
    return i1.AltokeEntitiesCompanion(
      id: i0.Value(id),
      name: i0.Value(name),
      description: description == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(description),
    );
  }

  factory AltokeEntity.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return AltokeEntity(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
    };
  }

  i1.AltokeEntity copyWith(
          {int? id,
          String? name,
          i0.Value<String?> description = const i0.Value.absent()}) =>
      i1.AltokeEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
      );
  AltokeEntity copyWithCompanion(i1.AltokeEntitiesCompanion data) {
    return AltokeEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AltokeEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.AltokeEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description);
}

class AltokeEntitiesCompanion extends i0.UpdateCompanion<i1.AltokeEntity> {
  final i0.Value<int> id;
  final i0.Value<String> name;
  final i0.Value<String?> description;
  const AltokeEntitiesCompanion({
    this.id = const i0.Value.absent(),
    this.name = const i0.Value.absent(),
    this.description = const i0.Value.absent(),
  });
  AltokeEntitiesCompanion.insert({
    this.id = const i0.Value.absent(),
    required String name,
    this.description = const i0.Value.absent(),
  }) : name = i0.Value(name);
  static i0.Insertable<i1.AltokeEntity> custom({
    i0.Expression<int>? id,
    i0.Expression<String>? name,
    i0.Expression<String>? description,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    });
  }

  i1.AltokeEntitiesCompanion copyWith(
      {i0.Value<int>? id,
      i0.Value<String>? name,
      i0.Value<String?>? description}) {
    return i1.AltokeEntitiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = i0.Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = i0.Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AltokeEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

typedef $AltokeEntitiesCreateCompanionBuilder = i1.AltokeEntitiesCompanion
    Function({
  i0.Value<int> id,
  required String name,
  i0.Value<String?> description,
});
typedef $AltokeEntitiesUpdateCompanionBuilder = i1.AltokeEntitiesCompanion
    Function({
  i0.Value<int> id,
  i0.Value<String> name,
  i0.Value<String?> description,
});

class $AltokeEntitiesFilterComposer
    extends i0.FilterComposer<i0.GeneratedDatabase, i1.AltokeEntities> {
  $AltokeEntitiesFilterComposer(super.$state);
  i0.ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));
}

class $AltokeEntitiesOrderingComposer
    extends i0.OrderingComposer<i0.GeneratedDatabase, i1.AltokeEntities> {
  $AltokeEntitiesOrderingComposer(super.$state);
  i0.ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AltokeEntitiesTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.AltokeEntities,
    i1.AltokeEntity,
    i1.$AltokeEntitiesFilterComposer,
    i1.$AltokeEntitiesOrderingComposer,
    $AltokeEntitiesCreateCompanionBuilder,
    $AltokeEntitiesUpdateCompanionBuilder,
    (
      i1.AltokeEntity,
      i0
      .BaseReferences<i0.GeneratedDatabase, i1.AltokeEntities, i1.AltokeEntity>
    ),
    i1.AltokeEntity,
    i0.PrefetchHooks Function()> {
  $AltokeEntitiesTableManager(i0.GeneratedDatabase db, i1.AltokeEntities table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              i1.$AltokeEntitiesFilterComposer(i0.ComposerState(db, table)),
          orderingComposer:
              i1.$AltokeEntitiesOrderingComposer(i0.ComposerState(db, table)),
          updateCompanionCallback: ({
            i0.Value<int> id = const i0.Value.absent(),
            i0.Value<String> name = const i0.Value.absent(),
            i0.Value<String?> description = const i0.Value.absent(),
          }) =>
              i1.AltokeEntitiesCompanion(
            id: id,
            name: name,
            description: description,
          ),
          createCompanionCallback: ({
            i0.Value<int> id = const i0.Value.absent(),
            required String name,
            i0.Value<String?> description = const i0.Value.absent(),
          }) =>
              i1.AltokeEntitiesCompanion.insert(
            id: id,
            name: name,
            description: description,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $AltokeEntitiesProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.AltokeEntities,
    i1.AltokeEntity,
    i1.$AltokeEntitiesFilterComposer,
    i1.$AltokeEntitiesOrderingComposer,
    $AltokeEntitiesCreateCompanionBuilder,
    $AltokeEntitiesUpdateCompanionBuilder,
    (
      i1.AltokeEntity,
      i0
      .BaseReferences<i0.GeneratedDatabase, i1.AltokeEntities, i1.AltokeEntity>
    ),
    i1.AltokeEntity,
    i0.PrefetchHooks Function()>;

class AltokeEntitiesDrift extends i2.ModularAccessor {
  AltokeEntitiesDrift(i0.GeneratedDatabase db) : super(db);
  Future<int> add(String name, String? description) {
    return customInsert(
      'INSERT INTO altoke_entities (name, description) VALUES (?1, ?2)',
      variables: [i0.Variable<String>(name), i0.Variable<String>(description)],
      updates: {altokeEntities},
    );
  }

  Future<int> deleteById(int id) {
    return customUpdate(
      'DELETE FROM altoke_entities WHERE id = ?1',
      variables: [i0.Variable<int>(id)],
      updates: {altokeEntities},
      updateKind: i0.UpdateKind.delete,
    );
  }

  Future<int> insert(int id, String name, String? description) {
    return customInsert(
      'INSERT INTO altoke_entities (id, name, description) VALUES (?1, ?2, ?3)',
      variables: [
        i0.Variable<int>(id),
        i0.Variable<String>(name),
        i0.Variable<String>(description)
      ],
      updates: {altokeEntities},
    );
  }

  i0.Selectable<i1.AltokeEntity> getById(int id) {
    return customSelect('SELECT * FROM altoke_entities WHERE id = ?1',
        variables: [
          i0.Variable<int>(id)
        ],
        readsFrom: {
          altokeEntities,
        }).asyncMap(altokeEntities.mapFromRow);
  }

  i1.AltokeEntities get altokeEntities =>
      i2.ReadDatabaseContainer(attachedDatabase)
          .resultSet<i1.AltokeEntities>('altoke_entities');
}
