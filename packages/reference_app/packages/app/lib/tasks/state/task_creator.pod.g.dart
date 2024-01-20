// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_creator.pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskCreatorHash() => r'585e9b2d151a34f688a0e183cd9efb65c228e082';

/// See also [TaskCreator].
@ProviderFor(TaskCreator)
final taskCreatorPod =
    AutoDisposeAsyncNotifierProvider<TaskCreator, bool>.internal(
  TaskCreator.new,
  name: r'taskCreatorPod',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$taskCreatorHash,
  dependencies: <ProviderOrFamily>[tasksRepositoryPod],
  allTransitiveDependencies: <ProviderOrFamily>{
    tasksRepositoryPod,
    ...?tasksRepositoryPod.allTransitiveDependencies
  },
);

typedef _$TaskCreator = AutoDisposeAsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
