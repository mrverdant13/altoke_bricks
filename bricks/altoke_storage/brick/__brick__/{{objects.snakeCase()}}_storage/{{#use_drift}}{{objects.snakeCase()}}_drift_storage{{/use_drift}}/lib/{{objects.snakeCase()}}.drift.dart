// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:{{objects.snakeCase()}}_drift_storage/{{objects.snakeCase()}}.drift.dart' as i1;
import 'package:drift/internal/modular.dart' as i2;

class {{objects.pascalCase()}} extends i0.Table
    with i0.TableInfo<{{objects.pascalCase()}}, i1.{{object.pascalCase()}}> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  {{objects.pascalCase()}}(this.attachedDatabase, [this._alias]);
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
  static const String $name = '{{objects.snakeCase()}}';
  @override
  i0.VerificationContext validateIntegrity(
      i0.Insertable<i1.{{object.pascalCase()}}> instance,
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
  i1.{{object.pascalCase()}} map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.{{object.pascalCase()}}(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  {{objects.pascalCase()}} createAlias(String alias) {
    return {{objects.pascalCase()}}(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class {{object.pascalCase()}} extends i0.DataClass
    implements i0.Insertable<i1.{{object.pascalCase()}}> {
  final int id;
  final String name;
  final String? description;
  const {{object.pascalCase()}}({required this.id, required this.name, this.description});
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

  i1.{{objects.pascalCase()}}Companion toCompanion(bool nullToAbsent) {
    return i1.{{objects.pascalCase()}}Companion(
      id: i0.Value(id),
      name: i0.Value(name),
      description: description == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(description),
    );
  }

  factory {{object.pascalCase()}}.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return {{object.pascalCase()}}(
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

  i1.{{object.pascalCase()}} copyWith(
          {int? id,
          String? name,
          i0.Value<String?> description = const i0.Value.absent()}) =>
      i1.{{object.pascalCase()}}(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('{{object.pascalCase()}}(')
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
      (other is i1.{{object.pascalCase()}} &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description);
}

class {{objects.pascalCase()}}Companion extends i0.UpdateCompanion<i1.{{object.pascalCase()}}> {
  final i0.Value<int> id;
  final i0.Value<String> name;
  final i0.Value<String?> description;
  const {{objects.pascalCase()}}Companion({
    this.id = const i0.Value.absent(),
    this.name = const i0.Value.absent(),
    this.description = const i0.Value.absent(),
  });
  {{objects.pascalCase()}}Companion.insert({
    this.id = const i0.Value.absent(),
    required String name,
    this.description = const i0.Value.absent(),
  }) : name = i0.Value(name);
  static i0.Insertable<i1.{{object.pascalCase()}}> custom({
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

  i1.{{objects.pascalCase()}}Companion copyWith(
      {i0.Value<int>? id,
      i0.Value<String>? name,
      i0.Value<String?>? description}) {
    return i1.{{objects.pascalCase()}}Companion(
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
    return (StringBuffer('{{objects.pascalCase()}}Companion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class {{objects.pascalCase()}}Drift extends i2.ModularAccessor {
  {{objects.pascalCase()}}Drift(i0.GeneratedDatabase db) : super(db);
  Future<int> add(String name, String? description) {
    return customInsert(
      'INSERT INTO {{objects.snakeCase()}} (name, description) VALUES (?1, ?2)',
      variables: [i0.Variable<String>(name), i0.Variable<String>(description)],
      updates: {{{objects.camelCase()}}},
    );
  }

  Future<int> deleteById(int id) {
    return customUpdate(
      'DELETE FROM {{objects.snakeCase()}} WHERE id = ?1',
      variables: [i0.Variable<int>(id)],
      updates: {{{objects.camelCase()}}},
      updateKind: i0.UpdateKind.delete,
    );
  }

  Future<int> insert(int id, String name, String? description) {
    return customInsert(
      'INSERT INTO {{objects.snakeCase()}} (id, name, description) VALUES (?1, ?2, ?3)',
      variables: [
        i0.Variable<int>(id),
        i0.Variable<String>(name),
        i0.Variable<String>(description)
      ],
      updates: {{{objects.camelCase()}}},
    );
  }

  i0.Selectable<i1.{{object.pascalCase()}}> getById(int id) {
    return customSelect('SELECT * FROM {{objects.snakeCase()}} WHERE id = ?1',
        variables: [
          i0.Variable<int>(id)
        ],
        readsFrom: {
          {{objects.camelCase()}},
        }).asyncMap({{objects.camelCase()}}.mapFromRow);
  }

  i1.{{objects.pascalCase()}} get {{objects.camelCase()}} =>
      this.resultSet<i1.{{objects.pascalCase()}}>('{{objects.snakeCase()}}');
}
