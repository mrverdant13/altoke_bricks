// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'replacement.dart';

class ReplacementMapper extends ClassMapperBase<Replacement> {
  ReplacementMapper._();

  static ReplacementMapper? _instance;
  static ReplacementMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReplacementMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Replacement';

  static RegExp _$from(Replacement v) => v.from;
  static const Field<Replacement, RegExp> _f$from =
      Field('from', _$from, hook: regexHook);
  static String _$to(Replacement v) => v.to;
  static const Field<Replacement, String> _f$to = Field('to', _$to);

  @override
  final MappableFields<Replacement> fields = const {
    #from: _f$from,
    #to: _f$to,
  };

  static Replacement _instantiate(DecodingData data) {
    return Replacement(from: data.dec(_f$from), to: data.dec(_f$to));
  }

  @override
  final Function instantiate = _instantiate;

  static Replacement fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Replacement>(map);
  }

  static Replacement fromJson(String json) {
    return ensureInitialized().decodeJson<Replacement>(json);
  }
}

mixin ReplacementMappable {
  String toJson() {
    return ReplacementMapper.ensureInitialized()
        .encodeJson<Replacement>(this as Replacement);
  }

  Map<String, dynamic> toMap() {
    return ReplacementMapper.ensureInitialized()
        .encodeMap<Replacement>(this as Replacement);
  }

  ReplacementCopyWith<Replacement, Replacement, Replacement> get copyWith =>
      _ReplacementCopyWithImpl(this as Replacement, $identity, $identity);
  @override
  String toString() {
    return ReplacementMapper.ensureInitialized()
        .stringifyValue(this as Replacement);
  }

  @override
  bool operator ==(Object other) {
    return ReplacementMapper.ensureInitialized()
        .equalsValue(this as Replacement, other);
  }

  @override
  int get hashCode {
    return ReplacementMapper.ensureInitialized().hashValue(this as Replacement);
  }
}

extension ReplacementValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Replacement, $Out> {
  ReplacementCopyWith<$R, Replacement, $Out> get $asReplacement =>
      $base.as((v, t, t2) => _ReplacementCopyWithImpl(v, t, t2));
}

abstract class ReplacementCopyWith<$R, $In extends Replacement, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({RegExp? from, String? to});
  ReplacementCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ReplacementCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Replacement, $Out>
    implements ReplacementCopyWith<$R, Replacement, $Out> {
  _ReplacementCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Replacement> $mapper =
      ReplacementMapper.ensureInitialized();
  @override
  $R call({RegExp? from, String? to}) => $apply(FieldCopyWithData(
      {if (from != null) #from: from, if (to != null) #to: to}));
  @override
  Replacement $make(CopyWithData data) => Replacement(
      from: data.get(#from, or: $value.from), to: data.get(#to, or: $value.to));

  @override
  ReplacementCopyWith<$R2, Replacement, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ReplacementCopyWithImpl($value, $cast, t);
}
