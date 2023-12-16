import 'package:{{project_name.snakeCase()}}/counter/counter.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SliverCounterBody extends StatelessWidget {
  const SliverCounterBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.crossAxisExtent;
        final pushMessageFontSize = switch (width) {
          _ when width > 700 => 30.0,
          _ => 20.0,
        };
        final countFontSize = switch (width) {
          _ when width > 700 => 90.0,
          _ => 60.0,
        };
        return SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: DefaultTextStyle.merge(
              textAlign: TextAlign.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: textTheme.bodyMedium!.copyWith(
                      fontSize: pushMessageFontSize,
                    ),
                    child: Consumer(
                      builder: (context, ref, _) => Text(
                        l10n.counterPushTimesMessage(
                          ref.watch(counterPod),
                        ),
                        key: const Key(
                          '<counter::sliver-counter-body::push-count-message>',
                        ),
                      ),
                    ),
                  ),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: textTheme.titleMedium!.copyWith(
                      fontSize: countFontSize,
                    ),
                    child: Consumer(
                      builder: (context, ref, _) => Text(
                        '${ref.watch(counterPod)}',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
