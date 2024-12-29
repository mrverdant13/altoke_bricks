// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'altoke_entity.dart';

class DmAltokeEntityMapper extends ClassMapperBase<DmAltokeEntity> {
  DmAltokeEntityMapper._();

  static DmAltokeEntityMapper? _instance;
  static DmAltokeEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DmAltokeEntityMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DmAltokeEntity';

  static int _$id(DmAltokeEntity v) => v.id;
  static const Field<DmAltokeEntity, int> _f$id = Field('id', _$id);
  static String _$name(DmAltokeEntity v) => v.name;
  static const Field<DmAltokeEntity, String> _f$name = Field('name', _$name);
  static String? _$description(DmAltokeEntity v) => v.description;
  static const Field<DmAltokeEntity, String> _f$description =
      Field('description', _$description, opt: true);

  @override
  final MappableFields<DmAltokeEntity> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
  };

  static DmAltokeEntity _instantiate(DecodingData data) {
    return DmAltokeEntity(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DmAltokeEntityMappable {
  DmAltokeEntityCopyWith<DmAltokeEntity, DmAltokeEntity, DmAltokeEntity>
      get copyWith => _DmAltokeEntityCopyWithImpl(
          this as DmAltokeEntity, $identity, $identity);
  @override
  String toString() {
    return DmAltokeEntityMapper.ensureInitialized()
        .stringifyValue(this as DmAltokeEntity);
  }

  @override
  bool operator ==(Object other) {
    return DmAltokeEntityMapper.ensureInitialized()
        .equalsValue(this as DmAltokeEntity, other);
  }

  @override
  int get hashCode {
    return DmAltokeEntityMapper.ensureInitialized()
        .hashValue(this as DmAltokeEntity);
  }
}

extension DmAltokeEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DmAltokeEntity, $Out> {
  DmAltokeEntityCopyWith<$R, DmAltokeEntity, $Out> get $asDmAltokeEntity =>
      $base.as((v, t, t2) => _DmAltokeEntityCopyWithImpl(v, t, t2));
}

abstract class DmAltokeEntityCopyWith<$R, $In extends DmAltokeEntity, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? id, String? name, String? description});
  DmAltokeEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DmAltokeEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DmAltokeEntity, $Out>
    implements DmAltokeEntityCopyWith<$R, DmAltokeEntity, $Out> {
  _DmAltokeEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DmAltokeEntity> $mapper =
      DmAltokeEntityMapper.ensureInitialized();
  @override
  $R call({int? id, String? name, Object? description = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (description != $none) #description: description
      }));
  @override
  DmAltokeEntity $make(CopyWithData data) => DmAltokeEntity(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description));

  @override
  DmAltokeEntityCopyWith<$R2, DmAltokeEntity, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DmAltokeEntityCopyWithImpl($value, $cast, t);
}

class DmNewAltokeEntityMapper extends ClassMapperBase<DmNewAltokeEntity> {
  DmNewAltokeEntityMapper._();

  static DmNewAltokeEntityMapper? _instance;
  static DmNewAltokeEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DmNewAltokeEntityMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DmNewAltokeEntity';

  static String _$name(DmNewAltokeEntity v) => v.name;
  static const Field<DmNewAltokeEntity, String> _f$name = Field('name', _$name);
  static String? _$description(DmNewAltokeEntity v) => v.description;
  static const Field<DmNewAltokeEntity, String> _f$description =
      Field('description', _$description, opt: true);

  @override
  final MappableFields<DmNewAltokeEntity> fields = const {
    #name: _f$name,
    #description: _f$description,
  };

