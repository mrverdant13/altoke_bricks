// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_storage.pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tasksStorageHash() => r'2af9da13ae8377eb79529a553e61014cb6c72c61';

/// See also [tasksStorage].
@ProviderFor(tasksStorage)
final tasksStoragePod = AutoDisposeProvider<TasksStorage>.internal(
  tasksStorage,
  name: r'tasksStoragePod',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tasksStorageHash,
  dependencies: <ProviderOrFamily>{
    databasePod,
    isarDbPod,
    tasksBoxPod,
    realmDbPod,
    sembastDbPod,
    sqliteDbPod
  },
  allTransitiveDependencies: <ProviderOrFamily>{
    databasePod,
    ...?databasePod.allTransitiveDependencies,
    isarDbPod,
    ...?isarDbPod.allTransitiveDependencies,
    tasksBoxPod,
    ...?tasksBoxPod.allTransitiveDependencies,
    realmDbPod,
    ...?realmDbPod.allTransitiveDependencies,
    sembastDbPod,
    ...?sembastDbPod.allTransitiveDependencies,
    sqliteDbPod,
    ...?sqliteDbPod.allTransitiveDependencies
  },
);

typedef TasksStorageRef = AutoDisposeProviderRef<TasksStorage>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
