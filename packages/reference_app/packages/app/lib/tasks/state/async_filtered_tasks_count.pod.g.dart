// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_filtered_tasks_count.pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncFilteredTasksCountHash() =>
    r'4bedf84b7845a84a8b8973c3f8d31f54c06a3507';

/// See also [asyncFilteredTasksCount].
@ProviderFor(asyncFilteredTasksCount)
final asyncFilteredTasksCountPod = AutoDisposeStreamProvider<int>.internal(
  asyncFilteredTasksCount,
  name: r'asyncFilteredTasksCountPod',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncFilteredTasksCountHash,
  dependencies: <ProviderOrFamily>[
    tasksRepositoryPod,
    selectedTasksStatusFilterPod,
    taskSearchTermPod
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    tasksRepositoryPod,
    ...?tasksRepositoryPod.allTransitiveDependencies,
    selectedTasksStatusFilterPod,
    ...?selectedTasksStatusFilterPod.allTransitiveDependencies,
    taskSearchTermPod,
    ...?taskSearchTermPod.allTransitiveDependencies
  },
);

typedef AsyncFilteredTasksCountRef = AutoDisposeStreamProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
