import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/l10n/l10n.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends AppBar {
  HomeAppBar({super.key})
      : super(
          title: const HomeAppBarTitle(),
        );
}

@visibleForTesting
class HomeAppBarTitle extends StatelessWidget {
  const HomeAppBarTitle({
    super.key,
  });

  static const textKey = Key('<home::home-app-bar-title::text>');

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Text(
      l10n.homeAppBarTitle,
      key: textKey,
    );
  }
}
