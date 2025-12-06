/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end*/
import 'package:altoke_app/counter/counter.dart';
import 'package:altoke_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
/*{{#use_bloc}}*/
import 'package:flutter_bloc/flutter_bloc.dart';
/*{{/use_bloc}}*/
/*{{#use_riverpod}}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
/*{{/use_riverpod}}*/

@Dependencies([
  Counter,
  /*remove-start*/
  SelectedStateManagementPackage,
  /*remove-end*/
])
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
@Dependencies([
  Counter,
  /*remove-start*/
  SelectedStateManagementPackage,
  /*remove-end*/
])
class PushCountMessage extends ConsumerWidget {
  const PushCountMessage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final count = /*remove-start*/ () {
      switch (ref.watch(
        selectedStateManagementPackagePod,
      )) {
        case StateManagementPackage.bloc:
          return
          /*remove-end*/
          /*{{#use_bloc}}*/
          context.watch<CounterBloc>().state;
        /*{{/use_bloc}}*/
        /*remove-start*/
        case StateManagementPackage.riverpod:
          return
          /*remove-end*/
          /*{{#use_riverpod}}*/
          ref.watch(counterPod);
        /*{{/use_riverpod}}*/
        /*remove-start*/
      }
    }(); /*remove-end*/
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

@Dependencies([
  Counter,
  /*remove-start*/
  SelectedStateManagementPackage,
  /*remove-end*/
])
@visibleForTesting
class PushCountValue extends ConsumerWidget {
  const PushCountValue({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final count = /*remove-start*/ () {
      switch (ref.watch(
        selectedStateManagementPackagePod,
      )) {
        case StateManagementPackage.bloc:
          return
          /*remove-end*/
          /*{{#use_bloc}}*/
          context.watch<CounterBloc>().state;
        /*{{/use_bloc}}*/
        /*remove-start*/
        case StateManagementPackage.riverpod:
          return
          /*remove-end*/
          /*{{#use_riverpod}}*/
          ref.watch(counterPod);
        /*{{/use_riverpod}}*/
        /*remove-start*/
      }
    }(); /*remove-end*/
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
