/*{{#use_auto_route}}x*/
import 'package:auto_route/auto_route.dart';
import 'package:mocktail/mocktail.dart';
/*x{{/use_auto_route}}*/

void registerFallbackValues() {
  /*{{#use_auto_route}}x*/
  registerFallbackValue(const PageRouteInfo(''));
  /*x{{/use_auto_route}}*/
}
