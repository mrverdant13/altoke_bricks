// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_editor.pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskEditorHash() => r'42163d292aa9a1a403f0e282b46ca9d5f440dad0';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$TaskEditor extends BuildlessAutoDisposeAsyncNotifier<void> {
  late final int taskId;

  FutureOr<void> build(
    int taskId,
  );
}

/// See also [TaskEditor].
@ProviderFor(TaskEditor)
const taskEditorPod = TaskEditorFamily();

/// See also [TaskEditor].
class TaskEditorFamily extends Family<AsyncValue<void>> {
  /// See also [TaskEditor].
  const TaskEditorFamily();

  /// See also [TaskEditor].
  TaskEditorProvider call(
    int taskId,
  ) {
    return TaskEditorProvider(
      taskId,
    );
  }

  @override
  TaskEditorProvider getProviderOverride(
    covariant TaskEditorProvider provider,
  ) {
    return call(
      provider.taskId,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    tasksRepositoryPod
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    tasksRepositoryPod,
    ...?tasksRepositoryPod.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'taskEditorPod';
}

/// See also [TaskEditor].
class TaskEditorProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TaskEditor, void> {
  /// See also [TaskEditor].
  TaskEditorProvider(
    int taskId,
  ) : this._internal(
          () => TaskEditor()..taskId = taskId,
          from: taskEditorPod,
          name: r'taskEditorPod',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskEditorHash,
          dependencies: TaskEditorFamily._dependencies,
          allTransitiveDependencies:
              TaskEditorFamily._allTransitiveDependencies,
          taskId: taskId,
        );

  TaskEditorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taskId,
  }) : super.internal();

  final int taskId;

  @override
  FutureOr<void> runNotifierBuild(
    covariant TaskEditor notifier,
  ) {
    return notifier.build(
      taskId,
    );
  }

  @override
  Override overrideWith(TaskEditor Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskEditorProvider._internal(
        () => create()..taskId = taskId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taskId: taskId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TaskEditor, void> createElement() {
    return _TaskEditorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskEditorProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TaskEditorRef on AutoDisposeAsyncNotifierProviderRef<void> {
  /// The parameter `taskId` of this provider.
  int get taskId;
}

class _TaskEditorProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TaskEditor, void>
    with TaskEditorRef {
  _TaskEditorProviderElement(super.provider);

  @override
  int get taskId => (origin as TaskEditorProvider).taskId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
