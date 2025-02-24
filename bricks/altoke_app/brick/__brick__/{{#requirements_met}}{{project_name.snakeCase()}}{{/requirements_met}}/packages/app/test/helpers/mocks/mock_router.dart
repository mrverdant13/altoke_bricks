{{#use_auto_route}}import 'package:auto_route/auto_route.dart';
{{/use_auto_route}}{{#use_go_router}}import 'package:go_router/go_router.dart';
{{/use_go_router}}import 'package:mocktail/mocktail.dart';

{{#use_auto_route}}class MockStackRouter extends Mock implements StackRouter {}{{/use_auto_route}}

{{#use_go_router}}class MockGoRouter extends Mock implements GoRouter {}{{/use_go_router}}
