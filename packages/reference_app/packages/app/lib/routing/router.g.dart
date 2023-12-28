// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRouteData,
      $counterRouteData,
      $tasksRouteData,
    ];

RouteBase get $homeRouteData => GoRouteData.$route(
      path: '/',
      name: 'HomeRoute',
      factory: $HomeRouteDataExtension._fromState,
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

RouteBase get $tasksRouteData => GoRouteData.$route(
      path: '/tasks',
      name: 'TasksRoute',
      factory: $TasksRouteDataExtension._fromState,
    );

extension $TasksRouteDataExtension on TasksRouteData {
  static TasksRouteData _fromState(GoRouterState state) =>
      const TasksRouteData();

  String get location => GoRouteData.$location(
        '/tasks',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
