import 'dart:async';

import 'package:{{#requirements_met}}reactive_caches{{/requirements_met}}/src/immediate_firer_stream.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN an stream
WHEN the stream is promoted to an immediate firer
THEN the stream should result in an immediate firer
''',
    () {
      final controller = StreamController<int>();
      final stream = controller.stream.asImmediateFirer();
      expect(stream, isA<ImmediateFirerStream<int>>());
    },
  );

  group(
    '''

GIVEN an immediate firer stream
''',
    () {
      test(
        '''

WHEN the stream is subscribed to
THEN the latest value is immediately emitted
''',
        () async {
          final controller = StreamController<int>(sync: true);
          final stream = ImmediateFirerStream(controller.stream);
          final values1 = <int>[];
          final sub1 = stream.listen(values1.add);
          await Future.microtask(() {});
          expect(values1, isEmpty);
          controller
            ..add(1)
            ..add(2);
          expect(values1, [1, 2]);
          final values2 = <int>[];
          final sub2 = stream.listen(values2.add);
          await Future.microtask(() {});
          controller
            ..add(3)
            ..add(4);
          expect(values1, [1, 2, 3, 4]);
          expect(values2, [2, 3, 4]);
          await [sub1.cancel(), sub2.cancel()].wait;
        },
      );

      test(
        '''

WHEN the stream is subscribed to
AND an error is emitted
THEN the latest value is immediately emitted
AND the error should be forwarded and emitted
''',
        () async {
          final controller = StreamController<int>(sync: true);
          final stream = ImmediateFirerStream(controller.stream);
          final values1 = <Object>[];
          final sub1 = stream.listen(
            (value) => values1.add((value: value)),
            onError: (Object error, StackTrace stack) {
              values1.add((error: error));
            },
          );
          await Future.microtask(() {});
          expect(
            values1,
            isEmpty,
          );
          controller
            ..add(1)
            ..addError('1');
          expect(
            values1,
            [
              (value: 1),
              (error: '1'),
            ],
          );
          final values2 = <Object>[];
          final sub2 = stream.listen(
            (value) => values2.add((value: value)),
            onError: (Object error, StackTrace stack) {
              values2.add((error: error));
            },
          );
          await Future.microtask(() {});
          controller
            ..add(2)
            ..addError('2');
          expect(
            values1,
            [
              (value: 1),
              (error: '1'),
              (value: 2),
              (error: '2'),
            ],
          );
          expect(values2, [
            (value: 1),
            (value: 2),
            (error: '2'),
          ]);
          await [
            sub1.cancel(),
            sub2.cancel(),
          ].wait;
        },
      );

      test(
        '''

WHEN the source stream is done
THEN the listeners should be closed
AND the subscription should be canceled
''',
        () async {
          final controller = StreamController<int>(sync: true);
          final stream = ImmediateFirerStream(controller.stream);
          final sub = stream.listen((_) {});
          final listeners = stream.currentListeners;
          expect(listeners, isNotEmpty);
          for (final listener in listeners) {
            expect(listener.isClosed, isFalse);
          }
          final cachedListeners = [...listeners];
          expect(stream.sourceSubscription, isNotNull);
          expect(stream.sourceSubscription, isNotNull);
          await controller.close();
          expect(listeners, isEmpty);
          for (final listener in cachedListeners) {
            expect(listener.isClosed, isTrue);
          }
          expect(stream.sourceSubscription, isNull);
          await sub.cancel();
        },
      );

      test(
        '''

WHEN the source stream is done
THEN no listeners should be able to be added
AND the subscription should be canceled
''',
        () async {
          final controller = StreamController<int>.broadcast(sync: true);
          final stream = ImmediateFirerStream(controller.stream);
          final sub1 = stream.listen((_) {});
          expect(stream.currentListeners, isNotEmpty);
          expect(stream.sourceSubscription, isNotNull);
          await controller.close();
          expect(stream.currentListeners, isEmpty);
          expect(stream.sourceSubscription, isNull);
          final sub2 = stream.listen((_) {});
          expect(stream.currentListeners, isEmpty);
          expect(stream.sourceSubscription, isNull);
          await [
            sub1.cancel(),
            sub2.cancel(),
          ].wait;
        },
      );
    },
  );
}
