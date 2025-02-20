import 'package:altoke_app/counter/counter.dart';
/*remove-start*/
import 'package:altoke_app/tasks/tasks.dart';
/*remove-end*/
/*w 1v w*/
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        CounterExampleListTile(),
        /*remove-start*/
        TasksExampleListTile(),
        /*remove-end*/
        /*w 1v 6> w*/
      ],
    );
  }
}
