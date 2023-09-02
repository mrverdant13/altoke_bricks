import 'package:auto_route/auto_route.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockRoutingController extends Mock implements RoutingController {}

class MockGoRouter extends Mock implements GoRouter {}

void registerRoutingFallbackValues() {
  registerFallbackValue(const PageRouteInfo(''));
}
