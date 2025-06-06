// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$homeRouteData];

RouteBase get $homeRouteData => GoRouteData.$route(
  path: '/',
  name: 'HomeRoute',

  factory: _$HomeRouteData._fromState,
  routes: [
    GoRouteData.$route(
      path: 'counter',
      name: 'CounterRoute',

      factory: _$CounterRouteData._fromState,
    ),
    GoRouteData.$route(
      path: 'tasks',
      name: 'TasksRoute',

      factory: _$TasksRouteData._fromState,
    ),
  ],
);

mixin _$HomeRouteData on GoRouteData {
  static HomeRouteData _fromState(GoRouterState state) => const HomeRouteData();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$CounterRouteData on GoRouteData {
  static CounterRouteData _fromState(GoRouterState state) =>
      const CounterRouteData();

  @override
  String get location => GoRouteData.$location('/counter');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$TasksRouteData on GoRouteData {
  static TasksRouteData _fromState(GoRouterState state) =>
      const TasksRouteData();

  @override
  String get location => GoRouteData.$location('/tasks');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$autoRouteConfigHash() => r'fc12ab8aa28b7aebffa96d2cda0e942424002616';

/// See also [autoRouteConfig].
@ProviderFor(autoRouteConfig)
final autoRouteConfigPod = AutoDisposeProvider<RouterConfig<UrlState>>.internal(
  autoRouteConfig,
  name: r'autoRouteConfigPod',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$autoRouteConfigHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AutoRouteConfigRef = AutoDisposeProviderRef<RouterConfig<UrlState>>;
String _$goRouterConfigHash() => r'36abcb131ca29d324161a8c15ca16812458b9c2c';

/// See also [goRouterConfig].
@ProviderFor(goRouterConfig)
final goRouterConfigPod =
    AutoDisposeProvider<RouterConfig<RouteMatchList>>.internal(
      goRouterConfig,
      name: r'goRouterConfigPod',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$goRouterConfigHash,
      dependencies: const <ProviderOrFamily>[],
      allTransitiveDependencies: const <ProviderOrFamily>{},
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GoRouterConfigRef =
    AutoDisposeProviderRef<RouterConfig<RouteMatchList>>;
String _$routerConfigHash() => r'406e8fd9eb6e6af997c14e7855c667efe6554997';

/// See also [routerConfig].
@ProviderFor(routerConfig)
final routerConfigPod = AutoDisposeProvider<RouterConfig<Object>>.internal(
  routerConfig,
  name: r'routerConfigPod',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routerConfigHash,
  dependencies: <ProviderOrFamily>[
    selectedRouterPackagePod,
    autoRouteConfigPod,
    goRouterConfigPod,
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    selectedRouterPackagePod,
    ...?selectedRouterPackagePod.allTransitiveDependencies,
    autoRouteConfigPod,
    ...?autoRouteConfigPod.allTransitiveDependencies,
    goRouterConfigPod,
    ...?goRouterConfigPod.allTransitiveDependencies,
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouterConfigRef = AutoDisposeProviderRef<RouterConfig<Object>>;
String _$selectedRouterPackageHash() =>
    r'2e08d6a2b92e21e304e7e0ea4a0bd63b35ecf662';

/// See also [SelectedRouterPackage].
@ProviderFor(SelectedRouterPackage)
final selectedRouterPackagePod =
    NotifierProvider<SelectedRouterPackage, RouterPackage>.internal(
      SelectedRouterPackage.new,
      name: r'selectedRouterPackagePod',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedRouterPackageHash,
      dependencies: const <ProviderOrFamily>[],
      allTransitiveDependencies: const <ProviderOrFamily>{},
    );

typedef _$SelectedRouterPackage = Notifier<RouterPackage>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
