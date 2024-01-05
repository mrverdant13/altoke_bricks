// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_repository.pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tasksRepositoryHash() => r'60b53b030804b7af11612184a2806453355c3e8e';

/// See also [tasksRepository].
@ProviderFor(tasksRepository)
final tasksRepositoryPod = AutoDisposeProvider<TasksRepository>.internal(
  tasksRepository,
  name: r'tasksRepositoryPod',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tasksRepositoryHash,
  dependencies: <ProviderOrFamily>[latestDeletedTaskCachePod, tasksStoragePod],
  allTransitiveDependencies: <ProviderOrFamily>{
    latestDeletedTaskCachePod,
    ...?latestDeletedTaskCachePod.allTransitiveDependencies,
    tasksStoragePod,
    ...?tasksStoragePod.allTransitiveDependencies
  },
);

typedef TasksRepositoryRef = AutoDisposeProviderRef<TasksRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
