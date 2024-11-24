// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRouteData,
    ];

RouteBase get $homeRouteData => GoRouteData.$route(
      path: '/',
      name: 'HomeRoute',
      factory: $HomeRouteDataExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'counter',
          name: 'CounterRoute',
          factory: $CounterRouteDataExtension._fromState,
        ),
      ],
    );

extension $HomeRouteDataExtension on HomeRouteData {
  static HomeRouteData _fromState(GoRouterState state) => const HomeRouteData();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

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

String _$routerConfigHash() => r'def697bc6181727eabea0f95172ae86422a39a79';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouterConfigRef = AutoDisposeProviderRef<RouterConfig<Object>>;
String _$routerPackageHash() => r'33d0056f7095601d17e81ca2ce4eac2fca1d5fd5';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouterPackageRef = AutoDisposeProviderRef<RouterPackage>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
