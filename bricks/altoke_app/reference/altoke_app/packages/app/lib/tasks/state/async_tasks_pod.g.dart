// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_tasks_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(asyncTasks)
const asyncTasksPod = AsyncTasksProvider._();

final class AsyncTasksProvider
    extends
        $FunctionalProvider<
          AsyncValue<Iterable<Task>>,
          Iterable<Task>,
          Stream<Iterable<Task>>
        >
    with $FutureModifier<Iterable<Task>>, $StreamProvider<Iterable<Task>> {
  const AsyncTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncTasksPod',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[localTasksDaoPod],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          AsyncTasksProvider.$allTransitiveDependencies0,
          AsyncTasksProvider.$allTransitiveDependencies1,
          AsyncTasksProvider.$allTransitiveDependencies2,
          AsyncTasksProvider.$allTransitiveDependencies3,
          AsyncTasksProvider.$allTransitiveDependencies4,
          AsyncTasksProvider.$allTransitiveDependencies5,
        },
      );

  static const $allTransitiveDependencies0 = localTasksDaoPod;
  static const $allTransitiveDependencies1 =
      LocalTasksDaoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      LocalTasksDaoProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      LocalTasksDaoProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      LocalTasksDaoProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies5 =
      LocalTasksDaoProvider.$allTransitiveDependencies4;

  @override
  String debugGetCreateSourceHash() => _$asyncTasksHash();

  @$internal
  @override
  $StreamProviderElement<Iterable<Task>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Iterable<Task>> create(Ref ref) {
    return asyncTasks(ref);
  }
}

String _$asyncTasksHash() => r'befe0325d2483f47a0461b813fee3d06fc575009';
