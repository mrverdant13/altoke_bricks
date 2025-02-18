import 'package:altoke_app/counter/counter.dart';
import 'package:mocktail/mocktail.dart';

class MockCounter extends CounterBase with Mock implements Counter {
  MockCounter([this.testBuild]);

  // This is required for the mock only.
  // ignore: avoid_public_notifier_properties
  final int Function()? testBuild;

  @override
  int build() {
    return testBuild?.call() ?? (throw UnimplementedError());
  }
}
