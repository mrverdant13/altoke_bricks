// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRouteData,
      $counterRouteData,
      $tasksRouteData,
      $newTaskRouteData,
      $taskDetailsRouteData,
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

RouteBase get $newTaskRouteData => GoRouteData.$route(
      path: '/tasks/new',
      name: 'NewTaskRoute',
      factory: $NewTaskRouteDataExtension._fromState,
    );

extension $NewTaskRouteDataExtension on NewTaskRouteData {
  static NewTaskRouteData _fromState(GoRouterState state) =>
      const NewTaskRouteData();

  String get location => GoRouteData.$location(
        '/tasks/new',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $taskDetailsRouteData => GoRouteData.$route(
      path: '/tasks/:taskId',
      name: 'TaskDetailsRoute',
      factory: $TaskDetailsRouteDataExtension._fromState,
    );

extension $TaskDetailsRouteDataExtension on TaskDetailsRouteData {
  static TaskDetailsRouteData _fromState(GoRouterState state) =>
      TaskDetailsRouteData(
        taskId: int.parse(state.pathParameters['taskId']!),
      );

  String get location => GoRouteData.$location(
        '/tasks/${Uri.encodeComponent(taskId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
