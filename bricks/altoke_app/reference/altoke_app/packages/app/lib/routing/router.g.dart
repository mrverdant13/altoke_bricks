// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$homeRouteData];

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
    GoRouteData.$route(
      path: 'tasks',
      name: 'TasksRoute',
      factory: $TasksRouteDataExtension._fromState,
    ),
  ],
);

extension $HomeRouteDataExtension on HomeRouteData {
  static HomeRouteData _fromState(GoRouterState state) => const HomeRouteData();

  String get location => GoRouteData.$location('/');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CounterRouteDataExtension on CounterRouteData {
  static CounterRouteData _fromState(GoRouterState state) =>
      const CounterRouteData();

  String get location => GoRouteData.$location('/counter');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TasksRouteDataExtension on TasksRouteData {
  static TasksRouteData _fromState(GoRouterState state) =>
      const TasksRouteData();

  String get location => GoRouteData.$location('/tasks');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerConfigHash() => r'24a584aa2ad828533c22efdbfecd842ce35ff6f7';

/// See also [routerConfig].
@ProviderFor(routerConfig)
final routerConfigPod = AutoDisposeProvider<RouterConfig<Object>>.internal(
  routerConfig,
  name: r'routerConfigPod',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$routerConfigHash,
  dependencies: <ProviderOrFamily>[selectedRouterPackagePod],
  allTransitiveDependencies: <ProviderOrFamily>{
    selectedRouterPackagePod,
    ...?selectedRouterPackagePod.allTransitiveDependencies,
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
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$selectedRouterPackageHash,
      dependencies: const <ProviderOrFamily>[],
      allTransitiveDependencies: const <ProviderOrFamily>{},
    );

typedef _$SelectedRouterPackage = Notifier<RouterPackage>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
