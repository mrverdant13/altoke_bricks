import 'package:auto_route/auto_route.dart';
import 'package:mocktail/mocktail.dart';

class MockRoutingController extends Mock implements RoutingController {}

void registerRoutingFallbackValues() {
  registerFallbackValue(PageRouteInfo(''));
}
