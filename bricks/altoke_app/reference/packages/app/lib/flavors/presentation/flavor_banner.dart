import 'package:altoke_app/flavors/flavors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FlavorBanner extends StatelessWidget {
  const FlavorBanner({
    required this.child,
    super.key,
  });

  final Widget child;

  @pragma('vm:platform-const-if', !kDebugMode)
  BannerPainter? get bannerPainter => isProd
      ? null
      : BannerPainter(
          message: flavor.label,
          textDirection: TextDirection.ltr,
          location: BannerLocation.topStart,
          layoutDirection: TextDirection.ltr,
        );

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: bannerPainter,
      child: child,
    );
  }
}
