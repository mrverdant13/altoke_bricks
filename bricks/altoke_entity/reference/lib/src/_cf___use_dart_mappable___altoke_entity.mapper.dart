// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '_cf___use_dart_mappable___altoke_entity.dart';

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
  @override
  String toString() {
    return DmAltokeEntityMapper.ensureInitialized()
        .stringifyValue(this as DmAltokeEntity);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DmAltokeEntityMapper.ensureInitialized()
                .isValueEqual(this as DmAltokeEntity, other));
  }

  @override
  int get hashCode {
    return DmAltokeEntityMapper.ensureInitialized()
        .hashValue(this as DmAltokeEntity);
  }
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
  @override
  String toString() {
    return DmNewAltokeEntityMapper.ensureInitialized()
        .stringifyValue(this as DmNewAltokeEntity);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DmNewAltokeEntityMapper.ensureInitialized()
                .isValueEqual(this as DmNewAltokeEntity, other));
  }

  @override
  int get hashCode {
    return DmNewAltokeEntityMapper.ensureInitialized()
        .hashValue(this as DmNewAltokeEntity);
  }
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
  @override
  String toString() {
    return DmPartialAltokeEntityMapper.ensureInitialized()
        .stringifyValue(this as DmPartialAltokeEntity);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DmPartialAltokeEntityMapper.ensureInitialized()
                .isValueEqual(this as DmPartialAltokeEntity, other));
  }

  @override
  int get hashCode {
    return DmPartialAltokeEntityMapper.ensureInitialized()
        .hashValue(this as DmPartialAltokeEntity);
  }
}
