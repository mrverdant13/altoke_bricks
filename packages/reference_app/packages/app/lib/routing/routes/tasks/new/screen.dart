import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:altoke_app/tasks/tasks.dart';
/*{{#use_auto_route_router}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route_router}}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

/*{{#use_auto_route_router}}*/
@RoutePage(
  name: 'NewTaskRoute',
)
/*{{/use_auto_route_router}}*/
class NewTaskScreen extends ConsumerWidget {
  const NewTaskScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      taskCreatorPod.select(
        (asyncTaskCreated) => asyncTaskCreated.valueOrNull ?? false,
      ),
      (_, taskCreated) {
        if (!taskCreated) return;
        /*w 1v w*/
        /*remove-start*/
        final routerPackage = ref.read(routerPod);
        switch (routerPackage) {
          case RouterPackage.autoRoute:
            /*remove-end*/
            /*{{#use_auto_route_router}}*/
            context.navigateTo(const TasksRoute());
          /*{{/use_auto_route_router}}*/
          /*remove-start*/
          case RouterPackage.goRouter: /*remove-end*/
            /*{{#use_go_router_router}}*/
            const TasksRouteData().go(context);
          /*{{/use_go_router_router}}*/
          /*remove-start*/
        } /*remove-end*/
        /*w 1v w*/
      },
    );
    return ReactiveFormBuilder(
      form: TaskFormGroup.new,
      builder: (context, formGroup, child) => child!,
      child: Scaffold(
        appBar: AppBar(elevation: 0, toolbarHeight: 0),
        body: const CustomScrollView(
          slivers: [
            SliverResponsiveAppBar(
              // TODO(mrverdant13): Localize.
              title: Text('New Task'),
            ),
            SliverPadding(
              padding: EdgeInsets.all(15),
              sliver: SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 100),
                  child: TaskForm(),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: const AddTaskFab(),
      ),
    );
  }
}
