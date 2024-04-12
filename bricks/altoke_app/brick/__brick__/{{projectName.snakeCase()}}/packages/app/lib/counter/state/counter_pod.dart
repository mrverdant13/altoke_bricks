import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_pod.g.dart';

@Riverpod(dependencies: [])
class Counter extends _$Counter {
  @override
  int build() => 0;

  void increment() => state = state + 1;
}
