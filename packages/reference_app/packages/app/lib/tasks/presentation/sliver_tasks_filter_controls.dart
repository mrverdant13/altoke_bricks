import 'dart:async';

import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/tasks.dart';

class SliverTasksFilterControls extends ConsumerWidget {
  const SliverTasksFilterControls({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.crossAxisExtent;
        return Theme(
          data: theme.copyWith(
            inputDecorationTheme: theme.inputDecorationTheme.copyWith(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              filled: true,
              border: const OutlineInputBorder(),
              isDense: width < 400,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
            ),
          ),
          child: SliverToBoxAdapter(
            child: ColoredBox(
              color: theme.scaffoldBackgroundColor,
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TasksContentFilterTextField(),
                    SizedBox(height: 15),
                    TasksStatusFilterDropdown(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

@visibleForTesting
class TasksContentFilterTextField extends ConsumerStatefulWidget {
  const TasksContentFilterTextField({
    super.key,
  });

  @override
  ConsumerState<TasksContentFilterTextField> createState() =>
      _TasksContentFilterTextFieldState();
}

class _TasksContentFilterTextFieldState
    extends ConsumerState<TasksContentFilterTextField> {
  Timer? debounceTimer;

  @override
  void dispose() {
    debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        // TODO(mrverdant13): Localize.
        labelText: 'Search by content',
        // TODO(mrverdant13): Localize.
        hintText: 'Search by content',
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            left: 15,
            right: 5,
          ),
          child: Icon(Icons.search, size: 16),
        ),
        prefixIconConstraints: BoxConstraints(),
      ),
      onChanged: (searchTerm) {
        debounceTimer?.cancel();
        debounceTimer = Timer(
          const Duration(milliseconds: 500),
          () {
            if (!context.mounted) return;
            ref.read(taskSearchTermPod.notifier).searchTerm = searchTerm.trim();
          },
        );
      },
    );
  }
}

@visibleForTesting
class TasksStatusFilterDropdown extends ConsumerWidget {
  const TasksStatusFilterDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
        value: ref.watch(selectedTasksStatusFilterPod),
        items: [
          for (final filter in TasksStatusFilter.values)
            DropdownMenuItem<TasksStatusFilter>(
              value: filter,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(filter.icon, size: 16),
                  const SizedBox(width: 5),
                  Text(filter.label),
                ],
              ),
            ),
        ],
        onChanged: (filter) {
          if (filter == null) return;
          ref.read(selectedTasksStatusFilterPod.notifier).filter = filter;
        },
        decoration: const InputDecoration(
          // TODO(mrverdant13): Localize.
          labelText: 'Search by status',
          // TODO(mrverdant13): Localize.
          hintText: 'Search by status',
        ),
      ),
    );
  }
}

extension on TasksStatusFilter {
  String get label {
    switch (this) {
      case TasksStatusFilter.all:
        // TODO(mrverdant13): Localize.
        return 'All';
      case TasksStatusFilter.uncompleted:
        // TODO(mrverdant13): Localize.
        return 'Uncompleted';
      case TasksStatusFilter.completed:
        // TODO(mrverdant13): Localize.
        return 'Completed';
    }
  }

  IconData get icon {
    switch (this) {
      case TasksStatusFilter.all:
        return Icons.filter_list_off;
      case TasksStatusFilter.uncompleted:
        return Icons.check_box_outline_blank;
      case TasksStatusFilter.completed:
        return Icons.check_box;
    }
  }
}
