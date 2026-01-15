// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedStateManagementPackage)
final selectedStateManagementPackagePod =
    SelectedStateManagementPackageProvider._();

final class SelectedStateManagementPackageProvider
    extends
        $NotifierProvider<
          SelectedStateManagementPackage,
          StateManagementPackage
        > {
  SelectedStateManagementPackageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedStateManagementPackagePod',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[],
        $allTransitiveDependencies: <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$selectedStateManagementPackageHash();

  @$internal
  @override
  SelectedStateManagementPackage create() => SelectedStateManagementPackage();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StateManagementPackage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StateManagementPackage>(value),
    );
  }
}

String _$selectedStateManagementPackageHash() =>
    r'8bfbe3e61c2138c37cace5f6aff0b096264141bd';

abstract class _$SelectedStateManagementPackage
    extends $Notifier<StateManagementPackage> {
  StateManagementPackage build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<StateManagementPackage, StateManagementPackage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StateManagementPackage, StateManagementPackage>,
              StateManagementPackage,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
