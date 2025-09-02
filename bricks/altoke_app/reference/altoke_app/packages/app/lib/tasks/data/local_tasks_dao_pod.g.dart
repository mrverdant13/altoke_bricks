// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_tasks_dao_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(localTasksDao)
const localTasksDaoPod = LocalTasksDaoProvider._();

final class LocalTasksDaoProvider
    extends $FunctionalProvider<LocalTasksDao, LocalTasksDao, LocalTasksDao>
    with $Provider<LocalTasksDao> {
  const LocalTasksDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localTasksDaoPod',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          selectedLocalDatabasePackagePod,
          asyncDriftLocalDatabasePod,
          asyncHiveInitializationPod,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          LocalTasksDaoProvider.$allTransitiveDependencies0,
          LocalTasksDaoProvider.$allTransitiveDependencies1,
          LocalTasksDaoProvider.$allTransitiveDependencies2,
          LocalTasksDaoProvider.$allTransitiveDependencies3,
          LocalTasksDaoProvider.$allTransitiveDependencies4,
        },
      );

  static const $allTransitiveDependencies0 = selectedLocalDatabasePackagePod;
  static const $allTransitiveDependencies1 = asyncDriftLocalDatabasePod;
  static const $allTransitiveDependencies2 =
      AsyncDriftLocalDatabaseProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies3 =
      AsyncDriftLocalDatabaseProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies4 = asyncHiveInitializationPod;

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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
