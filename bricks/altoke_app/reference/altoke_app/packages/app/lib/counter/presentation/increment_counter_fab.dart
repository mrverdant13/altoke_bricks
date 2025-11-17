import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/counter/counter.dart';
import 'package:altoke_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
/*{{#use_riverpod}}*/
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([
  Counter,
  /*x-remove-start*/
  SelectedStateManagementPackage,
  /*remove-end-x*/
])
/*{{/use_riverpod}}*/
class IncrementCounterFab extends ConsumerWidget {
  const IncrementCounterFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return FloatingActionButton(
      onPressed: () {
        /*remove-start*/
        switch (ref.read(selectedStateManagementPackagePod)) {
          case StateManagementPackage.bloc:
            /*remove-end-x*/
            /*{{#use_bloc}}x*/
            context.read<CounterBloc>().add(const CounterIncreaseRequested());
          /*x{{/use_bloc}}x*/
          /*remove-start*/
          case StateManagementPackage.riverpod:
            /*remove-end*/
            /*x{{#use_riverpod}}x*/
            ref.read(counterPod.notifier).increment();
          /*x{{/use_riverpod}}*/
          /*x-remove-start*/
        }
        /*remove-end*/
      },
      tooltip: l10n.counterIncrementButtonTooltip,
      child: const Icon(Icons.add),
    );
  }
}
