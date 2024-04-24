// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_{{object.snakeCase()}}.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Realm{{object.pascalCase()}} extends _Realm{{object.pascalCase()}}
    with RealmEntity, RealmObjectBase, RealmObject {
  Realm{{object.pascalCase()}}(
    int id,
    String name, {
    String? description,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'description', description);
  }

  Realm{{object.pascalCase()}}._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  Stream<RealmObjectChanges<Realm{{object.pascalCase()}}>> get changes =>
      RealmObjectBase.getChanges<Realm{{object.pascalCase()}}>(this);

  @override
  Realm{{object.pascalCase()}} freeze() =>
      RealmObjectBase.freezeObject<Realm{{object.pascalCase()}}>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'description': description.toEJson(),
    };
  }

  static EJsonValue _toEJson(Realm{{object.pascalCase()}} value) => value.toEJson();
  static Realm{{object.pascalCase()}} _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'description': EJsonValue description,
      } =>
        Realm{{object.pascalCase()}}(
          fromEJson(id),
          fromEJson(name),
          description: fromEJson(description),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Realm{{object.pascalCase()}}._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, Realm{{object.pascalCase()}}, 'Realm{{object.pascalCase()}}', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
