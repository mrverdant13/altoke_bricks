// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directories_pods.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(asyncApplicationDocumentsDirectory)
final asyncApplicationDocumentsDirectoryPod =
    AsyncApplicationDocumentsDirectoryProvider._();

final class AsyncApplicationDocumentsDirectoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<Directory>,
          Directory,
          FutureOr<Directory>
        >
    with $FutureModifier<Directory>, $FutureProvider<Directory> {
  AsyncApplicationDocumentsDirectoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncApplicationDocumentsDirectoryPod',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[],
        $allTransitiveDependencies: <ProviderOrFamily>[],
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
    r'8388d657a90c1871ddc558f0c0dacd50065a0f8f';

@ProviderFor(asyncTemporaryDirectory)
final asyncTemporaryDirectoryPod = AsyncTemporaryDirectoryProvider._();

final class AsyncTemporaryDirectoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<Directory>,
          Directory,
          FutureOr<Directory>
        >
    with $FutureModifier<Directory>, $FutureProvider<Directory> {
  AsyncTemporaryDirectoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncTemporaryDirectoryPod',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[],
        $allTransitiveDependencies: <ProviderOrFamily>[],
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
    r'c382a38a3426e6356a4ee2dd8485aff5bc5875a0';
