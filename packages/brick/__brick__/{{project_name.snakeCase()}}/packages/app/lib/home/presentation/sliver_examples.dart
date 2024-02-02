import 'package:{{project_name.snakeCase()}}/counter/counter.dart';
import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';
import 'package:flutter/widgets.dart';

class SliverExamples extends StatelessWidget {
  const SliverExamples({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: const [
        CounterExampleTile(),
        TasksExampleTile(),
      ],
    );
  }
}
