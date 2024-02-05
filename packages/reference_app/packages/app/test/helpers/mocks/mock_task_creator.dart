import 'package:altoke_app/tasks/tasks.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskCreator extends TestableTaskCreator
    with Mock
    implements TaskCreator {
  MockTaskCreator({
    required this.initialState,
  });

  // ignore: avoid_public_notifier_properties
  final bool initialState;

  @override
  Future<bool> build() async => initialState;
}
