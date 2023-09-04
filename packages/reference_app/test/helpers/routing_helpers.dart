/*{{#use_auto_route_router}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route_router}}*/
/*{{#use_go_router_router}}*/
import 'package:go_router/go_router.dart';
/*{{/use_go_router_router}}*/
import 'package:mocktail/mocktail.dart';

/*{{#use_auto_route_router}}*/
class MockRoutingController extends Mock implements RoutingController {}
/*{{/use_auto_route_router}}*/

/*{{#use_go_router_router}}*/
class MockGoRouter extends Mock implements GoRouter {}
/*{{/use_go_router_router}}*/

void registerRoutingFallbackValues() {
  /*w 1v 1*/
  /*{{#use_auto_route_router}}*/
  registerFallbackValue(const PageRouteInfo(''));
  /*{{/use_auto_route_router}}*/
  /*w 1v 1*/
}
