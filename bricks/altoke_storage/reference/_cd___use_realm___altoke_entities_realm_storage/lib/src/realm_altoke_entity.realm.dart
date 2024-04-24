// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_altoke_entity.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RealmAltokeEntity extends _RealmAltokeEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmAltokeEntity(
    int id,
    String name, {
    String? description,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'description', description);
  }

  RealmAltokeEntity._();

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
  Stream<RealmObjectChanges<RealmAltokeEntity>> get changes =>
      RealmObjectBase.getChanges<RealmAltokeEntity>(this);

  @override
  RealmAltokeEntity freeze() =>
      RealmObjectBase.freezeObject<RealmAltokeEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'description': description.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmAltokeEntity value) => value.toEJson();
  static RealmAltokeEntity _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'description': EJsonValue description,
      } =>
        RealmAltokeEntity(
          fromEJson(id),
          fromEJson(name),
          description: fromEJson(description),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmAltokeEntity._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, RealmAltokeEntity, 'RealmAltokeEntity', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
