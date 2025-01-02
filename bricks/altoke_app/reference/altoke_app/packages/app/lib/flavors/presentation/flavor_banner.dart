import 'package:altoke_app/flavors/flavors.dart';
import 'package:flutter/material.dart';

class FlavorBanner extends StatelessWidget {
  const FlavorBanner({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: isProd
          ? null
          : BannerPainter(
              message: flavor.label,
              textDirection: TextDirection.ltr,
              location: BannerLocation.topStart,
              layoutDirection: TextDirection.ltr,
            ),
      child: child,
    );
  }
}
