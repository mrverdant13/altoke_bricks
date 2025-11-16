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

@ProviderFor(autoRouteConfig)
const autoRouteConfigPod = AutoRouteConfigProvider._();

final class AutoRouteConfigProvider
    extends
        $FunctionalProvider<
          RouterConfig<UrlState>,
          RouterConfig<UrlState>,
          RouterConfig<UrlState>
        >
    with $Provider<RouterConfig<UrlState>> {
  const AutoRouteConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'autoRouteConfigPod',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[],
        $allTransitiveDependencies: const <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$autoRouteConfigHash();

  @$internal
  @override
  $ProviderElement<RouterConfig<UrlState>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RouterConfig<UrlState> create(Ref ref) {
    return autoRouteConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RouterConfig<UrlState> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RouterConfig<UrlState>>(value),
    );
  }
}

String _$autoRouteConfigHash() => r'fc12ab8aa28b7aebffa96d2cda0e942424002616';

@ProviderFor(goRouterConfig)
const goRouterConfigPod = GoRouterConfigProvider._();

final class GoRouterConfigProvider
    extends
        $FunctionalProvider<
          RouterConfig<RouteMatchList>,
          RouterConfig<RouteMatchList>,
          RouterConfig<RouteMatchList>
        >
    with $Provider<RouterConfig<RouteMatchList>> {
  const GoRouterConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goRouterConfigPod',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          counterPod,
          selectedLocalDatabasePackagePod,
          selectedRouterPackagePod,
          asyncTasksPod,
          localTasksDaoPod,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          GoRouterConfigProvider.$allTransitiveDependencies0,
          GoRouterConfigProvider.$allTransitiveDependencies1,
          GoRouterConfigProvider.$allTransitiveDependencies2,
          GoRouterConfigProvider.$allTransitiveDependencies3,
          GoRouterConfigProvider.$allTransitiveDependencies4,
          GoRouterConfigProvider.$allTransitiveDependencies5,
          GoRouterConfigProvider.$allTransitiveDependencies6,
          GoRouterConfigProvider.$allTransitiveDependencies7,
          GoRouterConfigProvider.$allTransitiveDependencies8,
        },
      );

  static const $allTransitiveDependencies0 = counterPod;
  static const $allTransitiveDependencies1 = selectedLocalDatabasePackagePod;
  static const $allTransitiveDependencies2 = selectedRouterPackagePod;
  static const $allTransitiveDependencies3 = asyncTasksPod;
  static const $allTransitiveDependencies4 =
      AsyncTasksProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies5 =
      AsyncTasksProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies6 =
      AsyncTasksProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies7 =
      AsyncTasksProvider.$allTransitiveDependencies4;
  static const $allTransitiveDependencies8 =
      AsyncTasksProvider.$allTransitiveDependencies5;

  @override
  String debugGetCreateSourceHash() => _$goRouterConfigHash();

  @$internal
  @override
  $ProviderElement<RouterConfig<RouteMatchList>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RouterConfig<RouteMatchList> create(Ref ref) {
    return goRouterConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RouterConfig<RouteMatchList> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RouterConfig<RouteMatchList>>(value),
    );
  }
}

String _$goRouterConfigHash() => r'62fa60b2b647a82fba220cdd613f5792c7fb9a2b';

@ProviderFor(routerConfig)
const routerConfigPod = RouterConfigProvider._();

final class RouterConfigProvider
    extends
        $FunctionalProvider<
          RouterConfig<Object>,
          RouterConfig<Object>,
          RouterConfig<Object>
        >
    with $Provider<RouterConfig<Object>> {
  const RouterConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerConfigPod',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          selectedRouterPackagePod,
          autoRouteConfigPod,
          goRouterConfigPod,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          RouterConfigProvider.$allTransitiveDependencies0,
          RouterConfigProvider.$allTransitiveDependencies1,
          RouterConfigProvider.$allTransitiveDependencies2,
          RouterConfigProvider.$allTransitiveDependencies3,
          RouterConfigProvider.$allTransitiveDependencies4,
          RouterConfigProvider.$allTransitiveDependencies5,
          RouterConfigProvider.$allTransitiveDependencies6,
          RouterConfigProvider.$allTransitiveDependencies7,
          RouterConfigProvider.$allTransitiveDependencies8,
          RouterConfigProvider.$allTransitiveDependencies9,
          RouterConfigProvider.$allTransitiveDependencies10,
        },
      );

  static const $allTransitiveDependencies0 = selectedRouterPackagePod;
  static const $allTransitiveDependencies1 = autoRouteConfigPod;
  static const $allTransitiveDependencies2 = goRouterConfigPod;
  static const $allTransitiveDependencies3 =
      GoRouterConfigProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies4 =
      GoRouterConfigProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies5 =
      GoRouterConfigProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies6 =
      GoRouterConfigProvider.$allTransitiveDependencies4;
  static const $allTransitiveDependencies7 =
      GoRouterConfigProvider.$allTransitiveDependencies5;
  static const $allTransitiveDependencies8 =
      GoRouterConfigProvider.$allTransitiveDependencies6;
  static const $allTransitiveDependencies9 =
      GoRouterConfigProvider.$allTransitiveDependencies7;
  static const $allTransitiveDependencies10 =
      GoRouterConfigProvider.$allTransitiveDependencies8;

  @override
  String debugGetCreateSourceHash() => _$routerConfigHash();

  @$internal
  @override
  $ProviderElement<RouterConfig<Object>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RouterConfig<Object> create(Ref ref) {
    return routerConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RouterConfig<Object> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RouterConfig<Object>>(value),
    );
  }
}

String _$routerConfigHash() => r'406e8fd9eb6e6af997c14e7855c667efe6554997';

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
