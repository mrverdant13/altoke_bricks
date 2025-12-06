// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$homeRouteData];

RouteBase get $homeRouteData => GoRouteData.$route(
  path: '/',
  name: 'HomeRoute',
  factory: $HomeRouteData._fromState,
  routes: [
    GoRouteData.$route(
      path: 'counter',
      name: 'CounterRoute',
      factory: $CounterRouteData._fromState,
    ),
    GoRouteData.$route(
      path: 'tasks',
      name: 'TasksRoute',
      factory: $TasksRouteData._fromState,
    ),
  ],
);

mixin $HomeRouteData on GoRouteData {
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

mixin $CounterRouteData on GoRouteData {
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

mixin $TasksRouteData on GoRouteData {
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

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedRouterPackage)
const selectedRouterPackagePod = SelectedRouterPackageProvider._();

final class SelectedRouterPackageProvider
    extends $NotifierProvider<SelectedRouterPackage, RouterPackage> {
  const SelectedRouterPackageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedRouterPackagePod',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[],
        $allTransitiveDependencies: const <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$selectedRouterPackageHash();

  @$internal
  @override
  SelectedRouterPackage create() => SelectedRouterPackage();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RouterPackage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RouterPackage>(value),
    );
  }
}

String _$selectedRouterPackageHash() =>
    r'2e08d6a2b92e21e304e7e0ea4a0bd63b35ecf662';

abstract class _$SelectedRouterPackage extends $Notifier<RouterPackage> {
  RouterPackage build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<RouterPackage, RouterPackage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RouterPackage, RouterPackage>,
              RouterPackage,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
