import 'dart:math';
import 'dart:ui';

import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final (hasDescription) = ref.watch(
      taskPod.select(
        (task) => task.description != null,
      ),
    );
    return BaseTaskTile(
      title: const TaskTitle(),
      subtitle: hasDescription ? const Description() : null,
      trailing: const TaskCheckbox(),
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

// ** v TASK DESCRIPTION v ** //

@visibleForTesting
class Description extends ConsumerWidget {
  const Description({
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
    final isCompleted = ref.watch(
      taskPod.select(
        (task) => task.isCompleted,
      ),
    );
    return BaseTaskCheckbox(
      isCompleted: isCompleted,
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
