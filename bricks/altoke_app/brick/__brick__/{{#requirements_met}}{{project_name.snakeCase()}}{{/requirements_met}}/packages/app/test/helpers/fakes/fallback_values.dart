{{#use_auto_route}}import 'package:auto_route/auto_route.dart';
import 'package:mocktail/mocktail.dart';{{/use_auto_route}}

void registerFallbackValues() {
  {{#use_auto_route}}registerFallbackValue(const PageRouteInfo(''));{{/use_auto_route}}
}
