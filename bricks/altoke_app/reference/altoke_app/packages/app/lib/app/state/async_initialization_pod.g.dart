// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_initialization_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncInitializationHash() =>
    r'1b3c857b2d2fc4b3c2ac6d0ebc9e720521e427e8';

/// See also [asyncInitialization].
@ProviderFor(asyncInitialization)
final asyncInitializationPod = AutoDisposeFutureProvider<void>.internal(
  asyncInitialization,
  name: r'asyncInitializationPod',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncInitializationHash,
  dependencies: <ProviderOrFamily>{
    asyncApplicationDocumentsDirectoryPod,
    asyncDriftLocalDatabasePod,
    asyncHiveInitializationPod,
    asyncIsarPod
  },
  allTransitiveDependencies: <ProviderOrFamily>{
    asyncApplicationDocumentsDirectoryPod,
    ...?asyncApplicationDocumentsDirectoryPod.allTransitiveDependencies,
    asyncDriftLocalDatabasePod,
    ...?asyncDriftLocalDatabasePod.allTransitiveDependencies,
    asyncHiveInitializationPod,
    ...?asyncHiveInitializationPod.allTransitiveDependencies,
    asyncIsarPod,
    ...?asyncIsarPod.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AsyncInitializationRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package