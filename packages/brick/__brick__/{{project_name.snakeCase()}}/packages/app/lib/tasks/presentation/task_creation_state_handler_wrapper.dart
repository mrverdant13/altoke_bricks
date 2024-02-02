import 'package:{{project_name.snakeCase()}}/routing/routing.dart';
import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';{{#use_auto_route_router}}import 'package:auto_route/auto_route.dart';{{/use_auto_route_router}}import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskCreationStateHandlerWrapper extends ConsumerWidget {
  const TaskCreationStateHandlerWrapper({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      taskCreatorPod.select(
        (asyncTaskCreated) => asyncTaskCreated.valueOrNull ?? false,
      ),
      (_, taskCreated) {
        if (!taskCreated) return;
{{#use_auto_route_router}}context.navigateTo(const TasksRoute());{{/use_auto_route_router}}{{#use_go_router_router}}const TasksRouteData().go(context);{{/use_go_router_router}}
},
    );
    return child;
  }
}
