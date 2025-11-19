/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end*/
import 'package:altoke_app/counter/counter.dart';
import 'package:altoke_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
/*x{{#use_bloc}}x*/
import 'package:flutter_bloc/flutter_bloc.dart';
/*x{{/use_bloc}}*/
/*x{{#use_riverpod}}x*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
/*x{{/use_riverpod}}*/

@Dependencies([
  Counter,
  /*remove-start*/
  SelectedStateManagementPackage,
  /*remove-end*/
])
class IncrementCounterFab extends ConsumerWidget {
  const IncrementCounterFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return FloatingActionButton(
      onPressed: () {
        /*remove-start*/
        final selectedStateManagementPackage = ref.read(
          selectedStateManagementPackagePod,
        );
        switch (selectedStateManagementPackage) {
          case StateManagementPackage.bloc:
            /*remove-end*/
            /*{{#use_bloc}}*/
            context.read<CounterBloc>().add(const CounterIncreaseRequested());
          /*{{/use_bloc}}*/
          /*remove-start*/
          case StateManagementPackage.riverpod:
            /*remove-end*/
            /*{{#use_riverpod}}*/
            ref.read(counterPod.notifier).increment();
          /*{{/use_riverpod}}*/
          /*remove-start*/
        } /*remove-end*/
      },
      tooltip: l10n.counterIncrementButtonTooltip,
      child: const Icon(Icons.add),
    );
  }
}
