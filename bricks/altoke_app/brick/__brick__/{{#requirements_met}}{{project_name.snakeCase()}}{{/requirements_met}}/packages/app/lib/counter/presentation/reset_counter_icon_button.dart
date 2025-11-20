import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/l10n/l10n.dart';
import 'package:flutter/material.dart';
{{#use_bloc}}import 'package:flutter_bloc/{{#use_bloc}}flutter_bloc.dart{{/use_bloc}}';{{/use_bloc}}{{#use_riverpod}}import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';{{/use_riverpod}}

{{#use_riverpod}}@Dependencies([
  Counter,
  
]){{/use_riverpod}}
class ResetCounterIconButton extends {{#use_riverpod}}ConsumerWidget{{/use_riverpod}}{{^use_riverpod}}StatelessWidget{{/use_riverpod}} {
  const ResetCounterIconButton({super.key});

  @override
  Widget build(BuildContext context{{#use_riverpod}}, WidgetRef ref{{/use_riverpod}}) {
    final l10n = context.l10n;
    return IconButton(
      onPressed: () {
        
            {{#use_bloc}}
            context.read<CounterBloc>().add(const CounterResetRequested());
          {{/use_bloc}}
          
            {{#use_riverpod}}
            ref.read(counterPod.notifier).reset();
          {{/use_riverpod}}
          
      },
      tooltip: l10n.counterResetButtonTooltip,
      icon: const Icon(Icons.refresh),
    );
  }
}
