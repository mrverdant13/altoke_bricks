import 'package:altoke_app/home/home.dart';
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
