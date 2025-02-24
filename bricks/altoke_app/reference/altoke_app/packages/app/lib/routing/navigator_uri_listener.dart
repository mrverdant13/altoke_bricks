import 'dart:developer';

/*{{#use_auto_route}}x*/
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
/*{{/use_auto_route}}x*/
import 'package:flutter/material.dart';
/*x{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
/*x{{/use_go_router}}*/

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
  /*replace-start*/
  RouterDelegate<dynamic>
  /*with*/
  // /*{{#use_auto_route}}x*/
  // AutoRouterDelegate
  // /*x{{/use_auto_route}}x*/
  // /*x{{#use_go_router}}x*/
  // GoRouterDelegate
  // /*x{{/use_go_router}}*/
  /*replace-end*/
  /*w 1> w*/
  get delegate => widget.router.routerDelegate
  /*insert-start*/
  // /*w 1> w*/
  // /*x{{#use_auto_route}}x*/
  // as AutoRouterDelegate
  // /*x{{/use_auto_route}}x*/
  // /*x{{#use_go_router}}x*/
  // as GoRouterDelegate
  // /*x{{/use_go_router}}x*/
  /*insert-end*/;

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
    /*replace-start*/
    final delegate = this.delegate;
    final uri = switch (delegate) {
      AutoRouterDelegate() => delegate.currentConfiguration!.uri,
      GoRouterDelegate() => delegate.currentConfiguration.uri,
      _ => throw UnimplementedError(),
    };
    /*with*/
    // /*{{#use_auto_route}}x*/
    // final uri = delegate.currentConfiguration!.uri;
    // /*x{{/use_auto_route}}x*/
    // /*x{{#use_go_router}}x*/
    // final uri = delegate.currentConfiguration.uri;
    // /*x{{/use_go_router}}*/
    /*replace-end*/
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
