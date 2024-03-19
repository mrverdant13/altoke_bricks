// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '_cf___use_dart_mappable___optional.dart';

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

  static DmOptional<T> fromMap<T extends Object?>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DmOptional<T>>(map);
  }

  static DmOptional<T> fromJson<T extends Object?>(String json) {
    return ensureInitialized().decodeJson<DmOptional<T>>(json);
  }
}

mixin DmOptionalMappable<T extends Object?> {
  String toJson();
  Map<String, dynamic> toMap();
  DmOptionalCopyWith<DmOptional<T>, DmOptional<T>, DmOptional<T>, T>
      get copyWith;
}

abstract class DmOptionalCopyWith<$R, $In extends DmOptional<T>, $Out,
    T extends Object?> implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  DmOptionalCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

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
  static const Field<DmSome, Object?> _f$value =
      Field('value', _$value, arg: _arg$value);

  @override
  final MappableFields<DmSome> fields = const {
    #value: _f$value,
  };

  static DmSome<T> _instantiate<T extends Object?>(DecodingData data) {
    return DmSome(data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;

  static DmSome<T> fromMap<T extends Object?>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DmSome<T>>(map);
  }

  static DmSome<T> fromJson<T extends Object?>(String json) {
    return ensureInitialized().decodeJson<DmSome<T>>(json);
  }
}

mixin DmSomeMappable<T extends Object?> {
  String toJson() {
    return DmSomeMapper.ensureInitialized()
        .encodeJson<DmSome<T>>(this as DmSome<T>);
  }

  Map<String, dynamic> toMap() {
    return DmSomeMapper.ensureInitialized()
        .encodeMap<DmSome<T>>(this as DmSome<T>);
  }

  DmSomeCopyWith<DmSome<T>, DmSome<T>, DmSome<T>, T> get copyWith =>
      _DmSomeCopyWithImpl(this as DmSome<T>, $identity, $identity);
  @override
  String toString() {
    return DmSomeMapper.ensureInitialized().stringifyValue(this as DmSome<T>);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DmSomeMapper.ensureInitialized()
                .isValueEqual(this as DmSome<T>, other));
  }

  @override
  int get hashCode {
    return DmSomeMapper.ensureInitialized().hashValue(this as DmSome<T>);
  }
}

extension DmSomeValueCopy<$R, $Out, T extends Object?>
    on ObjectCopyWith<$R, DmSome<T>, $Out> {
  DmSomeCopyWith<$R, DmSome<T>, $Out, T> get $asDmSome =>
      $base.as((v, t, t2) => _DmSomeCopyWithImpl(v, t, t2));
}

abstract class DmSomeCopyWith<$R, $In extends DmSome<T>, $Out,
    T extends Object?> implements DmOptionalCopyWith<$R, $In, $Out, T> {
  @override
  $R call({T? value});
  DmSomeCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DmSomeCopyWithImpl<$R, $Out, T extends Object?>
    extends ClassCopyWithBase<$R, DmSome<T>, $Out>
    implements DmSomeCopyWith<$R, DmSome<T>, $Out, T> {
  _DmSomeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DmSome> $mapper = DmSomeMapper.ensureInitialized();
  @override
  $R call({T? value}) =>
      $apply(FieldCopyWithData({if (value != null) #value: value}));
  @override
  DmSome<T> $make(CopyWithData data) =>
      DmSome(data.get(#value, or: $value.value));

  @override
  DmSomeCopyWith<$R2, DmSome<T>, $Out2, T> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DmSomeCopyWithImpl($value, $cast, t);
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

  static DmNone<T> fromMap<T extends Object?>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DmNone<T>>(map);
  }

  static DmNone<T> fromJson<T extends Object?>(String json) {
    return ensureInitialized().decodeJson<DmNone<T>>(json);
  }
}

mixin DmNoneMappable<T extends Object?> {
  String toJson() {
    return DmNoneMapper.ensureInitialized()
        .encodeJson<DmNone<T>>(this as DmNone<T>);
  }

  Map<String, dynamic> toMap() {
    return DmNoneMapper.ensureInitialized()
        .encodeMap<DmNone<T>>(this as DmNone<T>);
  }

  DmNoneCopyWith<DmNone<T>, DmNone<T>, DmNone<T>, T> get copyWith =>
      _DmNoneCopyWithImpl(this as DmNone<T>, $identity, $identity);
  @override
  String toString() {
    return DmNoneMapper.ensureInitialized().stringifyValue(this as DmNone<T>);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DmNoneMapper.ensureInitialized()
                .isValueEqual(this as DmNone<T>, other));
  }

  @override
  int get hashCode {
    return DmNoneMapper.ensureInitialized().hashValue(this as DmNone<T>);
  }
}

extension DmNoneValueCopy<$R, $Out, T extends Object?>
    on ObjectCopyWith<$R, DmNone<T>, $Out> {
  DmNoneCopyWith<$R, DmNone<T>, $Out, T> get $asDmNone =>
      $base.as((v, t, t2) => _DmNoneCopyWithImpl(v, t, t2));
}

abstract class DmNoneCopyWith<$R, $In extends DmNone<T>, $Out,
    T extends Object?> implements DmOptionalCopyWith<$R, $In, $Out, T> {
  @override
  $R call();
  DmNoneCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DmNoneCopyWithImpl<$R, $Out, T extends Object?>
    extends ClassCopyWithBase<$R, DmNone<T>, $Out>
    implements DmNoneCopyWith<$R, DmNone<T>, $Out, T> {
  _DmNoneCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DmNone> $mapper = DmNoneMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  DmNone<T> $make(CopyWithData data) => DmNone();

  @override
  DmNoneCopyWith<$R2, DmNone<T>, $Out2, T> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DmNoneCopyWithImpl($value, $cast, t);
}
