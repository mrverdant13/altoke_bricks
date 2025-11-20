import 'dart:math' as math;

/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end*/
import 'package:altoke_app/counter/counter.dart';
/*x{{#use_auto_route}}*/
import 'package:auto_route/auto_route.dart';
/*x{{/use_auto_route}}*/
import 'package:flutter/material.dart';
/*{{#use_bloc}}*/
import 'package:flutter_bloc/flutter_bloc.dart';
/*{{/use_bloc}}*/
/*{{#use_riverpod}}*/
import 'package:riverpod_annotation/experimental/scope.dart';
/*{{/use_riverpod}}*/

@Dependencies([
  Counter,
  /*remove-start*/
  SelectedStateManagementPackage,
  /*remove-end*/
])
/*{{#use_auto_route}}x*/
@RoutePage(name: 'CounterRoute')
/*{{/use_auto_route}}x*/
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @visibleForTesting
  static const maxContentWidth = 1200.0;

  @override
  Widget build(BuildContext context) {
    final counterAppBar = CounterAppBar();
    return /*{{#use_bloc}}*/ BlocProvider(
      create: (context) => CounterBloc(),
      child: /*{{/use_bloc}}*/ Scaffold(
        appBar: PreferredSize(
          preferredSize: counterAppBar.preferredSize,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: maxContentWidth),
              child: counterAppBar,
            ),
          ),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxContentWidth),
            child: const CounterBody(),
          ),
        ),
        floatingActionButton: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final padding = math.max<double>(0, (width - maxContentWidth) / 2);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: const IncrementCounterFab(),
            );
          },
        ),
      ) /*{{#use_bloc}}*/,
    )
    /*{{/use_bloc}}*/
    ;
  }
}
