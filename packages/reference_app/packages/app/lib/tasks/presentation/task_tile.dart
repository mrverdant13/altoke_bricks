import 'dart:math';

import 'package:altoke_app/routing/routing.dart';
import 'package:altoke_app/tasks/tasks.dart';
/*{{#use_auto_route_router}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route_router}}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/tasks.dart';

@visibleForTesting
const opacityWhenCompleted = 0.6;

// ** v TASK TILE v ** //

class TaskTile extends ConsumerWidget {
  const TaskTile({
    super.key,
  });

  const factory TaskTile.skeleton() = SkeletonTaskTile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasDescription = ref.watch(
      taskPod.select(
        (task) => task.description != null,
      ),
    );
    final isLoading = ref.watch(
      tasksMutatorPod.select(
        (state) => state.isLoading,
      ),
    );
    return AbsorbPointer(
      absorbing: isLoading,
      child: DismissibleWrapper(
        child: BaseTaskTile(
          title: const TaskTitle(),
          subtitle: hasDescription ? const TaskDescription() : null,
          trailing: const TaskCheckbox(),
          onTap: () {
            final taskId = ref.read(taskPod).id;
            /*remove-start*/
            final routerPackage = ref.read(routerPod);
            switch (routerPackage) {
              case RouterPackage.autoRoute:
                /*remove-end*/
                /*{{#use_auto_route_router}}*/
                context.navigateTo(TaskDetailsRoute(taskId: taskId));
              /*{{/use_auto_route_router}}*/
              /*remove-start*/
              case RouterPackage.goRouter: /*remove-end*/
                /*{{#use_go_router_router}}*/
                TaskDetailsRouteData(taskId: taskId).go(context);
              /*{{/use_go_router_router}}*/
              /*remove-start*/
            } /*remove-end*/
            /*w 1v w*/
          },
        ),
      ),
    );
  }
}

class SkeletonTaskTile extends TaskTile {
  const SkeletonTaskTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const BaseTaskTile(
      title: SkeletonTaskTitle(),
      trailing: SkeletonTaskCheckbox(),
    );
  }
}

@visibleForTesting
class BaseTaskTile extends TaskTile {
  const BaseTaskTile({
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    super.key,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return ListTile(
          dense: width < 400,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          onTap: onTap,
        );
      },
    );
  }
}

// ** ^ TASK TILE ^ ** //

// ** v TASK TITLE v ** //

@visibleForTesting
class TaskTitle extends ConsumerStatefulWidget {
  const TaskTitle({
    super.key,
  });

  @override
  ConsumerState<TaskTitle> createState() => _TaskTitleState();
}

class _TaskTitleState extends ConsumerState<TaskTitle> {
  @override
  Widget build(BuildContext context) {
    final (title, isCompleted) = ref.watch(
      taskPod.select(
        (task) => (task.title, task.isCompleted),
      ),
    );
    final style = DefaultTextStyle.of(context).style;
    final color =
        isCompleted ? style.color?.withOpacity(opacityWhenCompleted) : null;
    return Text(
      title,
      style: style.copyWith(
        color: color,
        decoration: isCompleted ? TextDecoration.lineThrough : null,
        decorationColor: color,
      ),
    );
  }
}

@visibleForTesting
class SkeletonTaskTitle extends TaskTitle {
  const SkeletonTaskTitle({
    super.key,
  });

  @override
  SkeletonTaskTitleState createState() => SkeletonTaskTitleState();
}

@visibleForTesting
class SkeletonTaskTitleState extends _TaskTitleState
    with SingleTickerProviderStateMixin {
  late final String placeholder;
  late final AnimationController controller;

  static final random = Random();

  @override
  void initState() {
    super.initState();
    placeholder = List.generate(
      random.nextInt(5) + 3,
      (_) => '█' * (random.nextInt(4) + 2),
    ).join(' ');
    controller = AnimationController(
      vsync: this,
      lowerBound: 0.2,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(context).style;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final color = style.color?.withOpacity(controller.value);
        return Text(
          placeholder,
          style: style.copyWith(
            color: color,
            letterSpacing: 0.275,
            fontFeatures: const [
              FontFeature.tabularFigures(),
            ],
          ),
        );
      },
    );
  }
}

// ** ^ TASK TITLE ^ ** //

// ** v DISMISSIBLE WRAPPER v ** //

