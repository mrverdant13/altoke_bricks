import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const devIdentifier = 'development';
const stgIdentifier = 'staging';
const prodIdentifier = 'production';

const devLabel = 'DEV';
const stgLabel = 'STG';
const prodLabel = 'PROD';

const isDev = appFlavor == devIdentifier || (!isStg && !isProd);
const isStg = appFlavor == stgIdentifier;
const isProd = appFlavor == prodIdentifier;

const flavorLabelsMap = {
  devIdentifier: devLabel,
  stgIdentifier: stgLabel,
  prodIdentifier: prodLabel,
};

@pragma('vm:platform-const-if', !kDebugMode)
String get flavorLabel {
  final label = flavorLabelsMap[appFlavor];
  if (label != null) return label;
  throw FlutterError('Unknown flavor: $appFlavor');
}
