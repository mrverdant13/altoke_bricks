import 'package:altoke_app/home/home.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage(
  name: 'HomeRoute',
)
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

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
              const maxContentWidth = 700.0;
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
                        SliverHomeAppBar(),
                        SliverExamples(),
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
    );
  }
}
