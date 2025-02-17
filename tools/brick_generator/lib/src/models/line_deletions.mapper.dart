// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'line_deletions.dart';

class LinesDeletionMapper extends ClassMapperBase<LinesDeletion> {
  LinesDeletionMapper._();

  static LinesDeletionMapper? _instance;
  static LinesDeletionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LinesDeletionMapper._());
      LinesRangeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LinesDeletion';

  static String _$filePath(LinesDeletion v) => v.filePath;
  static const Field<LinesDeletion, String> _f$filePath = Field(
    'filePath',
    _$filePath,
  );
  static List<LinesRange> _$ranges(LinesDeletion v) => v.ranges;
  static const Field<LinesDeletion, List<LinesRange>> _f$ranges = Field(
    'ranges',
    _$ranges,
  );

  @override
  final MappableFields<LinesDeletion> fields = const {
    #filePath: _f$filePath,
    #ranges: _f$ranges,
  };

  static LinesDeletion _instantiate(DecodingData data) {
    return LinesDeletion(
      filePath: data.dec(_f$filePath),
      ranges: data.dec(_f$ranges),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LinesDeletion fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LinesDeletion>(map);
  }

  static LinesDeletion fromJson(String json) {
    return ensureInitialized().decodeJson<LinesDeletion>(json);
  }
}

mixin LinesDeletionMappable {
  String toJson() {
    return LinesDeletionMapper.ensureInitialized().encodeJson<LinesDeletion>(
      this as LinesDeletion,
    );
  }

  Map<String, dynamic> toMap() {
    return LinesDeletionMapper.ensureInitialized().encodeMap<LinesDeletion>(
      this as LinesDeletion,
    );
  }

  LinesDeletionCopyWith<LinesDeletion, LinesDeletion, LinesDeletion>
  get copyWith =>
      _LinesDeletionCopyWithImpl(this as LinesDeletion, $identity, $identity);
  @override
  String toString() {
    return LinesDeletionMapper.ensureInitialized().stringifyValue(
      this as LinesDeletion,
    );
  }

  @override
  bool operator ==(Object other) {
    return LinesDeletionMapper.ensureInitialized().equalsValue(
      this as LinesDeletion,
      other,
    );
  }

  @override
  int get hashCode {
    return LinesDeletionMapper.ensureInitialized().hashValue(
      this as LinesDeletion,
    );
  }
}

extension LinesDeletionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LinesDeletion, $Out> {
  LinesDeletionCopyWith<$R, LinesDeletion, $Out> get $asLinesDeletion =>
      $base.as((v, t, t2) => _LinesDeletionCopyWithImpl(v, t, t2));
}

abstract class LinesDeletionCopyWith<$R, $In extends LinesDeletion, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, LinesRange, LinesRangeCopyWith<$R, LinesRange, LinesRange>>
  get ranges;
  $R call({String? filePath, List<LinesRange>? ranges});
  LinesDeletionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LinesDeletionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LinesDeletion, $Out>
    implements LinesDeletionCopyWith<$R, LinesDeletion, $Out> {
  _LinesDeletionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LinesDeletion> $mapper =
      LinesDeletionMapper.ensureInitialized();
  @override
  ListCopyWith<$R, LinesRange, LinesRangeCopyWith<$R, LinesRange, LinesRange>>
  get ranges => ListCopyWith(
    $value.ranges,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(ranges: v),
  );
  @override
  $R call({String? filePath, List<LinesRange>? ranges}) => $apply(
    FieldCopyWithData({
      if (filePath != null) #filePath: filePath,
      if (ranges != null) #ranges: ranges,
    }),
  );
  @override
  LinesDeletion $make(CopyWithData data) => LinesDeletion(
    filePath: data.get(#filePath, or: $value.filePath),
    ranges: data.get(#ranges, or: $value.ranges),
  );

  @override
  LinesDeletionCopyWith<$R2, LinesDeletion, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LinesDeletionCopyWithImpl($value, $cast, t);
}

class LinesRangeMapper extends ClassMapperBase<LinesRange> {
  LinesRangeMapper._();

  static LinesRangeMapper? _instance;
  static LinesRangeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LinesRangeMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LinesRange';

  static int _$start(LinesRange v) => v.start;
  static const Field<LinesRange, int> _f$start = Field('start', _$start);
  static int _$end(LinesRange v) => v.end;
  static const Field<LinesRange, int> _f$end = Field('end', _$end);

  @override
  final MappableFields<LinesRange> fields = const {
    #start: _f$start,
    #end: _f$end,
  };

  static LinesRange _instantiate(DecodingData data) {
    return LinesRange(start: data.dec(_f$start), end: data.dec(_f$end));
  }

  @override
  final Function instantiate = _instantiate;

  static LinesRange fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LinesRange>(map);
  }

  static LinesRange fromJson(String json) {
    return ensureInitialized().decodeJson<LinesRange>(json);
  }
}

mixin LinesRangeMappable {
  String toJson() {
    return LinesRangeMapper.ensureInitialized().encodeJson<LinesRange>(
      this as LinesRange,
    );
  }

  Map<String, dynamic> toMap() {
    return LinesRangeMapper.ensureInitialized().encodeMap<LinesRange>(
      this as LinesRange,
    );
  }

  LinesRangeCopyWith<LinesRange, LinesRange, LinesRange> get copyWith =>
      _LinesRangeCopyWithImpl(this as LinesRange, $identity, $identity);
  @override
  String toString() {
    return LinesRangeMapper.ensureInitialized().stringifyValue(
      this as LinesRange,
    );
  }

  @override
  bool operator ==(Object other) {
    return LinesRangeMapper.ensureInitialized().equalsValue(
      this as LinesRange,
      other,
    );
  }

  @override
  int get hashCode {
    return LinesRangeMapper.ensureInitialized().hashValue(this as LinesRange);
  }
}

extension LinesRangeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LinesRange, $Out> {
  LinesRangeCopyWith<$R, LinesRange, $Out> get $asLinesRange =>
      $base.as((v, t, t2) => _LinesRangeCopyWithImpl(v, t, t2));
}

abstract class LinesRangeCopyWith<$R, $In extends LinesRange, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? start, int? end});
  LinesRangeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LinesRangeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LinesRange, $Out>
    implements LinesRangeCopyWith<$R, LinesRange, $Out> {
  _LinesRangeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LinesRange> $mapper =
      LinesRangeMapper.ensureInitialized();
  @override
  $R call({int? start, int? end}) => $apply(
    FieldCopyWithData({
      if (start != null) #start: start,
      if (end != null) #end: end,
    }),
  );
  @override
  LinesRange $make(CopyWithData data) => LinesRange(
    start: data.get(#start, or: $value.start),
    end: data.get(#end, or: $value.end),
  );

  @override
  LinesRangeCopyWith<$R2, LinesRange, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LinesRangeCopyWithImpl($value, $cast, t);
}
