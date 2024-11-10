// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_initialization_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncInitializationHash() =>
    r'93487d1f495c19d075beee627edda6f6918fa396';

/// See also [asyncInitialization].
@ProviderFor(asyncInitialization)
final asyncInitializationPod = AutoDisposeFutureProvider<void>.internal(
  asyncInitialization,
  name: r'asyncInitializationPod',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncInitializationHash,
  dependencies: <ProviderOrFamily>[
    asyncApplicationDocumentsDirectoryPod,
    asyncDriftLocalDatabasePod,
    asyncIsarPod
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    asyncApplicationDocumentsDirectoryPod,
    ...?asyncApplicationDocumentsDirectoryPod.allTransitiveDependencies,
    asyncDriftLocalDatabasePod,
    ...?asyncDriftLocalDatabasePod.allTransitiveDependencies,
    asyncIsarPod,
    ...?asyncIsarPod.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AsyncInitializationRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
