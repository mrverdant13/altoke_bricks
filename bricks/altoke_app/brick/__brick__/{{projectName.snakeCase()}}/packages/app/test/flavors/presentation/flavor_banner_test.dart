import 'package:{{projectName.snakeCase()}}/flavors/flavors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('FlavorBanner', () {
    testWidgets('should conditionally display a banner', (tester) async {
      for (final flavor in AppFlavor.values) {
        debugFlavor = flavor;
        await tester.pumpAppWithScaffold(
          // Using a non-const constructor to test the widget with different
          // flavors.
          // ignore: prefer_const_constructors
          FlavorBanner(
            child: const Text('Child'),
          ),
        );
        await tester.pumpAndSettle();
        switch (flavor) {
          case AppFlavor.dev || AppFlavor.stg:
            final bannerFinder = find.byWidgetPredicate(
              (widget) {
                if (widget is! CustomPaint) return false;
                final foregroundPainter = widget.foregroundPainter;
                if (foregroundPainter is! BannerPainter) return false;
                return foregroundPainter.message == flavor.label;
              },
            );
            expect(
              bannerFinder,
              findsOneWidget,
              reason: 'Expected to find a banner with label "${flavor.label}".',
            );
          case AppFlavor.prod:
            final bannerFinder = find.byWidgetPredicate(
              (widget) {
                if (widget is! CustomPaint) return false;
                return widget.foregroundPainter == null;
              },
            );
            expect(
              bannerFinder,
              findsOneWidget,
              reason: 'Expected to find no banner.',
            );
        }
      }
      debugFlavor = null;
    });
  });
}
