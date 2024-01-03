import 'package:altoke_app/counter/counter.dart';
import 'package:altoke_app/tasks/tasks.dart';
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
