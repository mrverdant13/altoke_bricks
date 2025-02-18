// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'brick_gen_data.dart';

class BrickGenDataMapper extends ClassMapperBase<BrickGenData> {
  BrickGenDataMapper._();

  static BrickGenDataMapper? _instance;
  static BrickGenDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BrickGenDataMapper._());
      BrickGenOptionsMapper.ensureInitialized();
      ReplacementMapper.ensureInitialized();
      LinesDeletionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BrickGenData';

  static String _$referenceAbsolutePath(BrickGenData v) =>
      v.referenceAbsolutePath;
  static const Field<BrickGenData, String> _f$referenceAbsolutePath = Field(
    'referenceAbsolutePath',
    _$referenceAbsolutePath,
  );
  static String _$targetAbsolutePath(BrickGenData v) => v.targetAbsolutePath;
  static const Field<BrickGenData, String> _f$targetAbsolutePath = Field(
    'targetAbsolutePath',
    _$targetAbsolutePath,
  );
  static List<Replacement> _$replacements(BrickGenData v) => v.replacements;
  static const Field<BrickGenData, List<Replacement>> _f$replacements = Field(
    'replacements',
    _$replacements,
  );
  static List<LinesDeletion> _$lineDeletions(BrickGenData v) => v.lineDeletions;
  static const Field<BrickGenData, List<LinesDeletion>> _f$lineDeletions =
      Field('lineDeletions', _$lineDeletions);

  @override
  final MappableFields<BrickGenData> fields = const {
    #referenceAbsolutePath: _f$referenceAbsolutePath,
    #targetAbsolutePath: _f$targetAbsolutePath,
    #replacements: _f$replacements,
    #lineDeletions: _f$lineDeletions,
  };

  static BrickGenData _instantiate(DecodingData data) {
    return BrickGenData(
      referenceAbsolutePath: data.dec(_f$referenceAbsolutePath),
      targetAbsolutePath: data.dec(_f$targetAbsolutePath),
      replacements: data.dec(_f$replacements),
      lineDeletions: data.dec(_f$lineDeletions),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BrickGenData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BrickGenData>(map);
  }

  static BrickGenData fromJson(String json) {
    return ensureInitialized().decodeJson<BrickGenData>(json);
  }
}

mixin BrickGenDataMappable {
  String toJson() {
    return BrickGenDataMapper.ensureInitialized().encodeJson<BrickGenData>(
      this as BrickGenData,
    );
  }

  Map<String, dynamic> toMap() {
    return BrickGenDataMapper.ensureInitialized().encodeMap<BrickGenData>(
      this as BrickGenData,
    );
  }

  BrickGenDataCopyWith<BrickGenData, BrickGenData, BrickGenData> get copyWith =>
      _BrickGenDataCopyWithImpl(this as BrickGenData, $identity, $identity);
  @override
  String toString() {
    return BrickGenDataMapper.ensureInitialized().stringifyValue(
      this as BrickGenData,
    );
  }

  @override
  bool operator ==(Object other) {
    return BrickGenDataMapper.ensureInitialized().equalsValue(
      this as BrickGenData,
      other,
    );
  }

  @override
  int get hashCode {
    return BrickGenDataMapper.ensureInitialized().hashValue(
      this as BrickGenData,
    );
  }
}

extension BrickGenDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BrickGenData, $Out> {
  BrickGenDataCopyWith<$R, BrickGenData, $Out> get $asBrickGenData =>
      $base.as((v, t, t2) => _BrickGenDataCopyWithImpl(v, t, t2));
}

abstract class BrickGenDataCopyWith<$R, $In extends BrickGenData, $Out>
    implements BrickGenOptionsCopyWith<$R, $In, $Out> {
  @override
  ListCopyWith<
    $R,
    Replacement,
    ReplacementCopyWith<$R, Replacement, Replacement>
  >
  get replacements;
  @override
  ListCopyWith<
    $R,
    LinesDeletion,
    LinesDeletionCopyWith<$R, LinesDeletion, LinesDeletion>
  >
  get lineDeletions;
  @override
  $R call({
    String? referenceAbsolutePath,
    String? targetAbsolutePath,
    List<Replacement>? replacements,
    List<LinesDeletion>? lineDeletions,
  });
  BrickGenDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BrickGenDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BrickGenData, $Out>
    implements BrickGenDataCopyWith<$R, BrickGenData, $Out> {
  _BrickGenDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BrickGenData> $mapper =
      BrickGenDataMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    Replacement,
    ReplacementCopyWith<$R, Replacement, Replacement>
  >
  get replacements => ListCopyWith(
    $value.replacements,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(replacements: v),
  );
  @override
  ListCopyWith<
    $R,
    LinesDeletion,
    LinesDeletionCopyWith<$R, LinesDeletion, LinesDeletion>
  >
  get lineDeletions => ListCopyWith(
    $value.lineDeletions,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(lineDeletions: v),
  );
  @override
  $R call({
    String? referenceAbsolutePath,
    String? targetAbsolutePath,
    List<Replacement>? replacements,
    List<LinesDeletion>? lineDeletions,
  }) => $apply(
    FieldCopyWithData({
      if (referenceAbsolutePath != null)
        #referenceAbsolutePath: referenceAbsolutePath,
      if (targetAbsolutePath != null) #targetAbsolutePath: targetAbsolutePath,
      if (replacements != null) #replacements: replacements,
      if (lineDeletions != null) #lineDeletions: lineDeletions,
    }),
  );
  @override
  BrickGenData $make(CopyWithData data) => BrickGenData(
    referenceAbsolutePath: data.get(
      #referenceAbsolutePath,
      or: $value.referenceAbsolutePath,
    ),
    targetAbsolutePath: data.get(
      #targetAbsolutePath,
      or: $value.targetAbsolutePath,
    ),
    replacements: data.get(#replacements, or: $value.replacements),
    lineDeletions: data.get(#lineDeletions, or: $value.lineDeletions),
  );

  @override
  BrickGenDataCopyWith<$R2, BrickGenData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BrickGenDataCopyWithImpl($value, $cast, t);
}
