// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_storage.pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tasksStorageHash() => r'6537da604d51840854fa4f0974056f4fd8f850b1';

/// See also [tasksStorage].
@ProviderFor(tasksStorage)
final tasksStoragePod = AutoDisposeProvider<TasksStorage>.internal(
  tasksStorage,
  name: r'tasksStoragePod',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tasksStorageHash,
  dependencies: <ProviderOrFamily>[tasksBoxPod, realmDbPod, sembastDbPod],
  allTransitiveDependencies: <ProviderOrFamily>{
    tasksBoxPod,
    ...?tasksBoxPod.allTransitiveDependencies,
    realmDbPod,
    ...?realmDbPod.allTransitiveDependencies,
    sembastDbPod,
    ...?sembastDbPod.allTransitiveDependencies
  },
);

typedef TasksStorageRef = AutoDisposeProviderRef<TasksStorage>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
