import 'package:altoke_dart_package/altoke_dart_package.dart';
import 'package:test/test.dart';

void main() {
  group(
    'AltokeDartPackage',
    () {
      test(
        'can be instantiated',
        () {
          expect(
            const AltokeDartPackage(),
            isA<AltokeDartPackage>(),
          );
        },
      );
    },
  );
}
