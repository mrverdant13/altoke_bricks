/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end-x*/
import 'package:altoke_app/counter/counter.dart';
import 'package:altoke_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
/*{{#use_bloc}}x*/
import 'package:flutter_bloc/flutter_bloc.dart';
/*x{{/use_bloc}}x*/
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
class ResetCounterIconButton extends ConsumerWidget {
  const ResetCounterIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return IconButton(
      onPressed: () {
        /*remove-start*/
        final selectedStateManagementPackage = ref.read(
          selectedStateManagementPackagePod,
        );
        switch (selectedStateManagementPackage) {
          case StateManagementPackage.bloc:
            /*remove-end*/
            /*{{#use_bloc}}*/
            context.read<CounterBloc>().add(const CounterResetRequested());
          /*{{/use_bloc}}*/
          /*remove-start*/
          case StateManagementPackage.riverpod:
            /*remove-end*/
            /*{{#use_riverpod}}*/
            ref.invalidate(counterPod);
          /*{{/use_riverpod}}*/
          /*remove-start*/
        } /*remove-end*/
      },
      tooltip: l10n.counterResetButtonTooltip,
      icon: const Icon(Icons.refresh),
    );
  }
}