@visibleForTesting
class DismissibleWrapper extends ConsumerStatefulWidget {
  const DismissibleWrapper({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  ConsumerState<DismissibleWrapper> createState() => _DismissibleWrapperState();
}

class _DismissibleWrapperState extends ConsumerState<DismissibleWrapper> {
  late bool isBeingDeleted;

  @override
  void initState() {
    super.initState();
    isBeingDeleted = false;
  }

  @visibleForTesting
  void onDismissed(DismissDirection dismissDirection) {
    if (!mounted) return;
    final taskId = ref.read(taskPod).id;
    ref.read(tasksMutatorPod.notifier).deleteTask(taskId: taskId);
    isBeingDeleted = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (isBeingDeleted) return const SizedBox.shrink();
    final taskId = ref.watch(
      taskPod.select(
        (task) => task.id,
      ),
    );
    return Dismissible(
      key: ValueKey('<tasks:dismissible-wrapper:task-$taskId>'),
      background: const SizedBox.shrink(),
      secondaryBackground: ColoredBox(
        color: theme.colorScheme.error,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.delete_outlined),
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: onDismissed,
      child: widget.child,
    );
  }
}

// ** ^ DISMISSIBLE WRAPPER ^ ** //

// ** v TASK DESCRIPTION v ** //

@visibleForTesting
class TaskDescription extends ConsumerWidget {
  const TaskDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = DefaultTextStyle.of(context).style;
    final description = ref.watch(
      taskPod.select(
        (task) => task.description,
      ),
    );
    if (description == null) return const SizedBox.shrink();
    final isCompleted = ref.watch(
      taskPod.select(
        (task) => task.isCompleted,
      ),
    );
    final color =
        isCompleted ? style.color?.withOpacity(opacityWhenCompleted) : null;
    return Text(
      description,
      style: style.copyWith(
        color: color,
        decoration: isCompleted ? TextDecoration.lineThrough : null,
        decorationColor: color,
      ),
    );
  }
}

// ** ^ TASK DESCRIPTION ^ ** //

// ** v TASK CHECKBOX v ** //

@visibleForTesting
class TaskCheckbox extends ConsumerStatefulWidget {
  const TaskCheckbox({
    super.key,
  });

  @override
  ConsumerState<TaskCheckbox> createState() => _TaskCheckboxState();
}

class _TaskCheckboxState extends ConsumerState<TaskCheckbox> {
  @override
  Widget build(BuildContext context) {
    final (taskId, isCompleted) = ref.watch(
      taskPod.select(
        (task) => (task.id, task.isCompleted),
      ),
    );
    final isBeingUpdated = ref.watch(
      tasksMutatorPod.select(
        (state) => state.isLoading,
      ),
    );
    return BaseTaskCheckbox(
      isCompleted: isCompleted,
      onChanged: isBeingUpdated
          ? null
          : (isCompleted) {
              if (isCompleted == null) return;
              final partial = PartialTask(isCompleted: () => isCompleted);
              ref
                  .read(tasksMutatorPod.notifier)
                  .updateTask(taskId: taskId, partialTask: partial);
            },
    );
  }
}

@visibleForTesting
class SkeletonTaskCheckbox extends TaskCheckbox {
  const SkeletonTaskCheckbox({
    super.key,
  });

  @override
  SkeletonTaskCheckboxState createState() => SkeletonTaskCheckboxState();
}

@visibleForTesting
class SkeletonTaskCheckboxState extends _TaskCheckboxState
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(context).style;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final color = style.color?.withOpacity(controller.value);
        return CheckboxTheme(
          data: CheckboxThemeData(
            fillColor: MaterialStateProperty.all(color),
          ),
          child: const BaseTaskCheckbox(
            isCompleted: false,
          ),
        );
      },
    );
  }
}

@visibleForTesting
class BaseTaskCheckbox extends TaskCheckbox {
  const BaseTaskCheckbox({
    required this.isCompleted,
    this.onChanged,
    super.key,
  });

  final bool isCompleted;
  final ValueChanged<bool?>? onChanged;

  @override
  BaseTaskCheckboxState createState() => BaseTaskCheckboxState();
}

@visibleForTesting
class BaseTaskCheckboxState extends ConsumerState<BaseTaskCheckbox> {
  @override
  Widget build(BuildContext context) {
    final isCompleted = widget.isCompleted;
    final onChanged = widget.onChanged;
    final theme = Theme.of(context);
    final color = isCompleted
        ? theme.colorScheme.primary.withOpacity(opacityWhenCompleted)
        : null;
    return Checkbox.adaptive(
      value: isCompleted,
      activeColor: color,
      onChanged: onChanged,
    );
  }
}

// ** ^ TASK CHECKBOX ^ ** //
