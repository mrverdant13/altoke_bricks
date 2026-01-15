// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_tasks_dao_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localTasksDao)
final localTasksDaoPod = LocalTasksDaoProvider._();

final class LocalTasksDaoProvider
    extends $FunctionalProvider<LocalTasksDao, LocalTasksDao, LocalTasksDao>
    with $Provider<LocalTasksDao> {
  LocalTasksDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localTasksDaoPod',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[
          selectedLocalDatabasePackagePod,
          asyncDriftLocalDatabasePod,
          asyncHiveInitializationPod,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          LocalTasksDaoProvider.$allTransitiveDependencies0,
          LocalTasksDaoProvider.$allTransitiveDependencies1,
          LocalTasksDaoProvider.$allTransitiveDependencies2,
          LocalTasksDaoProvider.$allTransitiveDependencies3,
          LocalTasksDaoProvider.$allTransitiveDependencies4,
        },
      );

  static final $allTransitiveDependencies0 = selectedLocalDatabasePackagePod;
  static final $allTransitiveDependencies1 = asyncDriftLocalDatabasePod;
  static final $allTransitiveDependencies2 =
      AsyncDriftLocalDatabaseProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies3 =
      AsyncDriftLocalDatabaseProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies4 = asyncHiveInitializationPod;

  @override
  String debugGetCreateSourceHash() => _$localTasksDaoHash();

  @$internal
  @override
  $ProviderElement<LocalTasksDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalTasksDao create(Ref ref) {
    return localTasksDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalTasksDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalTasksDao>(value),
    );
  }
}

String _$localTasksDaoHash() => r'696b6929be909b8add2f4668549b6ddf29165115';
