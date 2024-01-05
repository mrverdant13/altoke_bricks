// cspell:ignore appbar
import 'package:flutter/material.dart';

class SliverResponsiveAppBar extends StatelessWidget {
  const SliverResponsiveAppBar({
    this.title,
    this.actions,
    super.key,
  });

  /// {@macro flutter.material.appbar.title}
  final Widget? title;

  /// {@macro flutter.material.appbar.actions}
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final floating = screenHeight > 400;
    return SliverAppBar(
      floating: floating,
      title: title,
      actions: actions,
    );
  }
}
