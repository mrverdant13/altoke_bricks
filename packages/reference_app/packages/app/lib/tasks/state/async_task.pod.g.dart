// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_task.pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncTaskHash() => r'ba9a1c34d4587d9f714a59d98d4afab7a1244728';

/// See also [asyncTask].
@ProviderFor(asyncTask)
final asyncTaskPod = AutoDisposeFutureProvider<Task?>.internal(
  asyncTask,
  name: r'asyncTaskPod',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$asyncTaskHash,
  dependencies: <ProviderOrFamily>[scopedTaskIdPod, tasksRepositoryPod],
  allTransitiveDependencies: <ProviderOrFamily>{
    scopedTaskIdPod,
    ...?scopedTaskIdPod.allTransitiveDependencies,
    tasksRepositoryPod,
    ...?tasksRepositoryPod.allTransitiveDependencies
  },
);

typedef AsyncTaskRef = AutoDisposeFutureProviderRef<Task?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
