// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_tasks_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncTasksHash() => r'befe0325d2483f47a0461b813fee3d06fc575009';

/// See also [asyncTasks].
@ProviderFor(asyncTasks)
final asyncTasksPod = AutoDisposeStreamProvider<Iterable<Task>>.internal(
  asyncTasks,
  name: r'asyncTasksPod',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$asyncTasksHash,
  dependencies: <ProviderOrFamily>[localTasksDaoPod],
  allTransitiveDependencies: <ProviderOrFamily>{
    localTasksDaoPod,
    ...?localTasksDaoPod.allTransitiveDependencies,
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AsyncTasksRef = AutoDisposeStreamProviderRef<Iterable<Task>>;
String _$createTaskMutationHash() =>
    r'c3313eb488815acc2d7499b40aefc7266f14a1e7';

/// See also [CreateTaskMutation].
@ProviderFor(CreateTaskMutation)
final createTaskMutationPod =
    AutoDisposeAsyncNotifierProvider<CreateTaskMutation, NewTask?>.internal(
      CreateTaskMutation.new,
      name: r'createTaskMutationPod',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$createTaskMutationHash,
      dependencies: <ProviderOrFamily>[localTasksDaoPod],
      allTransitiveDependencies: <ProviderOrFamily>{
        localTasksDaoPod,
        ...?localTasksDaoPod.allTransitiveDependencies,
      },
    );

typedef _$CreateTaskMutation = AutoDisposeAsyncNotifier<NewTask?>;
String _$updateTaskMutationHash() =>
    r'3239b9d6ad8fda93199948bc702a1bd27a72a588';

/// See also [UpdateTaskMutation].
@ProviderFor(UpdateTaskMutation)
final updateTaskMutationPod = AutoDisposeAsyncNotifierProvider<
  UpdateTaskMutation,
  (int, PartialTask)?
>.internal(
  UpdateTaskMutation.new,
  name: r'updateTaskMutationPod',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$updateTaskMutationHash,
  dependencies: <ProviderOrFamily>[localTasksDaoPod],
  allTransitiveDependencies: <ProviderOrFamily>{
    localTasksDaoPod,
    ...?localTasksDaoPod.allTransitiveDependencies,
  },
);

typedef _$UpdateTaskMutation = AutoDisposeAsyncNotifier<(int, PartialTask)?>;
String _$deleteTaskByIdMutationHash() =>
    r'978bb623fefc9f2d79423e0f57655a485e4fcdcd';

/// See also [DeleteTaskByIdMutation].
@ProviderFor(DeleteTaskByIdMutation)
final deleteTaskByIdMutationPod =
    AutoDisposeAsyncNotifierProvider<DeleteTaskByIdMutation, int?>.internal(
      DeleteTaskByIdMutation.new,
      name: r'deleteTaskByIdMutationPod',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$deleteTaskByIdMutationHash,
      dependencies: <ProviderOrFamily>[localTasksDaoPod],
      allTransitiveDependencies: <ProviderOrFamily>{
        localTasksDaoPod,
        ...?localTasksDaoPod.allTransitiveDependencies,
      },
    );

typedef _$DeleteTaskByIdMutation = AutoDisposeAsyncNotifier<int?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
