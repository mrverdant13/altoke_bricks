import 'package:altoke_app/counter/counter.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$CounterBloc', () {
    CounterBloc buildSubjectBloc() {
      return CounterBloc();
    }

    test('initial state is 0', () {
      final bloc = buildSubjectBloc();
      addTearDown(bloc.close);
      expect(bloc.state, isZero);
    });

    group('$CounterIncreaseRequested', () {
      blocTest<CounterBloc, int>(
        'increments the counter',
        build: buildSubjectBloc,
        act: (bloc) => bloc.add(const CounterIncreaseRequested()),
        expect: () => [1],
      );
    });

    group('$CounterResetRequested', () {
      blocTest<CounterBloc, int>(
        'resets the counter',
        build: buildSubjectBloc,
        seed: () => 100,
        act: (bloc) => bloc.add(const CounterResetRequested()),
        expect: () => [0],
      );
    });
  });
}
