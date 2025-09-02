// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_initialization_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
        isAutoDispose: true,
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
    r'cd515118506c4b8f845cb21f9bf3dddd709a4a86';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
