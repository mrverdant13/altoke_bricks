import 'package:local_database/local_database.dart';
import 'package:test/test.dart';

void main() {
  group('$CreateTaskFailureInvalidData', () {
    test(
      'can be instantiated without validation errors',
      () {
        const failure = CreateTaskFailureInvalidData(
          titleValidationErrors: {},
          complexValidationErrors: {},
        );
        expect(failure, isA<CreateTaskFailureInvalidData>());
      },
    );

    test(
      'is a subclass of $CreateTaskFailure',
      () {
        const failure = CreateTaskFailureInvalidData(
          titleValidationErrors: {},
          complexValidationErrors: {},
        );
        expect(failure, isA<CreateTaskFailure>());
      },
    );

    test(
      'can be instantiated with validation errors',
      () {
        const titleValidationErrors = {
          TaskTitleValidationError.empty,
        };
        const complexValidationErrors = {
          TaskComplexValidationError.highPriorityWithNoDescription,
        };
        const failure = CreateTaskFailureInvalidData(
          titleValidationErrors: titleValidationErrors,
          complexValidationErrors: complexValidationErrors,
        );
        expect(failure.titleValidationErrors, titleValidationErrors);
        expect(failure.complexValidationErrors, complexValidationErrors);
      },
    );

    test(
      'has a readable string representation',
      () {
        const titleValidationErrors = {
          TaskTitleValidationError.empty,
        };
        const complexValidationErrors = {
          TaskComplexValidationError.highPriorityWithNoDescription,
        };
        const failure = CreateTaskFailureInvalidData(
          titleValidationErrors: titleValidationErrors,
          complexValidationErrors: complexValidationErrors,
        );
        expect(
          failure.toString(),
          'CreateTaskFailureInvalidData('
          'titleValidationErrors: $titleValidationErrors, '
          'complexValidationErrors: $complexValidationErrors'
          ')',
        );
      },
    );
  });
}
