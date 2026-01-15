// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_initialization_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(asyncInitialization)
final asyncInitializationPod = AsyncInitializationProvider._();

final class AsyncInitializationProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  AsyncInitializationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncInitializationPod',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[
          asyncApplicationDocumentsDirectoryPod,
          asyncTemporaryDirectoryPod,
          asyncDriftLocalDatabasePod,
          asyncHiveInitializationPod,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          AsyncInitializationProvider.$allTransitiveDependencies0,
          AsyncInitializationProvider.$allTransitiveDependencies1,
          AsyncInitializationProvider.$allTransitiveDependencies2,
          AsyncInitializationProvider.$allTransitiveDependencies3,
        },
      );

  static final $allTransitiveDependencies0 =
      asyncApplicationDocumentsDirectoryPod;
  static final $allTransitiveDependencies1 = asyncTemporaryDirectoryPod;
  static final $allTransitiveDependencies2 = asyncDriftLocalDatabasePod;
  static final $allTransitiveDependencies3 = asyncHiveInitializationPod;

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
    r'06a63750fb72efd104656213c6b5e64d4d2107eb';
