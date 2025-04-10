import 'dart:async';

import 'package:altoke_common/common.dart';
import 'package:altoke_reactive_caches/src/immediate_firer_stream.dart';
import 'package:test/test.dart';

void main() {
  group('ImmediateFirerStream', () {
    late StreamController<int> controller;

    setUp(() {
      controller = StreamController<int>.broadcast(sync: true);
    });

    tearDown(() {
      controller.close();
    });

    ImmediateFirerStream<int> buildSubject({
      Optional<int> Function()? computeInitialValue,
    }) {
      return ImmediateFirerStream(
        controller.stream,
        computeInitialValue: computeInitialValue ?? () => const None(),
      );
    }

    test('emits the latest value on each new subscription', () async {
      final values1 = <int>[];
      final stream = buildSubject(
        computeInitialValue:
            () => values1.isEmpty ? const None<int>() : Some<int>(values1.last),
      );
      final sub1 = stream.listen(values1.add);
      addTearDown(sub1.cancel);
      await Future.microtask(() {});
      expect(values1, isEmpty);
      controller
        ..add(1)
        ..add(2);
      expect(values1, [1, 2]);
      final values2 = <int>[];
      final sub2 = stream.listen(values2.add);
      addTearDown(sub2.cancel);
      await Future.microtask(() {});
      controller
        ..add(3)
        ..add(4);
      expect(values1, [1, 2, 3, 4]);
      expect(values2, [2, 3, 4]);
    });

    test('emits the latest value, '
        'ignoring latest error, '
        'on each new subscription', () async {
      final values1 = <Object>[];
      final stream = buildSubject(
        computeInitialValue: () {
          final values = values1.whereType<({int value})>();
          return values.isEmpty
              ? const None<int>()
              : Some<int>(values.last.value);
        },
      );
      final sub1 = stream.listen(
        (value) => values1.add((value: value)),
        onError: (Object error, StackTrace stack) {
          values1.add((error: error));
        },
      );
      addTearDown(sub1.cancel);
      await Future.microtask(() {});
      expect(values1, isEmpty);
      controller
        ..add(1)
        ..addError('1');
      expect(values1, [(value: 1), (error: '1')]);
      final values2 = <Object>[];
      final sub2 = stream.listen(
        (value) => values2.add((value: value)),
        onError: (Object error, StackTrace stack) {
          values2.add((error: error));
        },
      );
      addTearDown(sub2.cancel);
      await Future.microtask(() {});
      controller
        ..add(2)
        ..addError('2');
      expect(values1, [(value: 1), (error: '1'), (value: 2), (error: '2')]);
      expect(values2, [(value: 1), (value: 2), (error: '2')]);
    });

    test('closes all listeners and '
        'cancels subscription '
        'when source stream is done', () async {
      final stream = buildSubject();
      final sub = stream.listen((_) {});
      addTearDown(sub.cancel);
      final listeners = stream.currentListeners;
      expect(listeners, isNotEmpty);
      expect(listeners.any((l) => l.isClosed), isFalse);
      final cachedListeners = [...listeners];
      expect(stream.sourceSubscription, isNotNull);
      await controller.close();
      expect(listeners, isEmpty);
      expect(cachedListeners.every((l) => l.isClosed), isTrue);
      expect(stream.sourceSubscription, isNull);
    });

    test('disallows new listeners and '
        'cancels subscription '
        'when source stream is done', () async {
      final stream = buildSubject();
      final sub1 = stream.listen((_) {});
      addTearDown(sub1.cancel);
      expect(stream.currentListeners, isNotEmpty);
      expect(stream.sourceSubscription, isNotNull);
      await controller.close();
      expect(stream.currentListeners, isEmpty);
      expect(stream.sourceSubscription, isNull);
      final sub2 = stream.listen((_) {});
      addTearDown(sub2.cancel);
      expect(stream.currentListeners, isEmpty);
      expect(stream.sourceSubscription, isNull);
    });
  });
}
