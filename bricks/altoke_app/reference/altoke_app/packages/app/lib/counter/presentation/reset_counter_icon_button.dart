import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/counter/counter.dart';
import 'package:altoke_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([
  Counter,
  /*x-remove-start*/
  SelectedStateManagementPackage,
  /*remove-end-x*/
])
class ResetCounterIconButton extends ConsumerWidget {
  const ResetCounterIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return IconButton(
      onPressed: () {
        /*remove-start*/
        switch (ref.read(selectedStateManagementPackagePod)) {
          case StateManagementPackage.bloc:
            /*remove-end-x*/
            /*{{#use_bloc}}x*/
            context.read<CounterBloc>().add(const CounterResetRequested());
          /*x{{/use_bloc}}x*/
          /*remove-start*/
          case StateManagementPackage.riverpod:
            /*remove-end*/
            /*x{{#use_riverpod}}x*/
            ref.invalidate(counterPod);
          /*x{{/use_riverpod}}*/
          /*x-remove-start*/
        }
        /*remove-end*/
      },
      tooltip: l10n.counterResetButtonTooltip,
      icon: const Icon(Icons.refresh),
    );
  }
}
