import 'package:altoke_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends AppBar {
  HomeAppBar({
    super.key,
  });

  @override
  State<AppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<AppBar> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppBar(
      title: Text(
        l10n.homeAppBarTitle,
        key: const Key('<home::home-app-bar::title>'),
      ),
    );
  }
}
