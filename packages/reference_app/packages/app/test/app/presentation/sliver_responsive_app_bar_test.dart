import 'package:altoke_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_tester.dart';

final _sliverAppBarFinder = find.byType(SliverAppBar);
final _titleFinder = find.text('Title');
final _actionFinder = find.byIcon(Icons.add);

void main() {
  group(
    '''

GIVEN a ResponsiveSliverAppBar''',
    () {
      testWidgets(
        '''

WHEN the screen height is enough
THEN the app bar floats and snaps
''',
        (tester) async {
          const screenSize = Size(600, 1200);
          await tester.binding.setSurfaceSize(screenSize);
          addTearDown(() async => tester.binding.setSurfaceSize(null));
          await tester.pumpSliverResponsiveAppBar();
          expect(_sliverAppBarFinder, findsOneWidget);
          expect(_titleFinder, findsOneWidget);
          expect(_actionFinder, findsOneWidget);
          final sliverAppBar = tester.widget<SliverAppBar>(_sliverAppBarFinder);
          expect(sliverAppBar.floating, isTrue);
          expect(sliverAppBar.snap, isTrue);
        },
      );

      testWidgets(
        '''

WHEN the screen height is not enough
THEN the app bar does not float nor snap
''',
        (tester) async {
          const screenSize = Size(600, 300);
          await tester.binding.setSurfaceSize(screenSize);
          addTearDown(() async => tester.binding.setSurfaceSize(null));
          await tester.pumpSliverResponsiveAppBar();
          expect(_sliverAppBarFinder, findsOneWidget);
          expect(_titleFinder, findsOneWidget);
          expect(_actionFinder, findsOneWidget);
          final sliverAppBar = tester.widget<SliverAppBar>(_sliverAppBarFinder);
          expect(sliverAppBar.floating, isFalse);
          expect(sliverAppBar.snap, isFalse);
        },
      );
    },
  );
}

extension on WidgetTester {
  Future<void> pumpSliverResponsiveAppBar() async {
    await pumpTestableWidget(
      Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverResponsiveAppBar(
              title: Text('Title'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: null,
                ),
              ],
            ),
            SliverLayoutBuilder(
              builder: (context, constraints) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: constraints.viewportMainAxisExtent * 2,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
