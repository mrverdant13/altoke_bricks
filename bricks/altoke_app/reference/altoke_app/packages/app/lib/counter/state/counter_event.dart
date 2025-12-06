part of 'counter_bloc.dart';

sealed class CounterEvent {
  const CounterEvent();
}

@MappableClass()
final class CounterIncreaseRequested extends CounterEvent
    with CounterIncreaseRequestedMappable {
  const CounterIncreaseRequested();
}

@MappableClass()
final class CounterResetRequested extends CounterEvent
    with CounterResetRequestedMappable {
  const CounterResetRequested();
}
