

import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/app/app.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/flavors/flavors.dart';{{#use_auto_route}}
import 'package:auto_route/auto_route.dart';{{/use_auto_route}}
{{#use_bloc}}
import 'package:bloc_test/bloc_test.dart';{{/use_bloc}}

import 'package:flutter/material.dart';
{{#use_bloc}}
import 'package:flutter_bloc/{{#use_bloc}}flutter_bloc.dart{{/use_bloc}}';
{{/use_bloc}}
{{#use_riverpod}}
import 'package:flutter_riverpod/flutter_riverpod.dart';{{/use_riverpod}}
import 'package:flutter_test/flutter_test.dart';{{#use_go_router}}
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';{{/use_go_router}}
{{#use_bloc}}
import 'package:mocktail/mocktail.dart';
{{/use_bloc}}
{{#use_riverpod}}
import 'package:riverpod_annotation/experimental/scope.dart';{{/use_riverpod}}

import '../../helpers/helpers.dart';

{{#use_bloc}}
class _MockAppInitializationBloc
    extends MockBloc<AppInitializationEvent, AppInitializationState>
    implements AppInitializationBloc {}


{{/use_bloc}}

{{#use_riverpod}}@Dependencies([
  asyncInitialization,
]){{/use_riverpod}}
void main() {
  group('$MyApp', () {
    {{#use_bloc}}

    

      {{#ignore}}
      {{#use_riverpod}}@Dependencies([
        asyncInitialization,
        SelectedStateManagementPackage,
      ]){{/use_riverpod}}
      @isTestGroup
      void blocTestsGroup(
        String description, {
        required Widget Function() buildSubjectApp,
        required AppInitializationBloc Function() appInitializationBlocFn,
        required Directory Function() applicationDocumentsDirectoryFn,
        required Directory Function() temporaryDirectoryFn,
        required LocalDatabase Function() localDatabaseFn,
      }) {
        {{> blocTestsGroup.partial }}
      }
      {{/ignore}}

      {{#use_auto_route}}late RootStackRouter router;
        late AppInitializationBloc appInitializationBloc;
        

        setUp(() {
          debugFlavor = AppFlavor.dev;
          router = RootStackRouter.build(
            routes: [
              AutoRoute(
                path: '/',
                page: PageInfo(
                  'FakeRoute',
                  builder: (data) => const Scaffold(
                    body: Center(
                      child: Text('Fake Screen'),
                    ),
                  ),
                ),
              ),
            ],
          );
          appInitializationBloc = _MockAppInitializationBloc();
          
        });

        tearDown(() {
          router.dispose();
          debugFlavor = null;
        });
        Widget buildSubjectApp() {
          return
          
                BlocProvider.value(
                  value: appInitializationBloc,
                  child: MyApp(
                    routerConfig: router.config(),
                  ),
                ) ;
        }

        {{> blocTestsGroup.partial }}{{/use_auto_route}}{{#use_go_router}}late GoRouter router;
        late AppInitializationBloc appInitializationBloc;
        

        setUp(() {
          debugFlavor = AppFlavor.dev;
          router = GoRouter(
            routes: [
              GoRoute(
                path: '/',
                name: 'FakeRoute',
                builder: (context, state) => const Scaffold(
                  body: Center(
                    child: Text('Fake Screen'),
                  ),
                ),
              ),
            ],
          );
          appInitializationBloc = _MockAppInitializationBloc();
          
        });

        tearDown(() {
          router.dispose();
          debugFlavor = null;
        });
        Widget buildSubjectApp() {
          return  BlocProvider.value(
              value: appInitializationBloc,
              child: MyApp(
                routerConfig: router,
              ),
            ) ;
        }

        {{> blocTestsGroup.partial }}{{/use_go_router}}
      
    {{/use_bloc}}

    {{#use_riverpod}}

    

      {{#ignore}}
      {{#use_riverpod}}@Dependencies([
        asyncInitialization,
        SelectedStateManagementPackage,
      ]){{/use_riverpod}}
      @isTestGroup
      void riverpodTestsGroup(
        String description, {
        required Widget Function() buildSubjectApp,
      }) {
        {{> riverpodTestsGroup.partial }}
      }
      {{/ignore}}

      {{#use_auto_route}}late RootStackRouter router;

        setUp(() {
          debugFlavor = AppFlavor.dev;
          router = RootStackRouter.build(
            routes: [
              AutoRoute(
                path: '/',
                page: PageInfo(
                  'FakeRoute',
                  builder: (data) => const Scaffold(
                    body: Center(
                      child: Text('Fake Screen'),
                    ),
                  ),
                ),
              ),
            ],
          );
        });

        tearDown(() {
          router.dispose();
          debugFlavor = null;
        });

        {{#use_riverpod}}@Dependencies([
          asyncInitialization,
        ]){{/use_riverpod}}
        Widget buildSubjectApp() {
          return  MyApp(
              routerConfig: router.config(),
              
          );
        }

        {{> riverpodTestsGroup.partial }}{{/use_auto_route}}{{#use_go_router}}late GoRouter router;

        setUp(() {
          debugFlavor = AppFlavor.dev;
          router = GoRouter(
            routes: [
              GoRoute(
                path: '/',
                name: 'FakeRoute',
                builder: (context, state) => const Scaffold(
                  body: Center(
                    child: Text('Fake Screen'),
                  ),
                ),
              ),
            ],
          );
        });

        tearDown(() {
          router.dispose();
          debugFlavor = null;
        });

        {{#use_riverpod}}@Dependencies([
          asyncInitialization,
        ]){{/use_riverpod}}
        Widget buildSubjectApp() {
          return  MyApp(
              routerConfig: router,
              
          );
        }

        {{> riverpodTestsGroup.partial }}{{/use_go_router}}
      
    {{/use_riverpod}}
  });
}
