// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncDriftLocalDatabaseHash() =>
    r'3acd52622330646468ea5cd9b4bf4726398303ad';

/// See also [asyncDriftLocalDatabase].
@ProviderFor(asyncDriftLocalDatabase)
final asyncDriftLocalDatabasePod =
    AutoDisposeFutureProvider<LocalDatabase>.internal(
  asyncDriftLocalDatabase,
  name: r'asyncDriftLocalDatabasePod',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncDriftLocalDatabaseHash,
  dependencies: <ProviderOrFamily>[
    asyncApplicationDocumentsDirectoryPod,
    asyncTemporaryDirectoryPod
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    asyncApplicationDocumentsDirectoryPod,
    ...?asyncApplicationDocumentsDirectoryPod.allTransitiveDependencies,
    asyncTemporaryDirectoryPod,
    ...?asyncTemporaryDirectoryPod.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AsyncDriftLocalDatabaseRef
    = AutoDisposeFutureProviderRef<LocalDatabase>;
String _$asyncHiveInitializationHash() =>
    r'a73dd6f3d1f37f5bee2b68d48d4ed0dd50bf16b3';

/// See also [asyncHiveInitialization].
@ProviderFor(asyncHiveInitialization)
final asyncHiveInitializationPod = AutoDisposeFutureProvider<void>.internal(
  asyncHiveInitialization,
  name: r'asyncHiveInitializationPod',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncHiveInitializationHash,
  dependencies: <ProviderOrFamily>[asyncApplicationDocumentsDirectoryPod],
  allTransitiveDependencies: <ProviderOrFamily>{
    asyncApplicationDocumentsDirectoryPod,
    ...?asyncApplicationDocumentsDirectoryPod.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AsyncHiveInitializationRef = AutoDisposeFutureProviderRef<void>;
String _$asyncIsarHash() => r'ed4e3f359a22f34c3f7b283b034721c22fe59c9d';

/// See also [asyncIsar].
@ProviderFor(asyncIsar)
final asyncIsarPod = AutoDisposeFutureProvider<Isar>.internal(
  asyncIsar,
  name: r'asyncIsarPod',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$asyncIsarHash,
  dependencies: <ProviderOrFamily>[asyncApplicationDocumentsDirectoryPod],
  allTransitiveDependencies: <ProviderOrFamily>{
    asyncApplicationDocumentsDirectoryPod,
    ...?asyncApplicationDocumentsDirectoryPod.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AsyncIsarRef = AutoDisposeFutureProviderRef<Isar>;
String _$selectedLocalDatabasePackageHash() =>
    r'05bcf0ffd220fe4a6144ea95453dc7b0d487104b';

/// See also [SelectedLocalDatabasePackage].
@ProviderFor(SelectedLocalDatabasePackage)
final selectedLocalDatabasePackagePod = NotifierProvider<
    SelectedLocalDatabasePackage, LocalDatabasePackage>.internal(
  SelectedLocalDatabasePackage.new,
  name: r'selectedLocalDatabasePackagePod',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedLocalDatabasePackageHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

typedef _$SelectedLocalDatabasePackage = Notifier<LocalDatabasePackage>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
