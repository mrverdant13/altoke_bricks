import 'package:{{#requirements_met}}local_database{{/requirements_met}}/{{#requirements_met}}local_database{{/requirements_met}}.dart';
import 'package:test/test.dart';

void main() {
  group('$UpdateTaskFailureNotFound', () {
    test('can be instantiated', () {
      const failure = UpdateTaskFailureNotFound(taskId: 1);
      expect(failure, isA<UpdateTaskFailureNotFound>());
    });

    test('is a subclass of $UpdateTaskFailure', () {
      const failure = UpdateTaskFailureNotFound(taskId: 1);
      expect(failure, isA<UpdateTaskFailure>());
    });

    test('has a readable string representation', () {
      const failure = UpdateTaskFailureNotFound(taskId: 1);
      expect(failure.toString(), 'UpdateTaskFailureNotFound(taskId: 1)');
    });
  });

  group('$UpdateTaskFailureInvalidData', () {
    test('can be instantiated without validation errors', () {
      const failure = UpdateTaskFailureInvalidData(
        titleValidationErrors: {},
        complexValidationErrors: {},
      );
      expect(failure, isA<UpdateTaskFailureInvalidData>());
    });

    test('is a subclass of $UpdateTaskFailure', () {
      const failure = UpdateTaskFailureInvalidData(
        titleValidationErrors: {},
        complexValidationErrors: {},
      );
      expect(failure, isA<UpdateTaskFailure>());
    });

    test('can be instantiated with validation errors', () {
      const titleValidationErrors = {TaskTitleValidationError.empty};
      const complexValidationErrors = {
        TaskComplexValidationError.highPriorityWithNoDescription,
      };
      const failure = UpdateTaskFailureInvalidData(
        titleValidationErrors: titleValidationErrors,
        complexValidationErrors: complexValidationErrors,
      );
      expect(failure.titleValidationErrors, titleValidationErrors);
      expect(failure.complexValidationErrors, complexValidationErrors);
    });

    test('has a readable string representation', () {
      const titleValidationErrors = {TaskTitleValidationError.empty};
      const complexValidationErrors = {
        TaskComplexValidationError.highPriorityWithNoDescription,
      };
      const failure = UpdateTaskFailureInvalidData(
        titleValidationErrors: titleValidationErrors,
        complexValidationErrors: complexValidationErrors,
      );
      expect(
        failure.toString(),
        'UpdateTaskFailureInvalidData('
        'titleValidationErrors: $titleValidationErrors, '
        'complexValidationErrors: $complexValidationErrors'
        ')',
      );
    });
  });
}
