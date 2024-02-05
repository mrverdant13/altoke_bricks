import 'package:altoke_app/tasks/tasks.dart';
import 'package:mocktail/mocktail.dart';

class MockTasksMutator extends TestableTasksMutator
    with Mock
    implements TasksMutator {
  MockTasksMutator({
    required this.initialState,
  });

  // ignore: avoid_public_notifier_properties
  final TasksMutationState initialState;

  @override
  TasksMutationState build() => initialState;
}
