import 'package:{{project_name.snakeCase()}}/home/home.dart';{{#use_auto_route_router}}import 'package:auto_route/auto_route.dart';{{/use_auto_route_router}}import 'package:flutter/material.dart';{{#use_auto_route_router}}@RoutePage(
  name: 'HomeRoute',
){{/use_auto_route_router}}class HomeScreen extends StatelessWidget {
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
