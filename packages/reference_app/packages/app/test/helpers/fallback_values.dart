/*{{#use_auto_route_router}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route_router}}*/
import 'package:mocktail/mocktail.dart';
import 'package:tasks/tasks.dart';

void registerFallbackValues() {
  /*w 1v 1*/
  /*{{#use_auto_route_router}}*/
  registerFallbackValue(
    const PageRouteInfo(
      '',
    ),
  );
  /*{{/use_auto_route_router}}*/
  /*w 1v 1*/
  registerFallbackValue(
    const NewTask(
      title: 'title',
    ),
  );
}
