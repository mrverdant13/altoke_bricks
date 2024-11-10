// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_tasks_dao_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$localTasksDaoHash() => r'b6a4eb629b3bd53bfe763f3c9f5141a7d418737c';

/// See also [localTasksDao].
@ProviderFor(localTasksDao)
final localTasksDaoPod = AutoDisposeProvider<LocalTasksDao>.internal(
  localTasksDao,
  name: r'localTasksDaoPod',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localTasksDaoHash,
  dependencies: <ProviderOrFamily>[
    selectedLocalDatabasePackagePod,
    asyncDriftLocalDatabasePod,
    asyncIsarPod
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    selectedLocalDatabasePackagePod,
    ...?selectedLocalDatabasePackagePod.allTransitiveDependencies,
    asyncDriftLocalDatabasePod,
    ...?asyncDriftLocalDatabasePod.allTransitiveDependencies,
    asyncIsarPod,
    ...?asyncIsarPod.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocalTasksDaoRef = AutoDisposeProviderRef<LocalTasksDao>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
