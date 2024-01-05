// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_latest_deleted_task.pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$latestDeletedTaskHash() => r'8986ff5b654bd18bc9c7a110527e020bea4387a1';

/// See also [LatestDeletedTask].
@ProviderFor(LatestDeletedTask)
final latestDeletedTaskPod =
    AutoDisposeStreamNotifierProvider<LatestDeletedTask, Task?>.internal(
  LatestDeletedTask.new,
  name: r'latestDeletedTaskPod',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$latestDeletedTaskHash,
  dependencies: <ProviderOrFamily>[tasksRepositoryPod],
  allTransitiveDependencies: <ProviderOrFamily>{
    tasksRepositoryPod,
    ...?tasksRepositoryPod.allTransitiveDependencies
  },
);

typedef _$LatestDeletedTask = AutoDisposeStreamNotifier<Task?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
