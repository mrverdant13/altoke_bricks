import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

@pragma('vm:platform-const-if', !kDebugMode)
bool get isDev => flavor == AppFlavor.dev;

@pragma('vm:platform-const-if', !kDebugMode)
bool get isStg => flavor == AppFlavor.stg;

@pragma('vm:platform-const-if', !kDebugMode)
bool get isProd => flavor == AppFlavor.prod;

@visibleForTesting
enum AppFlavor {
  dev('development', 'DEV'),
  stg('staging', 'STG'),
  prod('production', 'PROD');

  const AppFlavor(this.identifier, this.label);

  final String identifier;
  final String label;
}

@pragma('vm:platform-const-if', !kDebugMode)
AppFlavor get flavor {
  AppFlavor? flavor;
  flavor = [
    ...AppFlavor.values,
    null,
  ].firstWhere(
    (flavor) => flavor?.identifier == appFlavor,
  );
  if (kDebugMode && debugFlavor != null) flavor = debugFlavor;
  if (flavor != null) return flavor;
  throw FlutterError(
    'Unknown flavor.\n'
    '<${appFlavor ?? ''}> was not recognized as a flavor identifier.\n'
    'Consider updating the list of `AppFlavor`s to include this platform.',
  );
}

@visibleForTesting
AppFlavor? get debugFlavor => _debugFlavor;

@visibleForTesting
set debugFlavor(AppFlavor? value) {
  // coverage:ignore-start
  if (!kDebugMode) {
    throw FlutterError(
      'Cannot modify `debugFlavor` in non-debug builds.',
    );
  }
  // coverage:ignore-end
  _debugFlavor = value;
}

AppFlavor? _debugFlavor;
