import 'package:altoke_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class SliverCounterAppBar extends StatelessWidget {
  const SliverCounterAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SliverAppBar(
      title: Text(l10n.counterAppBarTitle),
      floating: true,
    );
  }
}