  static DmNewAltokeEntity _instantiate(DecodingData data) {
    return DmNewAltokeEntity(
        name: data.dec(_f$name), description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DmNewAltokeEntityMappable {
  DmNewAltokeEntityCopyWith<DmNewAltokeEntity, DmNewAltokeEntity,
          DmNewAltokeEntity>
      get copyWith => _DmNewAltokeEntityCopyWithImpl(
          this as DmNewAltokeEntity, $identity, $identity);
  @override
  String toString() {
    return DmNewAltokeEntityMapper.ensureInitialized()
        .stringifyValue(this as DmNewAltokeEntity);
  }

  @override
  bool operator ==(Object other) {
    return DmNewAltokeEntityMapper.ensureInitialized()
        .equalsValue(this as DmNewAltokeEntity, other);
  }

  @override
  int get hashCode {
    return DmNewAltokeEntityMapper.ensureInitialized()
        .hashValue(this as DmNewAltokeEntity);
  }
}

extension DmNewAltokeEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DmNewAltokeEntity, $Out> {
  DmNewAltokeEntityCopyWith<$R, DmNewAltokeEntity, $Out>
      get $asDmNewAltokeEntity =>
          $base.as((v, t, t2) => _DmNewAltokeEntityCopyWithImpl(v, t, t2));
}

abstract class DmNewAltokeEntityCopyWith<$R, $In extends DmNewAltokeEntity,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? description});
  DmNewAltokeEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DmNewAltokeEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DmNewAltokeEntity, $Out>
    implements DmNewAltokeEntityCopyWith<$R, DmNewAltokeEntity, $Out> {
  _DmNewAltokeEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DmNewAltokeEntity> $mapper =
      DmNewAltokeEntityMapper.ensureInitialized();
  @override
  $R call({String? name, Object? description = $none}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (description != $none) #description: description
      }));
  @override
  DmNewAltokeEntity $make(CopyWithData data) => DmNewAltokeEntity(
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description));

  @override
  DmNewAltokeEntityCopyWith<$R2, DmNewAltokeEntity, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DmNewAltokeEntityCopyWithImpl($value, $cast, t);
}

class DmPartialAltokeEntityMapper
    extends ClassMapperBase<DmPartialAltokeEntity> {
  DmPartialAltokeEntityMapper._();

  static DmPartialAltokeEntityMapper? _instance;
  static DmPartialAltokeEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DmPartialAltokeEntityMapper._());
      DmOptionalMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DmPartialAltokeEntity';

  static DmOptional<String> _$name(DmPartialAltokeEntity v) => v.name;
  static const Field<DmPartialAltokeEntity, DmOptional<String>> _f$name =
      Field('name', _$name, opt: true, def: const DmOptional.none());
  static DmOptional<String?> _$description(DmPartialAltokeEntity v) =>
      v.description;
  static const Field<DmPartialAltokeEntity, DmOptional<String?>>
      _f$description = Field('description', _$description,
          opt: true, def: const DmOptional.none());

  @override
  final MappableFields<DmPartialAltokeEntity> fields = const {
    #name: _f$name,
    #description: _f$description,
  };

  static DmPartialAltokeEntity _instantiate(DecodingData data) {
    return DmPartialAltokeEntity(
        name: data.dec(_f$name), description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DmPartialAltokeEntityMappable {
  DmPartialAltokeEntityCopyWith<DmPartialAltokeEntity, DmPartialAltokeEntity,
          DmPartialAltokeEntity>
      get copyWith => _DmPartialAltokeEntityCopyWithImpl(
          this as DmPartialAltokeEntity, $identity, $identity);
  @override
  String toString() {
    return DmPartialAltokeEntityMapper.ensureInitialized()
        .stringifyValue(this as DmPartialAltokeEntity);
  }

  @override
  bool operator ==(Object other) {
    return DmPartialAltokeEntityMapper.ensureInitialized()
        .equalsValue(this as DmPartialAltokeEntity, other);
  }

  @override
  int get hashCode {
    return DmPartialAltokeEntityMapper.ensureInitialized()
        .hashValue(this as DmPartialAltokeEntity);
  }
}

extension DmPartialAltokeEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DmPartialAltokeEntity, $Out> {
  DmPartialAltokeEntityCopyWith<$R, DmPartialAltokeEntity, $Out>
      get $asDmPartialAltokeEntity =>
          $base.as((v, t, t2) => _DmPartialAltokeEntityCopyWithImpl(v, t, t2));
}

abstract class DmPartialAltokeEntityCopyWith<
    $R,
    $In extends DmPartialAltokeEntity,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({DmOptional<String>? name, DmOptional<String?>? description});
  DmPartialAltokeEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DmPartialAltokeEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DmPartialAltokeEntity, $Out>
    implements DmPartialAltokeEntityCopyWith<$R, DmPartialAltokeEntity, $Out> {
  _DmPartialAltokeEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DmPartialAltokeEntity> $mapper =
      DmPartialAltokeEntityMapper.ensureInitialized();
  @override
  $R call({DmOptional<String>? name, DmOptional<String?>? description}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (description != null) #description: description
      }));
  @override
  DmPartialAltokeEntity $make(CopyWithData data) => DmPartialAltokeEntity(
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description));

  @override
  DmPartialAltokeEntityCopyWith<$R2, DmPartialAltokeEntity, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DmPartialAltokeEntityCopyWithImpl($value, $cast, t);
}
