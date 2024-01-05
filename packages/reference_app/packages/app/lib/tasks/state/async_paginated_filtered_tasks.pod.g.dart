// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_paginated_filtered_tasks.pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncPaginatedFilteredTasksHash() =>
    r'25c422ef700176c4759151cb3a548f6573aaa81a';

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

/// See also [asyncPaginatedFilteredTasks].
@ProviderFor(asyncPaginatedFilteredTasks)
const asyncPaginatedFilteredTasksPod = AsyncPaginatedFilteredTasksFamily();

/// See also [asyncPaginatedFilteredTasks].
class AsyncPaginatedFilteredTasksFamily extends Family<AsyncValue<List<Task>>> {
  /// See also [asyncPaginatedFilteredTasks].
  const AsyncPaginatedFilteredTasksFamily();

  /// See also [asyncPaginatedFilteredTasks].
  AsyncPaginatedFilteredTasksProvider call({
    required int offset,
    required int limit,
  }) {
    return AsyncPaginatedFilteredTasksProvider(
      offset: offset,
      limit: limit,
    );
  }

  @override
  AsyncPaginatedFilteredTasksProvider getProviderOverride(
    covariant AsyncPaginatedFilteredTasksProvider provider,
  ) {
    return call(
      offset: provider.offset,
      limit: provider.limit,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    tasksRepositoryPod,
    selectedTasksStatusFilterPod,
    taskSearchTermPod
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    tasksRepositoryPod,
    ...?tasksRepositoryPod.allTransitiveDependencies,
    selectedTasksStatusFilterPod,
    ...?selectedTasksStatusFilterPod.allTransitiveDependencies,
    taskSearchTermPod,
    ...?taskSearchTermPod.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'asyncPaginatedFilteredTasksPod';
}

/// See also [asyncPaginatedFilteredTasks].
class AsyncPaginatedFilteredTasksProvider
    extends AutoDisposeStreamProvider<List<Task>> {
  /// See also [asyncPaginatedFilteredTasks].
  AsyncPaginatedFilteredTasksProvider({
    required int offset,
    required int limit,
  }) : this._internal(
          (ref) => asyncPaginatedFilteredTasks(
            ref as AsyncPaginatedFilteredTasksRef,
            offset: offset,
            limit: limit,
          ),
          from: asyncPaginatedFilteredTasksPod,
          name: r'asyncPaginatedFilteredTasksPod',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$asyncPaginatedFilteredTasksHash,
          dependencies: AsyncPaginatedFilteredTasksFamily._dependencies,
          allTransitiveDependencies:
              AsyncPaginatedFilteredTasksFamily._allTransitiveDependencies,
          offset: offset,
          limit: limit,
        );

  AsyncPaginatedFilteredTasksProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.offset,
    required this.limit,
  }) : super.internal();

  final int offset;
  final int limit;

  @override
  Override overrideWith(
    Stream<List<Task>> Function(AsyncPaginatedFilteredTasksRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AsyncPaginatedFilteredTasksProvider._internal(
        (ref) => create(ref as AsyncPaginatedFilteredTasksRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        offset: offset,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Task>> createElement() {
    return _AsyncPaginatedFilteredTasksProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AsyncPaginatedFilteredTasksProvider &&
        other.offset == offset &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AsyncPaginatedFilteredTasksRef
    on AutoDisposeStreamProviderRef<List<Task>> {
  /// The parameter `offset` of this provider.
  int get offset;

  /// The parameter `limit` of this provider.
  int get limit;
}

class _AsyncPaginatedFilteredTasksProviderElement
    extends AutoDisposeStreamProviderElement<List<Task>>
    with AsyncPaginatedFilteredTasksRef {
  _AsyncPaginatedFilteredTasksProviderElement(super.provider);

  @override
  int get offset => (origin as AsyncPaginatedFilteredTasksProvider).offset;
  @override
  int get limit => (origin as AsyncPaginatedFilteredTasksProvider).limit;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
