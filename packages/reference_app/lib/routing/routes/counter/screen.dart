import 'package:altoke_app/counter/counter.dart';
/*{{#use_auto_route_router}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route_router}}*/
import 'package:flutter/material.dart';

/*{{#use_auto_route_router}}*/
@RoutePage(
  name: 'CounterRoute',
)
/*{{/use_auto_route_router}}*/
class CounterScreen extends StatefulWidget {
  const CounterScreen({
    super.key,
  });

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @visibleForTesting
  int counter = 0;

  @visibleForTesting
  void incrementCounter() => setState(() => counter++);

  @visibleForTesting
  static const maxContentWidth = 1200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverLayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.crossAxisExtent;
              const contentLateralSpacer = SliverCrossAxisExpanded(
                flex: 1,
                sliver: SliverToBoxAdapter(),
              );
              return SliverCrossAxisGroup(
                slivers: [
                  if (width > maxContentWidth) contentLateralSpacer,
                  SliverConstrainedCrossAxis(
                    maxExtent: maxContentWidth,
                    sliver: SliverMainAxisGroup(
                      slivers: [
                        const SliverCounterAppBar(),
                        SliverCounterBody(count: counter),
                      ],
                    ),
                  ),
                  if (width > maxContentWidth) contentLateralSpacer,
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final rightPadding =
              ((width - maxContentWidth) / 2).clamp(0.0, double.infinity);
          return Padding(
            padding: EdgeInsets.only(right: rightPadding),
            child: CounterFab(
              onTap: incrementCounter,
            ),
          );
        },
      ),
    );
  }
}
