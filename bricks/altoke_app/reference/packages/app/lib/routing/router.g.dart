// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $counterRouteData,
    ];

RouteBase get $counterRouteData => GoRouteData.$route(
      path: '/counter',
      name: 'CounterRoute',
      factory: $CounterRouteDataExtension._fromState,
    );

extension $CounterRouteDataExtension on CounterRouteData {
  static CounterRouteData _fromState(GoRouterState state) =>
      const CounterRouteData();

  String get location => GoRouteData.$location(
        '/counter',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerConfigHash() => r'a419152c10fed59bffc329a8ed36f59184143fa2';

/// See also [routerConfig].
@ProviderFor(routerConfig)
final routerConfigPod = AutoDisposeProvider<RouterConfig<Object>>.internal(
  routerConfig,
  name: r'routerConfigPod',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$routerConfigHash,
  dependencies: <ProviderOrFamily>[routerPackagePod],
  allTransitiveDependencies: <ProviderOrFamily>{
    routerPackagePod,
    ...?routerPackagePod.allTransitiveDependencies
  },
);

typedef RouterConfigRef = AutoDisposeProviderRef<RouterConfig<Object>>;
String _$routerPackageHash() => r'462f30517db605ee3e598a947c6c5fe98564b1c0';

/// See also [routerPackage].
@ProviderFor(routerPackage)
final routerPackagePod = AutoDisposeProvider<RouterPackage>.internal(
  routerPackage,
  name: r'routerPackagePod',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routerPackageHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

typedef RouterPackageRef = AutoDisposeProviderRef<RouterPackage>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
