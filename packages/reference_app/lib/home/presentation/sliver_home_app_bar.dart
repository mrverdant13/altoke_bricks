import 'package:altoke_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class SliverHomeAppBar extends StatelessWidget {
  const SliverHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SliverAppBar(
      title: Text(
        l10n.homeAppBarTitle,
        key: const Key('<counter::sliver-home-app-bar::title>'),
      ),
      floating: true,
    );
  }
}
