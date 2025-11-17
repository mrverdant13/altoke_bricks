// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_initialization_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(asyncInitialization)
const asyncInitializationPod = AsyncInitializationProvider._();

final class AsyncInitializationProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const AsyncInitializationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncInitializationPod',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          asyncApplicationDocumentsDirectoryPod,
          asyncTemporaryDirectoryPod,
          asyncDriftLocalDatabasePod,
          asyncHiveInitializationPod,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          AsyncInitializationProvider.$allTransitiveDependencies0,
          AsyncInitializationProvider.$allTransitiveDependencies1,
          AsyncInitializationProvider.$allTransitiveDependencies2,
          AsyncInitializationProvider.$allTransitiveDependencies3,
        },
      );

  static const $allTransitiveDependencies0 =
      asyncApplicationDocumentsDirectoryPod;
  static const $allTransitiveDependencies1 = asyncTemporaryDirectoryPod;
  static const $allTransitiveDependencies2 = asyncDriftLocalDatabasePod;
  static const $allTransitiveDependencies3 = asyncHiveInitializationPod;

  @override
  String debugGetCreateSourceHash() => _$asyncInitializationHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return asyncInitialization(ref);
  }
}

String _$asyncInitializationHash() =>
    r'cea4126051151c275630ff222dfb47f9376a11c7';
