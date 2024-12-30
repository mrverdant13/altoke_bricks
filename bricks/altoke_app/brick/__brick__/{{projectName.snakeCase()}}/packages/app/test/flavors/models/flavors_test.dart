import 'package:{{projectName.snakeCase()}}/flavors/flavors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppFlavor isDev', () async {
    debugFlavor = AppFlavor.dev;
    addTearDown(() => debugFlavor = null);
    expect(isDev, isTrue);
  });

  test('AppFlavor isStg', () async {
    debugFlavor = AppFlavor.stg;
    addTearDown(() => debugFlavor = null);
    expect(isStg, isTrue);
  });

  test('AppFlavor isProd', () async {
    debugFlavor = AppFlavor.prod;
    addTearDown(() => debugFlavor = null);
    expect(isProd, isTrue);
  });

  group('AppFlavor flavor', () {
    test('throws when no flavor is set', () async {
      expect(() => flavor, throwsA(isA<FlutterError>()));
    });

    test('returns DEV when set as debug flavor', () async {
      debugFlavor = AppFlavor.dev;
      addTearDown(() => debugFlavor = null);
      expect(flavor, AppFlavor.dev);
    });

    test('returns STG when set as debug flavor', () async {
      debugFlavor = AppFlavor.stg;
      addTearDown(() => debugFlavor = null);
      expect(flavor, AppFlavor.stg);
    });

    test('returns PROD when set as debug flavor', () async {
      debugFlavor = AppFlavor.prod;
      addTearDown(() => debugFlavor = null);
      expect(flavor, AppFlavor.prod);
    });
  });
}
