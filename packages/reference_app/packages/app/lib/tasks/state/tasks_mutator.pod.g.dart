// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_mutator.pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tasksMutatorHash() => r'a49f51a21f94af0d3582a1c11c2a25fe4cb1fbf8';

/// See also [TasksMutator].
@ProviderFor(TasksMutator)
final tasksMutatorPod =
    AutoDisposeNotifierProvider<TasksMutator, TasksMutationState>.internal(
  TasksMutator.new,
  name: r'tasksMutatorPod',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tasksMutatorHash,
  dependencies: <ProviderOrFamily>[tasksRepositoryPod],
  allTransitiveDependencies: <ProviderOrFamily>{
    tasksRepositoryPod,
    ...?tasksRepositoryPod.allTransitiveDependencies
  },
);

typedef _$TasksMutator = AutoDisposeNotifier<TasksMutationState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
