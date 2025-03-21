// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'task.dart';

class DmTaskMapper extends ClassMapperBase<DmTask> {
  DmTaskMapper._();

  static DmTaskMapper? _instance;
  static DmTaskMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DmTaskMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DmTask';

  static int _$id(DmTask v) => v.id;
  static const Field<DmTask, int> _f$id = Field('id', _$id);
  static String _$name(DmTask v) => v.name;
  static const Field<DmTask, String> _f$name = Field('name', _$name);
  static String? _$description(DmTask v) => v.description;
  static const Field<DmTask, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );

  @override
  final MappableFields<DmTask> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
  };

  static DmTask _instantiate(DecodingData data) {
    return DmTask(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      description: data.dec(_f$description),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DmTaskMappable {
  DmTaskCopyWith<DmTask, DmTask, DmTask> get copyWith =>
      _DmTaskCopyWithImpl<DmTask, DmTask>(this as DmTask, $identity, $identity);
  @override
  String toString() {
    return DmTaskMapper.ensureInitialized().stringifyValue(this as DmTask);
  }

  @override
  bool operator ==(Object other) {
    return DmTaskMapper.ensureInitialized().equalsValue(this as DmTask, other);
  }

  @override
  int get hashCode {
    return DmTaskMapper.ensureInitialized().hashValue(this as DmTask);
  }
}

extension DmTaskValueCopy<$R, $Out> on ObjectCopyWith<$R, DmTask, $Out> {
  DmTaskCopyWith<$R, DmTask, $Out> get $asDmTask =>
      $base.as((v, t, t2) => _DmTaskCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DmTaskCopyWith<$R, $In extends DmTask, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? id, String? name, String? description});
  DmTaskCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DmTaskCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, DmTask, $Out>
    implements DmTaskCopyWith<$R, DmTask, $Out> {
  _DmTaskCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DmTask> $mapper = DmTaskMapper.ensureInitialized();
  @override
  $R call({int? id, String? name, Object? description = $none}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (description != $none) #description: description,
    }),
  );
  @override
  DmTask $make(CopyWithData data) => DmTask(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    description: data.get(#description, or: $value.description),
  );

  @override
  DmTaskCopyWith<$R2, DmTask, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _DmTaskCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DmNewTaskMapper extends ClassMapperBase<DmNewTask> {
  DmNewTaskMapper._();

  static DmNewTaskMapper? _instance;
  static DmNewTaskMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DmNewTaskMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DmNewTask';

  static String _$name(DmNewTask v) => v.name;
  static const Field<DmNewTask, String> _f$name = Field('name', _$name);
  static String? _$description(DmNewTask v) => v.description;
  static const Field<DmNewTask, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );

  @override
  final MappableFields<DmNewTask> fields = const {
    #name: _f$name,
    #description: _f$description,
  };

  static DmNewTask _instantiate(DecodingData data) {
    return DmNewTask(
      name: data.dec(_f$name),
      description: data.dec(_f$description),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DmNewTaskMappable {
  DmNewTaskCopyWith<DmNewTask, DmNewTask, DmNewTask> get copyWith =>
      _DmNewTaskCopyWithImpl<DmNewTask, DmNewTask>(
        this as DmNewTask,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DmNewTaskMapper.ensureInitialized().stringifyValue(
      this as DmNewTask,
    );
  }

  @override
  bool operator ==(Object other) {
    return DmNewTaskMapper.ensureInitialized().equalsValue(
      this as DmNewTask,
      other,
    );
  }

  @override
  int get hashCode {
    return DmNewTaskMapper.ensureInitialized().hashValue(this as DmNewTask);
  }
}

extension DmNewTaskValueCopy<$R, $Out> on ObjectCopyWith<$R, DmNewTask, $Out> {
  DmNewTaskCopyWith<$R, DmNewTask, $Out> get $asDmNewTask =>
      $base.as((v, t, t2) => _DmNewTaskCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DmNewTaskCopyWith<$R, $In extends DmNewTask, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? description});
  DmNewTaskCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DmNewTaskCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DmNewTask, $Out>
    implements DmNewTaskCopyWith<$R, DmNewTask, $Out> {
  _DmNewTaskCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DmNewTask> $mapper =
      DmNewTaskMapper.ensureInitialized();
  @override
  $R call({String? name, Object? description = $none}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (description != $none) #description: description,
    }),
  );
  @override
  DmNewTask $make(CopyWithData data) => DmNewTask(
    name: data.get(#name, or: $value.name),
    description: data.get(#description, or: $value.description),
  );

  @override
  DmNewTaskCopyWith<$R2, DmNewTask, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DmNewTaskCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DmPartialTaskMapper extends ClassMapperBase<DmPartialTask> {
  DmPartialTaskMapper._();

  static DmPartialTaskMapper? _instance;
  static DmPartialTaskMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DmPartialTaskMapper._());
      DmOptionalMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DmPartialTask';

  static DmOptional<String> _$name(DmPartialTask v) => v.name;
  static const Field<DmPartialTask, DmOptional<String>> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: const DmOptional.none(),
  );
  static DmOptional<String?> _$description(DmPartialTask v) => v.description;
  static const Field<DmPartialTask, DmOptional<String?>> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: const DmOptional.none(),
  );

  @override
  final MappableFields<DmPartialTask> fields = const {
    #name: _f$name,
    #description: _f$description,
  };

  static DmPartialTask _instantiate(DecodingData data) {
    return DmPartialTask(
      name: data.dec(_f$name),
      description: data.dec(_f$description),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DmPartialTaskMappable {
  DmPartialTaskCopyWith<DmPartialTask, DmPartialTask, DmPartialTask>
  get copyWith => _DmPartialTaskCopyWithImpl<DmPartialTask, DmPartialTask>(
    this as DmPartialTask,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return DmPartialTaskMapper.ensureInitialized().stringifyValue(
      this as DmPartialTask,
    );
  }

  @override
  bool operator ==(Object other) {
    return DmPartialTaskMapper.ensureInitialized().equalsValue(
      this as DmPartialTask,
      other,
    );
  }

  @override
  int get hashCode {
    return DmPartialTaskMapper.ensureInitialized().hashValue(
      this as DmPartialTask,
    );
  }
}

extension DmPartialTaskValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DmPartialTask, $Out> {
  DmPartialTaskCopyWith<$R, DmPartialTask, $Out> get $asDmPartialTask =>
      $base.as((v, t, t2) => _DmPartialTaskCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DmPartialTaskCopyWith<$R, $In extends DmPartialTask, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({DmOptional<String>? name, DmOptional<String?>? description});
  DmPartialTaskCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DmPartialTaskCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DmPartialTask, $Out>
    implements DmPartialTaskCopyWith<$R, DmPartialTask, $Out> {
  _DmPartialTaskCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DmPartialTask> $mapper =
      DmPartialTaskMapper.ensureInitialized();
  @override
  $R call({DmOptional<String>? name, DmOptional<String?>? description}) =>
      $apply(
        FieldCopyWithData({
          if (name != null) #name: name,
          if (description != null) #description: description,
        }),
      );
  @override
  DmPartialTask $make(CopyWithData data) => DmPartialTask(
    name: data.get(#name, or: $value.name),
    description: data.get(#description, or: $value.description),
  );

  @override
  DmPartialTaskCopyWith<$R2, DmPartialTask, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DmPartialTaskCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
