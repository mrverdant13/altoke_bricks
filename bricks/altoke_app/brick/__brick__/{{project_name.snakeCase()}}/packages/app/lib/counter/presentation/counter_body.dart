import 'package:{{project_name.snakeCase()}}/counter/counter.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterBody extends StatelessWidget {
  const CounterBody({
    super.key,
  });

  @visibleForTesting
  static const textStyleChangeDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PushCountMessage(),
          PushCountValue(),
        ],
      ),
    );
  }
}

@visibleForTesting
class PushCountMessage extends ConsumerWidget {
  const PushCountMessage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final message = l10n.counterPushTimesMessage(ref.watch(counterPod));
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

@visibleForTesting
class PushCountValue extends ConsumerWidget {
  const PushCountValue({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
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
          child: Text(
            '${ref.watch(counterPod)}',
          ),
        );
      },
    );
  }
}
