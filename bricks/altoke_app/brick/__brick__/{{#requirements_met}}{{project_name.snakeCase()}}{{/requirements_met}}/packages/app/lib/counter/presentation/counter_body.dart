
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/l10n/l10n.dart';
import 'package:flutter/material.dart';
{{#use_bloc}}
import 'package:flutter_bloc/{{#use_bloc}}flutter_bloc.dart{{/use_bloc}}';
{{/use_bloc}}
{{#use_riverpod}}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
{{/use_riverpod}}

{{#use_riverpod}}@Dependencies([
  Counter,
  
]){{/use_riverpod}}
class CounterBody extends StatelessWidget {
  const CounterBody({super.key});

  @visibleForTesting
  static const textStyleChangeDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [PushCountMessage(), PushCountValue()],
      ),
    );
  }
}

@visibleForTesting
{{#use_riverpod}}@Dependencies([
  Counter,
  
]){{/use_riverpod}}
class PushCountMessage extends {{#use_riverpod}}ConsumerWidget{{/use_riverpod}}{{^use_riverpod}}StatelessWidget{{/use_riverpod}} {
  const PushCountMessage({super.key});

  @override
  Widget build(BuildContext context{{#use_riverpod}}, WidgetRef ref{{/use_riverpod}}) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final count = 
          {{#use_bloc}}
          context.watch<CounterBloc>().state;
        {{/use_bloc}}
        
          {{#use_riverpod}}
          ref.watch(counterPod);
        {{/use_riverpod}}
        
    final message = l10n.counterPushTimesMessage(count);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final fontSize = switch (width) {
          _ when width > 700 => 30.0,
          _ => 20.0,
        };
        return AnimatedDefaultTextStyle(
          duration: CounterBody.textStyleChangeDuration,
          style: textTheme.bodyMedium!.copyWith(fontSize: fontSize),
          textAlign: TextAlign.center,
          child: Text(message),
        );
      },
    );
  }
}

{{#use_riverpod}}@Dependencies([
  Counter,
  
]){{/use_riverpod}}
@visibleForTesting
class PushCountValue extends {{#use_riverpod}}ConsumerWidget{{/use_riverpod}}{{^use_riverpod}}StatelessWidget{{/use_riverpod}} {
  const PushCountValue({super.key});

  @override
  Widget build(BuildContext context{{#use_riverpod}}, WidgetRef ref{{/use_riverpod}}) {
    final textTheme = Theme.of(context).textTheme;
    final count = 
          {{#use_bloc}}
          context.watch<CounterBloc>().state;
        {{/use_bloc}}
        
          {{#use_riverpod}}
          ref.watch(counterPod);
        {{/use_riverpod}}
        
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final fontSize = switch (width) {
          _ when width > 700 => 90.0,
          _ => 60.0,
        };
        return AnimatedDefaultTextStyle(
          duration: CounterBody.textStyleChangeDuration,
          style: textTheme.titleMedium!.copyWith(fontSize: fontSize),
          textAlign: TextAlign.center,
          child: Text('$count'),
        );
      },
    );
  }
}
