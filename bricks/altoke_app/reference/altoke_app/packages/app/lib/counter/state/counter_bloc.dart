import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_bloc.mapper.dart';
part 'counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncreaseRequested>(
      _onCounterIncreaseRequested,
      transformer: droppable(),
    );
    on<CounterResetRequested>(
      _onCounterResetRequested,
      transformer: droppable(),
    );
  }

  void _onCounterIncreaseRequested(
    CounterIncreaseRequested event,
    Emitter<int> emit,
  ) {
    emit(state + 1);
  }

  void _onCounterResetRequested(
    CounterResetRequested event,
    Emitter<int> emit,
  ) {
    emit(0);
  }
}
