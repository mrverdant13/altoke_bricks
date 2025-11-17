// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(asyncDriftLocalDatabase)
const asyncDriftLocalDatabasePod = AsyncDriftLocalDatabaseProvider._();

final class AsyncDriftLocalDatabaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<LocalDatabase>,
          LocalDatabase,
          FutureOr<LocalDatabase>
        >
    with $FutureModifier<LocalDatabase>, $FutureProvider<LocalDatabase> {
  const AsyncDriftLocalDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncDriftLocalDatabasePod',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          asyncApplicationDocumentsDirectoryPod,
          asyncTemporaryDirectoryPod,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          AsyncDriftLocalDatabaseProvider.$allTransitiveDependencies0,
          AsyncDriftLocalDatabaseProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 =
      asyncApplicationDocumentsDirectoryPod;
  static const $allTransitiveDependencies1 = asyncTemporaryDirectoryPod;

  @override
  String debugGetCreateSourceHash() => _$asyncDriftLocalDatabaseHash();

  @$internal
  @override
  $FutureProviderElement<LocalDatabase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LocalDatabase> create(Ref ref) {
    return asyncDriftLocalDatabase(ref);
  }
}

String _$asyncDriftLocalDatabaseHash() =>
    r'bfb674a2270c3a4f8d3d09f6f4bda895aea2040a';

@ProviderFor(asyncHiveInitialization)
const asyncHiveInitializationPod = AsyncHiveInitializationProvider._();

final class AsyncHiveInitializationProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const AsyncHiveInitializationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncHiveInitializationPod',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          asyncApplicationDocumentsDirectoryPod,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          AsyncHiveInitializationProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 =
      asyncApplicationDocumentsDirectoryPod;

  @override
  String debugGetCreateSourceHash() => _$asyncHiveInitializationHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return asyncHiveInitialization(ref);
  }
}

String _$asyncHiveInitializationHash() =>
    r'912c756b8016c1a13b72eb69fdcca2eaf82cae20';

@ProviderFor(SelectedLocalDatabasePackage)
const selectedLocalDatabasePackagePod =
    SelectedLocalDatabasePackageProvider._();

final class SelectedLocalDatabasePackageProvider
    extends
        $NotifierProvider<SelectedLocalDatabasePackage, LocalDatabasePackage> {
  const SelectedLocalDatabasePackageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedLocalDatabasePackagePod',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[],
        $allTransitiveDependencies: const <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$selectedLocalDatabasePackageHash();

  @$internal
  @override
  SelectedLocalDatabasePackage create() => SelectedLocalDatabasePackage();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalDatabasePackage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalDatabasePackage>(value),
    );
  }
}

String _$selectedLocalDatabasePackageHash() =>
    r'05bcf0ffd220fe4a6144ea95453dc7b0d487104b';

abstract class _$SelectedLocalDatabasePackage
    extends $Notifier<LocalDatabasePackage> {
  LocalDatabasePackage build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<LocalDatabasePackage, LocalDatabasePackage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LocalDatabasePackage, LocalDatabasePackage>,
              LocalDatabasePackage,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
