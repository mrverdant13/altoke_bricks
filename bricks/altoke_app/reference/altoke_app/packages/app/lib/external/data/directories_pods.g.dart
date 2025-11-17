// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directories_pods.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(asyncApplicationDocumentsDirectory)
const asyncApplicationDocumentsDirectoryPod =
    AsyncApplicationDocumentsDirectoryProvider._();

final class AsyncApplicationDocumentsDirectoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<Directory>,
          Directory,
          FutureOr<Directory>
        >
    with $FutureModifier<Directory>, $FutureProvider<Directory> {
  const AsyncApplicationDocumentsDirectoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncApplicationDocumentsDirectoryPod',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[],
        $allTransitiveDependencies: const <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() =>
      _$asyncApplicationDocumentsDirectoryHash();

  @$internal
  @override
  $FutureProviderElement<Directory> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Directory> create(Ref ref) {
    return asyncApplicationDocumentsDirectory(ref);
  }
}

String _$asyncApplicationDocumentsDirectoryHash() =>
    r'99c980951aab80b900b1b63a3b82c50171228a5e';

@ProviderFor(asyncTemporaryDirectory)
const asyncTemporaryDirectoryPod = AsyncTemporaryDirectoryProvider._();

final class AsyncTemporaryDirectoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<Directory>,
          Directory,
          FutureOr<Directory>
        >
    with $FutureModifier<Directory>, $FutureProvider<Directory> {
  const AsyncTemporaryDirectoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncTemporaryDirectoryPod',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[],
        $allTransitiveDependencies: const <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$asyncTemporaryDirectoryHash();

  @$internal
  @override
  $FutureProviderElement<Directory> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Directory> create(Ref ref) {
    return asyncTemporaryDirectory(ref);
  }
}

String _$asyncTemporaryDirectoryHash() =>
    r'e5806eba28caa0bad6564f9ad8e33e158a825066';
