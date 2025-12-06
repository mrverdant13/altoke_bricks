// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'app_initialization_bloc.dart';

class AppInitializationRequestedMapper
    extends ClassMapperBase<AppInitializationRequested> {
  AppInitializationRequestedMapper._();

  static AppInitializationRequestedMapper? _instance;
  static AppInitializationRequestedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = AppInitializationRequestedMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'AppInitializationRequested';

  @override
  final MappableFields<AppInitializationRequested> fields = const {};

  static AppInitializationRequested _instantiate(DecodingData data) {
    return AppInitializationRequested();
  }

  @override
  final Function instantiate = _instantiate;

  static AppInitializationRequested fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppInitializationRequested>(map);
  }

  static AppInitializationRequested fromJson(String json) {
    return ensureInitialized().decodeJson<AppInitializationRequested>(json);
  }
}

mixin AppInitializationRequestedMappable {
  String toJson() {
    return AppInitializationRequestedMapper.ensureInitialized()
        .encodeJson<AppInitializationRequested>(
          this as AppInitializationRequested,
        );
  }

  Map<String, dynamic> toMap() {
    return AppInitializationRequestedMapper.ensureInitialized()
        .encodeMap<AppInitializationRequested>(
          this as AppInitializationRequested,
        );
  }

  AppInitializationRequestedCopyWith<
    AppInitializationRequested,
    AppInitializationRequested,
    AppInitializationRequested
  >
  get copyWith =>
      _AppInitializationRequestedCopyWithImpl<
        AppInitializationRequested,
        AppInitializationRequested
      >(this as AppInitializationRequested, $identity, $identity);
  @override
  String toString() {
    return AppInitializationRequestedMapper.ensureInitialized().stringifyValue(
      this as AppInitializationRequested,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppInitializationRequestedMapper.ensureInitialized().equalsValue(
      this as AppInitializationRequested,
      other,
    );
  }

  @override
  int get hashCode {
    return AppInitializationRequestedMapper.ensureInitialized().hashValue(
      this as AppInitializationRequested,
    );
  }
}

extension AppInitializationRequestedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppInitializationRequested, $Out> {
  AppInitializationRequestedCopyWith<$R, AppInitializationRequested, $Out>
  get $asAppInitializationRequested => $base.as(
    (v, t, t2) => _AppInitializationRequestedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AppInitializationRequestedCopyWith<
  $R,
  $In extends AppInitializationRequested,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  AppInitializationRequestedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppInitializationRequestedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppInitializationRequested, $Out>
    implements
        AppInitializationRequestedCopyWith<
          $R,
          AppInitializationRequested,
          $Out
        > {
  _AppInitializationRequestedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppInitializationRequested> $mapper =
      AppInitializationRequestedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AppInitializationRequested $make(CopyWithData data) =>
      AppInitializationRequested();

  @override
  AppInitializationRequestedCopyWith<$R2, AppInitializationRequested, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AppInitializationRequestedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AppUninitializedMapper extends ClassMapperBase<AppUninitialized> {
  AppUninitializedMapper._();

  static AppUninitializedMapper? _instance;
  static AppUninitializedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppUninitializedMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AppUninitialized';

  @override
  final MappableFields<AppUninitialized> fields = const {};

  static AppUninitialized _instantiate(DecodingData data) {
    return AppUninitialized();
  }

  @override
  final Function instantiate = _instantiate;

  static AppUninitialized fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppUninitialized>(map);
  }

  static AppUninitialized fromJson(String json) {
    return ensureInitialized().decodeJson<AppUninitialized>(json);
  }
}

mixin AppUninitializedMappable {
  String toJson() {
    return AppUninitializedMapper.ensureInitialized()
        .encodeJson<AppUninitialized>(this as AppUninitialized);
  }

  Map<String, dynamic> toMap() {
    return AppUninitializedMapper.ensureInitialized()
        .encodeMap<AppUninitialized>(this as AppUninitialized);
  }

  AppUninitializedCopyWith<AppUninitialized, AppUninitialized, AppUninitialized>
  get copyWith =>
      _AppUninitializedCopyWithImpl<AppUninitialized, AppUninitialized>(
        this as AppUninitialized,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AppUninitializedMapper.ensureInitialized().stringifyValue(
      this as AppUninitialized,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppUninitializedMapper.ensureInitialized().equalsValue(
      this as AppUninitialized,
      other,
    );
  }

  @override
  int get hashCode {
    return AppUninitializedMapper.ensureInitialized().hashValue(
      this as AppUninitialized,
    );
  }
}

extension AppUninitializedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppUninitialized, $Out> {
  AppUninitializedCopyWith<$R, AppUninitialized, $Out>
  get $asAppUninitialized =>
      $base.as((v, t, t2) => _AppUninitializedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AppUninitializedCopyWith<$R, $In extends AppUninitialized, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  AppUninitializedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppUninitializedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppUninitialized, $Out>
    implements AppUninitializedCopyWith<$R, AppUninitialized, $Out> {
  _AppUninitializedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppUninitialized> $mapper =
      AppUninitializedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AppUninitialized $make(CopyWithData data) => AppUninitialized();

  @override
  AppUninitializedCopyWith<$R2, AppUninitialized, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AppUninitializedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AppInitializingMapper extends ClassMapperBase<AppInitializing> {
  AppInitializingMapper._();

  static AppInitializingMapper? _instance;
  static AppInitializingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppInitializingMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AppInitializing';

  @override
  final MappableFields<AppInitializing> fields = const {};

  static AppInitializing _instantiate(DecodingData data) {
    return AppInitializing();
  }

  @override
  final Function instantiate = _instantiate;

  static AppInitializing fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppInitializing>(map);
  }

  static AppInitializing fromJson(String json) {
    return ensureInitialized().decodeJson<AppInitializing>(json);
  }
}

mixin AppInitializingMappable {
  String toJson() {
    return AppInitializingMapper.ensureInitialized()
        .encodeJson<AppInitializing>(this as AppInitializing);
  }

  Map<String, dynamic> toMap() {
    return AppInitializingMapper.ensureInitialized().encodeMap<AppInitializing>(
      this as AppInitializing,
    );
  }

  AppInitializingCopyWith<AppInitializing, AppInitializing, AppInitializing>
  get copyWith =>
      _AppInitializingCopyWithImpl<AppInitializing, AppInitializing>(
        this as AppInitializing,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AppInitializingMapper.ensureInitialized().stringifyValue(
      this as AppInitializing,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppInitializingMapper.ensureInitialized().equalsValue(
      this as AppInitializing,
      other,
    );
  }

  @override
  int get hashCode {
    return AppInitializingMapper.ensureInitialized().hashValue(
      this as AppInitializing,
    );
  }
}

extension AppInitializingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppInitializing, $Out> {
  AppInitializingCopyWith<$R, AppInitializing, $Out> get $asAppInitializing =>
      $base.as((v, t, t2) => _AppInitializingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AppInitializingCopyWith<$R, $In extends AppInitializing, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  AppInitializingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppInitializingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppInitializing, $Out>
    implements AppInitializingCopyWith<$R, AppInitializing, $Out> {
  _AppInitializingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppInitializing> $mapper =
      AppInitializingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AppInitializing $make(CopyWithData data) => AppInitializing();

  @override
  AppInitializingCopyWith<$R2, AppInitializing, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AppInitializingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SuccessfulAppInitializationMapper
    extends ClassMapperBase<SuccessfulAppInitialization> {
  SuccessfulAppInitializationMapper._();

  static SuccessfulAppInitializationMapper? _instance;
  static SuccessfulAppInitializationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = SuccessfulAppInitializationMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'SuccessfulAppInitialization';

  static Directory _$applicationDocumentsDirectory(
    SuccessfulAppInitialization v,
  ) => v.applicationDocumentsDirectory;
  static const Field<SuccessfulAppInitialization, Directory>
  _f$applicationDocumentsDirectory = Field(
    'applicationDocumentsDirectory',
    _$applicationDocumentsDirectory,
  );
  static Directory _$temporaryDirectory(SuccessfulAppInitialization v) =>
      v.temporaryDirectory;
  static const Field<SuccessfulAppInitialization, Directory>
  _f$temporaryDirectory = Field('temporaryDirectory', _$temporaryDirectory);
  static LocalDatabase _$localDatabase(SuccessfulAppInitialization v) =>
      v.localDatabase;
  static const Field<SuccessfulAppInitialization, LocalDatabase>
  _f$localDatabase = Field('localDatabase', _$localDatabase);

  @override
  final MappableFields<SuccessfulAppInitialization> fields = const {
    #applicationDocumentsDirectory: _f$applicationDocumentsDirectory,
    #temporaryDirectory: _f$temporaryDirectory,
    #localDatabase: _f$localDatabase,
  };

  static SuccessfulAppInitialization _instantiate(DecodingData data) {
    return SuccessfulAppInitialization(
      applicationDocumentsDirectory: data.dec(_f$applicationDocumentsDirectory),
      temporaryDirectory: data.dec(_f$temporaryDirectory),
      localDatabase: data.dec(_f$localDatabase),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SuccessfulAppInitialization fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SuccessfulAppInitialization>(map);
  }

  static SuccessfulAppInitialization fromJson(String json) {
    return ensureInitialized().decodeJson<SuccessfulAppInitialization>(json);
  }
}

mixin SuccessfulAppInitializationMappable {
  String toJson() {
    return SuccessfulAppInitializationMapper.ensureInitialized()
        .encodeJson<SuccessfulAppInitialization>(
          this as SuccessfulAppInitialization,
        );
  }

  Map<String, dynamic> toMap() {
    return SuccessfulAppInitializationMapper.ensureInitialized()
        .encodeMap<SuccessfulAppInitialization>(
          this as SuccessfulAppInitialization,
        );
  }

  SuccessfulAppInitializationCopyWith<
    SuccessfulAppInitialization,
    SuccessfulAppInitialization,
    SuccessfulAppInitialization
  >
  get copyWith =>
      _SuccessfulAppInitializationCopyWithImpl<
        SuccessfulAppInitialization,
        SuccessfulAppInitialization
      >(this as SuccessfulAppInitialization, $identity, $identity);
  @override
  String toString() {
    return SuccessfulAppInitializationMapper.ensureInitialized().stringifyValue(
      this as SuccessfulAppInitialization,
    );
  }

  @override
  bool operator ==(Object other) {
    return SuccessfulAppInitializationMapper.ensureInitialized().equalsValue(
      this as SuccessfulAppInitialization,
      other,
    );
  }

  @override
  int get hashCode {
    return SuccessfulAppInitializationMapper.ensureInitialized().hashValue(
      this as SuccessfulAppInitialization,
    );
  }
}

extension SuccessfulAppInitializationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SuccessfulAppInitialization, $Out> {
  SuccessfulAppInitializationCopyWith<$R, SuccessfulAppInitialization, $Out>
  get $asSuccessfulAppInitialization => $base.as(
    (v, t, t2) => _SuccessfulAppInitializationCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class SuccessfulAppInitializationCopyWith<
  $R,
  $In extends SuccessfulAppInitialization,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    Directory? applicationDocumentsDirectory,
    Directory? temporaryDirectory,
    LocalDatabase? localDatabase,
  });
  SuccessfulAppInitializationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SuccessfulAppInitializationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SuccessfulAppInitialization, $Out>
    implements
        SuccessfulAppInitializationCopyWith<
          $R,
          SuccessfulAppInitialization,
          $Out
        > {
  _SuccessfulAppInitializationCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<SuccessfulAppInitialization> $mapper =
      SuccessfulAppInitializationMapper.ensureInitialized();
  @override
  $R call({
    Directory? applicationDocumentsDirectory,
    Directory? temporaryDirectory,
    LocalDatabase? localDatabase,
  }) => $apply(
    FieldCopyWithData({
      if (applicationDocumentsDirectory != null)
        #applicationDocumentsDirectory: applicationDocumentsDirectory,
      if (temporaryDirectory != null) #temporaryDirectory: temporaryDirectory,
      if (localDatabase != null) #localDatabase: localDatabase,
    }),
  );
  @override
  SuccessfulAppInitialization $make(CopyWithData data) =>
      SuccessfulAppInitialization(
        applicationDocumentsDirectory: data.get(
          #applicationDocumentsDirectory,
          or: $value.applicationDocumentsDirectory,
        ),
        temporaryDirectory: data.get(
          #temporaryDirectory,
          or: $value.temporaryDirectory,
        ),
        localDatabase: data.get(#localDatabase, or: $value.localDatabase),
      );

  @override
  SuccessfulAppInitializationCopyWith<$R2, SuccessfulAppInitialization, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SuccessfulAppInitializationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FailedAppInitializationMapper
    extends ClassMapperBase<FailedAppInitialization> {
  FailedAppInitializationMapper._();

  static FailedAppInitializationMapper? _instance;
  static FailedAppInitializationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = FailedAppInitializationMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'FailedAppInitialization';

  static bool _$hiveDatabaseInitialized(FailedAppInitialization v) =>
      v.hiveDatabaseInitialized;
  static const Field<FailedAppInitialization, bool> _f$hiveDatabaseInitialized =
      Field('hiveDatabaseInitialized', _$hiveDatabaseInitialized);
  static Directory? _$applicationDocumentsDirectory(
    FailedAppInitialization v,
  ) => v.applicationDocumentsDirectory;
  static const Field<FailedAppInitialization, Directory>
  _f$applicationDocumentsDirectory = Field(
    'applicationDocumentsDirectory',
    _$applicationDocumentsDirectory,
    opt: true,
  );
  static Directory? _$temporaryDirectory(FailedAppInitialization v) =>
      v.temporaryDirectory;
  static const Field<FailedAppInitialization, Directory> _f$temporaryDirectory =
      Field('temporaryDirectory', _$temporaryDirectory, opt: true);
  static LocalDatabase? _$localDatabase(FailedAppInitialization v) =>
      v.localDatabase;
  static const Field<FailedAppInitialization, LocalDatabase> _f$localDatabase =
      Field('localDatabase', _$localDatabase, opt: true);

  @override
  final MappableFields<FailedAppInitialization> fields = const {
    #hiveDatabaseInitialized: _f$hiveDatabaseInitialized,
    #applicationDocumentsDirectory: _f$applicationDocumentsDirectory,
    #temporaryDirectory: _f$temporaryDirectory,
    #localDatabase: _f$localDatabase,
  };

  static FailedAppInitialization _instantiate(DecodingData data) {
    return FailedAppInitialization(
      hiveDatabaseInitialized: data.dec(_f$hiveDatabaseInitialized),
      applicationDocumentsDirectory: data.dec(_f$applicationDocumentsDirectory),
      temporaryDirectory: data.dec(_f$temporaryDirectory),
      localDatabase: data.dec(_f$localDatabase),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FailedAppInitialization fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FailedAppInitialization>(map);
  }

  static FailedAppInitialization fromJson(String json) {
    return ensureInitialized().decodeJson<FailedAppInitialization>(json);
  }
}

mixin FailedAppInitializationMappable {
  String toJson() {
    return FailedAppInitializationMapper.ensureInitialized()
        .encodeJson<FailedAppInitialization>(this as FailedAppInitialization);
  }

  Map<String, dynamic> toMap() {
    return FailedAppInitializationMapper.ensureInitialized()
        .encodeMap<FailedAppInitialization>(this as FailedAppInitialization);
  }

  FailedAppInitializationCopyWith<
    FailedAppInitialization,
    FailedAppInitialization,
    FailedAppInitialization
  >
  get copyWith =>
      _FailedAppInitializationCopyWithImpl<
        FailedAppInitialization,
        FailedAppInitialization
      >(this as FailedAppInitialization, $identity, $identity);
  @override
  String toString() {
    return FailedAppInitializationMapper.ensureInitialized().stringifyValue(
      this as FailedAppInitialization,
    );
  }

  @override
  bool operator ==(Object other) {
    return FailedAppInitializationMapper.ensureInitialized().equalsValue(
      this as FailedAppInitialization,
      other,
    );
  }

  @override
  int get hashCode {
    return FailedAppInitializationMapper.ensureInitialized().hashValue(
      this as FailedAppInitialization,
    );
  }
}

extension FailedAppInitializationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FailedAppInitialization, $Out> {
  FailedAppInitializationCopyWith<$R, FailedAppInitialization, $Out>
  get $asFailedAppInitialization => $base.as(
    (v, t, t2) => _FailedAppInitializationCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class FailedAppInitializationCopyWith<
  $R,
  $In extends FailedAppInitialization,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    bool? hiveDatabaseInitialized,
    Directory? applicationDocumentsDirectory,
    Directory? temporaryDirectory,
    LocalDatabase? localDatabase,
  });
  FailedAppInitializationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _FailedAppInitializationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FailedAppInitialization, $Out>
    implements
        FailedAppInitializationCopyWith<$R, FailedAppInitialization, $Out> {
  _FailedAppInitializationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FailedAppInitialization> $mapper =
      FailedAppInitializationMapper.ensureInitialized();
  @override
  $R call({
    bool? hiveDatabaseInitialized,
    Object? applicationDocumentsDirectory = $none,
    Object? temporaryDirectory = $none,
    Object? localDatabase = $none,
  }) => $apply(
    FieldCopyWithData({
      if (hiveDatabaseInitialized != null)
        #hiveDatabaseInitialized: hiveDatabaseInitialized,
      if (applicationDocumentsDirectory != $none)
        #applicationDocumentsDirectory: applicationDocumentsDirectory,
      if (temporaryDirectory != $none) #temporaryDirectory: temporaryDirectory,
      if (localDatabase != $none) #localDatabase: localDatabase,
    }),
  );
  @override
  FailedAppInitialization $make(CopyWithData data) => FailedAppInitialization(
    hiveDatabaseInitialized: data.get(
      #hiveDatabaseInitialized,
      or: $value.hiveDatabaseInitialized,
    ),
    applicationDocumentsDirectory: data.get(
      #applicationDocumentsDirectory,
      or: $value.applicationDocumentsDirectory,
    ),
    temporaryDirectory: data.get(
      #temporaryDirectory,
      or: $value.temporaryDirectory,
    ),
    localDatabase: data.get(#localDatabase, or: $value.localDatabase),
  );

  @override
  FailedAppInitializationCopyWith<$R2, FailedAppInitialization, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FailedAppInitializationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

