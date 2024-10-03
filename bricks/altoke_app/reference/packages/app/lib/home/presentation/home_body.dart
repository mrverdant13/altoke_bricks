import 'package:altoke_app/counter/counter.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        CounterExampleListTile(),
      ],
    );
  }
}
