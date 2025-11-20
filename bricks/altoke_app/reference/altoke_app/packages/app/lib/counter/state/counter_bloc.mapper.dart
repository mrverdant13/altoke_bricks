// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'counter_bloc.dart';

class CounterIncreaseRequestedMapper
    extends ClassMapperBase<CounterIncreaseRequested> {
  CounterIncreaseRequestedMapper._();

  static CounterIncreaseRequestedMapper? _instance;
  static CounterIncreaseRequestedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = CounterIncreaseRequestedMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'CounterIncreaseRequested';

  @override
  final MappableFields<CounterIncreaseRequested> fields = const {};

  static CounterIncreaseRequested _instantiate(DecodingData data) {
    return CounterIncreaseRequested();
  }

  @override
  final Function instantiate = _instantiate;

  static CounterIncreaseRequested fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CounterIncreaseRequested>(map);
  }

  static CounterIncreaseRequested fromJson(String json) {
    return ensureInitialized().decodeJson<CounterIncreaseRequested>(json);
  }
}

mixin CounterIncreaseRequestedMappable {
  String toJson() {
    return CounterIncreaseRequestedMapper.ensureInitialized()
        .encodeJson<CounterIncreaseRequested>(this as CounterIncreaseRequested);
  }

  Map<String, dynamic> toMap() {
    return CounterIncreaseRequestedMapper.ensureInitialized()
        .encodeMap<CounterIncreaseRequested>(this as CounterIncreaseRequested);
  }

  CounterIncreaseRequestedCopyWith<
    CounterIncreaseRequested,
    CounterIncreaseRequested,
    CounterIncreaseRequested
  >
  get copyWith =>
      _CounterIncreaseRequestedCopyWithImpl<
        CounterIncreaseRequested,
        CounterIncreaseRequested
      >(this as CounterIncreaseRequested, $identity, $identity);
  @override
  String toString() {
    return CounterIncreaseRequestedMapper.ensureInitialized().stringifyValue(
      this as CounterIncreaseRequested,
    );
  }

  @override
  bool operator ==(Object other) {
    return CounterIncreaseRequestedMapper.ensureInitialized().equalsValue(
      this as CounterIncreaseRequested,
      other,
    );
  }

  @override
  int get hashCode {
    return CounterIncreaseRequestedMapper.ensureInitialized().hashValue(
      this as CounterIncreaseRequested,
    );
  }
}

extension CounterIncreaseRequestedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CounterIncreaseRequested, $Out> {
  CounterIncreaseRequestedCopyWith<$R, CounterIncreaseRequested, $Out>
  get $asCounterIncreaseRequested => $base.as(
    (v, t, t2) => _CounterIncreaseRequestedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CounterIncreaseRequestedCopyWith<
  $R,
  $In extends CounterIncreaseRequested,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  CounterIncreaseRequestedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CounterIncreaseRequestedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CounterIncreaseRequested, $Out>
    implements
        CounterIncreaseRequestedCopyWith<$R, CounterIncreaseRequested, $Out> {
  _CounterIncreaseRequestedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CounterIncreaseRequested> $mapper =
      CounterIncreaseRequestedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  CounterIncreaseRequested $make(CopyWithData data) =>
      CounterIncreaseRequested();

  @override
  CounterIncreaseRequestedCopyWith<$R2, CounterIncreaseRequested, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CounterIncreaseRequestedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CounterResetRequestedMapper
    extends ClassMapperBase<CounterResetRequested> {
  CounterResetRequestedMapper._();

  static CounterResetRequestedMapper? _instance;
  static CounterResetRequestedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CounterResetRequestedMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CounterResetRequested';

  @override
  final MappableFields<CounterResetRequested> fields = const {};

  static CounterResetRequested _instantiate(DecodingData data) {
    return CounterResetRequested();
  }

  @override
  final Function instantiate = _instantiate;

  static CounterResetRequested fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CounterResetRequested>(map);
  }

  static CounterResetRequested fromJson(String json) {
    return ensureInitialized().decodeJson<CounterResetRequested>(json);
  }
}

mixin CounterResetRequestedMappable {
  String toJson() {
    return CounterResetRequestedMapper.ensureInitialized()
        .encodeJson<CounterResetRequested>(this as CounterResetRequested);
  }

  Map<String, dynamic> toMap() {
    return CounterResetRequestedMapper.ensureInitialized()
        .encodeMap<CounterResetRequested>(this as CounterResetRequested);
  }

  CounterResetRequestedCopyWith<
    CounterResetRequested,
    CounterResetRequested,
    CounterResetRequested
  >
  get copyWith =>
      _CounterResetRequestedCopyWithImpl<
        CounterResetRequested,
        CounterResetRequested
      >(this as CounterResetRequested, $identity, $identity);
  @override
  String toString() {
    return CounterResetRequestedMapper.ensureInitialized().stringifyValue(
      this as CounterResetRequested,
    );
  }

  @override
  bool operator ==(Object other) {
    return CounterResetRequestedMapper.ensureInitialized().equalsValue(
      this as CounterResetRequested,
      other,
    );
  }

  @override
  int get hashCode {
    return CounterResetRequestedMapper.ensureInitialized().hashValue(
      this as CounterResetRequested,
    );
  }
}

extension CounterResetRequestedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CounterResetRequested, $Out> {
  CounterResetRequestedCopyWith<$R, CounterResetRequested, $Out>
  get $asCounterResetRequested => $base.as(
    (v, t, t2) => _CounterResetRequestedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CounterResetRequestedCopyWith<
  $R,
  $In extends CounterResetRequested,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  CounterResetRequestedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CounterResetRequestedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CounterResetRequested, $Out>
    implements CounterResetRequestedCopyWith<$R, CounterResetRequested, $Out> {
  _CounterResetRequestedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CounterResetRequested> $mapper =
      CounterResetRequestedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  CounterResetRequested $make(CopyWithData data) => CounterResetRequested();

  @override
  CounterResetRequestedCopyWith<$R2, CounterResetRequested, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CounterResetRequestedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

