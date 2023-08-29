import 'package:altoke_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class SliverCounterBody extends StatelessWidget {
  const SliverCounterBody({
    required this.count,
    super.key,
  });

  final int count;

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: textTheme.bodyMedium!.copyWith(
                      fontSize: pushMessageFontSize,
                    ),
                    child: Text(
                      l10n.counterPushTimesMessage(count),
                      key: const Key(
                        '<counter::sliver-counter-body::push-count-message>',
                      ),
                    ),
                  ),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: textTheme.titleMedium!.copyWith(
                      fontSize: countFontSize,
                    ),
                    child: Text(
                      '$count',
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
