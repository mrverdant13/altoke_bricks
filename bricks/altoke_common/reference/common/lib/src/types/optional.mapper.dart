// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'optional.dart';

class DmOptionalMapper extends ClassMapperBase<DmOptional> {
  DmOptionalMapper._();

  static DmOptionalMapper? _instance;
  static DmOptionalMapper ensureInitialized() {
    if (_instance == null) {
      MapperBase.addType<Object>();
      MapperContainer.globals.use(_instance = DmOptionalMapper._());
      DmSomeMapper.ensureInitialized();
      DmNoneMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DmOptional';
  @override
  Function get typeFactory => <T extends Object?>(f) => f<DmOptional<T>>();

  @override
  final MappableFields<DmOptional> fields = const {};

  static DmOptional<T> _instantiate<T extends Object?>(DecodingData data) {
    throw MapperException.missingConstructor('DmOptional');
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DmOptionalMappable<T extends Object?> {}

class DmSomeMapper extends ClassMapperBase<DmSome> {
  DmSomeMapper._();

  static DmSomeMapper? _instance;
  static DmSomeMapper ensureInitialized() {
    if (_instance == null) {
      MapperBase.addType<Object>();
      MapperContainer.globals.use(_instance = DmSomeMapper._());
      DmOptionalMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DmSome';
  @override
  Function get typeFactory => <T extends Object?>(f) => f<DmSome<T>>();

  static Object? _$value(DmSome v) => v.value;
  static dynamic _arg$value<T extends Object?>(f) => f<T>();
  static const Field<DmSome, Object> _f$value = Field(
    'value',
    _$value,
    arg: _arg$value,
  );

  @override
  final MappableFields<DmSome> fields = const {#value: _f$value};

  static DmSome<T> _instantiate<T extends Object?>(DecodingData data) {
    return DmSome(data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DmSomeMappable<T extends Object?> {
  @override
  String toString() {
    return DmSomeMapper.ensureInitialized().stringifyValue(this as DmSome<T>);
  }
}

class DmNoneMapper extends ClassMapperBase<DmNone> {
  DmNoneMapper._();

  static DmNoneMapper? _instance;
  static DmNoneMapper ensureInitialized() {
    if (_instance == null) {
      MapperBase.addType<Object>();
      MapperContainer.globals.use(_instance = DmNoneMapper._());
      DmOptionalMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DmNone';
  @override
  Function get typeFactory => <T extends Object?>(f) => f<DmNone<T>>();

  @override
  final MappableFields<DmNone> fields = const {};

  static DmNone<T> _instantiate<T extends Object?>(DecodingData data) {
    return DmNone();
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DmNoneMappable<T extends Object?> {
  @override
  String toString() {
    return DmNoneMapper.ensureInitialized().stringifyValue(this as DmNone<T>);
  }
}
