import 'dart:developer';

{{#use_auto_route}}import 'package:auto_route/auto_route.dart';
{{/use_auto_route}}import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';{{#use_go_router}}
import 'package:go_router/go_router.dart';{{/use_go_router}}

typedef UriRecord = ({DateTime timestamp, Uri uri});

class NavigatorUriListener extends StatefulWidget {
  const NavigatorUriListener({
    required this.router,
    required this.child,
    super.key,
  });

  final Router<Object> router;
  final Widget child;

  @override
  State<NavigatorUriListener> createState() => _NavigatorUriListenerState();
}

class _NavigatorUriListenerState extends State<NavigatorUriListener> {
  {{#use_auto_route}}AutoRouterDelegate{{/use_auto_route}}{{#use_go_router}}GoRouterDelegate{{/use_go_router}} get delegate => widget.router.routerDelegate {{#use_auto_route}}as AutoRouterDelegate{{/use_auto_route}}{{#use_go_router}}as GoRouterDelegate{{/use_go_router}};

  UriRecord? _lastUriRecord;

  @override
  void initState() {
    super.initState();
    delegate.addListener(logUri);
  }

  @override
  void dispose() {
    delegate.removeListener(logUri);
    super.dispose();
  }

  void logUri() {
    if (!kDebugMode) return;
    {{#use_auto_route}}final uri = delegate.currentConfiguration!.uri;{{/use_auto_route}}{{#use_go_router}}final uri = delegate.currentConfiguration.uri;{{/use_go_router}}
    if (uri == _lastUriRecord?.uri) return;
    final timestamp = DateTime.now();
    _lastUriRecord = (timestamp: timestamp, uri: uri);
    log('($timestamp) Uri: $uri', name: 'Routing', time: timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
