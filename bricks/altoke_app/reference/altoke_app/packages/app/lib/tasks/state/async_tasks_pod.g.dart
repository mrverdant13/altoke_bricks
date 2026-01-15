// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_tasks_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(asyncTasks)
final asyncTasksPod = AsyncTasksProvider._();

final class AsyncTasksProvider
    extends
        $FunctionalProvider<
          AsyncValue<Iterable<Task>>,
          Iterable<Task>,
          Stream<Iterable<Task>>
        >
    with $FutureModifier<Iterable<Task>>, $StreamProvider<Iterable<Task>> {
  AsyncTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncTasksPod',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[localTasksDaoPod],
        $allTransitiveDependencies: <ProviderOrFamily>{
          AsyncTasksProvider.$allTransitiveDependencies0,
          AsyncTasksProvider.$allTransitiveDependencies1,
          AsyncTasksProvider.$allTransitiveDependencies2,
          AsyncTasksProvider.$allTransitiveDependencies3,
          AsyncTasksProvider.$allTransitiveDependencies4,
          AsyncTasksProvider.$allTransitiveDependencies5,
        },
      );

  static final $allTransitiveDependencies0 = localTasksDaoPod;
  static final $allTransitiveDependencies1 =
      LocalTasksDaoProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      LocalTasksDaoProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      LocalTasksDaoProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 =
      LocalTasksDaoProvider.$allTransitiveDependencies3;
  static final $allTransitiveDependencies5 =
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
