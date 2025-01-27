// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'brick_gen_options.dart';

class BrickGenOptionsMapper extends ClassMapperBase<BrickGenOptions> {
  BrickGenOptionsMapper._();

  static BrickGenOptionsMapper? _instance;
  static BrickGenOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BrickGenOptionsMapper._());
      ReplacementMapper.ensureInitialized();
      LinesDeletionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BrickGenOptions';

  static List<Replacement> _$replacements(BrickGenOptions v) => v.replacements;
  static const Field<BrickGenOptions, List<Replacement>> _f$replacements =
      Field('replacements', _$replacements, opt: true, def: const []);
  static List<LinesDeletion> _$lineDeletions(BrickGenOptions v) =>
      v.lineDeletions;
  static const Field<BrickGenOptions, List<LinesDeletion>> _f$lineDeletions =
      Field('lineDeletions', _$lineDeletions, opt: true, def: const []);

  @override
  final MappableFields<BrickGenOptions> fields = const {
    #replacements: _f$replacements,
    #lineDeletions: _f$lineDeletions,
  };

  static BrickGenOptions _instantiate(DecodingData data) {
    return BrickGenOptions(
        replacements: data.dec(_f$replacements),
        lineDeletions: data.dec(_f$lineDeletions));
  }

  @override
  final Function instantiate = _instantiate;

  static BrickGenOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BrickGenOptions>(map);
  }

  static BrickGenOptions fromJson(String json) {
    return ensureInitialized().decodeJson<BrickGenOptions>(json);
  }
}

mixin BrickGenOptionsMappable {
  String toJson() {
    return BrickGenOptionsMapper.ensureInitialized()
        .encodeJson<BrickGenOptions>(this as BrickGenOptions);
  }

  Map<String, dynamic> toMap() {
    return BrickGenOptionsMapper.ensureInitialized()
        .encodeMap<BrickGenOptions>(this as BrickGenOptions);
  }

  BrickGenOptionsCopyWith<BrickGenOptions, BrickGenOptions, BrickGenOptions>
      get copyWith => _BrickGenOptionsCopyWithImpl(
          this as BrickGenOptions, $identity, $identity);
  @override
  String toString() {
    return BrickGenOptionsMapper.ensureInitialized()
        .stringifyValue(this as BrickGenOptions);
  }

  @override
  bool operator ==(Object other) {
    return BrickGenOptionsMapper.ensureInitialized()
        .equalsValue(this as BrickGenOptions, other);
  }

  @override
  int get hashCode {
    return BrickGenOptionsMapper.ensureInitialized()
        .hashValue(this as BrickGenOptions);
  }
}

extension BrickGenOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BrickGenOptions, $Out> {
  BrickGenOptionsCopyWith<$R, BrickGenOptions, $Out> get $asBrickGenOptions =>
      $base.as((v, t, t2) => _BrickGenOptionsCopyWithImpl(v, t, t2));
}

abstract class BrickGenOptionsCopyWith<$R, $In extends BrickGenOptions, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Replacement,
      ReplacementCopyWith<$R, Replacement, Replacement>> get replacements;
  ListCopyWith<$R, LinesDeletion,
          LinesDeletionCopyWith<$R, LinesDeletion, LinesDeletion>>
      get lineDeletions;
  $R call(
      {List<Replacement>? replacements, List<LinesDeletion>? lineDeletions});
  BrickGenOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BrickGenOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BrickGenOptions, $Out>
    implements BrickGenOptionsCopyWith<$R, BrickGenOptions, $Out> {
  _BrickGenOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BrickGenOptions> $mapper =
      BrickGenOptionsMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Replacement,
          ReplacementCopyWith<$R, Replacement, Replacement>>
      get replacements => ListCopyWith($value.replacements,
          (v, t) => v.copyWith.$chain(t), (v) => call(replacements: v));
  @override
  ListCopyWith<$R, LinesDeletion,
          LinesDeletionCopyWith<$R, LinesDeletion, LinesDeletion>>
      get lineDeletions => ListCopyWith($value.lineDeletions,
          (v, t) => v.copyWith.$chain(t), (v) => call(lineDeletions: v));
  @override
  $R call(
          {List<Replacement>? replacements,
          List<LinesDeletion>? lineDeletions}) =>
      $apply(FieldCopyWithData({
        if (replacements != null) #replacements: replacements,
        if (lineDeletions != null) #lineDeletions: lineDeletions
      }));
  @override
  BrickGenOptions $make(CopyWithData data) => BrickGenOptions(
      replacements: data.get(#replacements, or: $value.replacements),
      lineDeletions: data.get(#lineDeletions, or: $value.lineDeletions));

  @override
  BrickGenOptionsCopyWith<$R2, BrickGenOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BrickGenOptionsCopyWithImpl($value, $cast, t);
}
