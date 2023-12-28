// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_filtered_tasks_count.pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncFilteredTasksCountHash() =>
    r'3e9aa0ce7e5a957b19e9651503274b3e389ccf3c';

/// See also [asyncFilteredTasksCount].
@ProviderFor(asyncFilteredTasksCount)
final asyncFilteredTasksCountPod = AutoDisposeStreamProvider<int>.internal(
  asyncFilteredTasksCount,
  name: r'asyncFilteredTasksCountPod',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncFilteredTasksCountHash,
  dependencies: <ProviderOrFamily>[
    tasksStoragePod,
    selectedTasksStatusFilterPod,
    taskSearchTermPod
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    tasksStoragePod,
    ...?tasksStoragePod.allTransitiveDependencies,
    selectedTasksStatusFilterPod,
    ...?selectedTasksStatusFilterPod.allTransitiveDependencies,
    taskSearchTermPod,
    ...?taskSearchTermPod.allTransitiveDependencies
  },
);

typedef AsyncFilteredTasksCountRef = AutoDisposeStreamProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
