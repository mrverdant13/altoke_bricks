import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

@visibleForTesting
enum AppFlavor {
  dev('development', 'DEV'),
  stg('staging', 'STG'),
  prod('production', 'PROD')
  ;

  const AppFlavor(this.identifier, this.label);

  final String identifier;
  final String label;
}

AppFlavor? _debugFlavor;

@visibleForTesting
AppFlavor? get debugFlavor => _debugFlavor;

@visibleForTesting
set debugFlavor(AppFlavor? value) {
  // coverage:ignore-start
  if (!kDebugMode) {
    throw FlutterError('Cannot modify `debugFlavor` in non-debug builds.');
  }
  // coverage:ignore-end
  _debugFlavor = value;
}

@pragma('vm:platform-const-if', !kDebugMode)
@pragma('vm:prefer-inline')
@pragma('dart2js:prefer-inline')
AppFlavor get flavor {
  AppFlavor? flavor;
  if (AppFlavor.dev.identifier == appFlavor) flavor = AppFlavor.dev;
  if (AppFlavor.stg.identifier == appFlavor) flavor = AppFlavor.stg;
  if (AppFlavor.prod.identifier == appFlavor) flavor = AppFlavor.prod;
  if (kDebugMode && debugFlavor != null) flavor = debugFlavor;
  if (flavor != null) return flavor;
  throw FlutterError(
    'Unknown flavor.\n'
    '<${appFlavor ?? ''}> was not recognized as a flavor identifier.\n'
    'Consider updating the list of `AppFlavor`s to include this platform.',
  );
}

@pragma('vm:platform-const-if', !kDebugMode)
@pragma('vm:prefer-inline')
@pragma('dart2js:prefer-inline')
bool get isDev => flavor == AppFlavor.dev;

@pragma('vm:platform-const-if', !kDebugMode)
@pragma('vm:prefer-inline')
@pragma('dart2js:prefer-inline')
bool get isStg => flavor == AppFlavor.stg;

@pragma('vm:platform-const-if', !kDebugMode)
@pragma('vm:prefer-inline')
@pragma('dart2js:prefer-inline')
bool get isProd => flavor == AppFlavor.prod;
