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

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RealmAltokeEntity._);
    return const SchemaObject(
        ObjectType.realmObject, RealmAltokeEntity, 'RealmAltokeEntity', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
    ]);
  }
}
