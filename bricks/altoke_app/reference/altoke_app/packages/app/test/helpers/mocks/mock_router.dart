/*{{#use_auto_route}}x*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route}}x*/
/*x{{#use_go_router}}x*/
import 'package:go_router/go_router.dart';
/*{{/use_go_router}}x*/
import 'package:mocktail/mocktail.dart';

/*{{#use_auto_route}}x*/
class MockStackRouter extends Mock implements StackRouter {}
/*x{{/use_auto_route}}*/

/*{{#use_go_router}}x*/
class MockGoRouter extends Mock implements GoRouter {}

/*x{{/use_go_router}}*/
