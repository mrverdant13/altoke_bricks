/*remove-start*/
import 'dart:io';

/*remove-end*/

import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/flavors/flavors.dart';
/*remove-start*/
import 'package:altoke_app/routing/routing.dart';
/*remove-end*/
/*x{{#use_auto_route}}*/
import 'package:auto_route/auto_route.dart';
/*x{{/use_auto_route}}*/
/*x{{#use_bloc}}*/
import 'package:bloc_test/bloc_test.dart';
/*x{{/use_bloc}}*/
/*remove-start*/
import 'package:drift_local_database/drift_local_database.dart';
/*remove-end*/
import 'package:flutter/material.dart';
/*{{#use_bloc}}*/
import 'package:flutter_bloc/flutter_bloc.dart';
/*{{/use_bloc}}*/
/*x{{#use_riverpod}}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
/*x{{/use_riverpod}}*/
import 'package:flutter_test/flutter_test.dart';
/*x{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
/*x{{/use_go_router}}*/
/*{{#use_bloc}}*/
import 'package:mocktail/mocktail.dart';
/*{{/use_bloc}}*/
/*x{{#use_riverpod}}*/
import 'package:riverpod_annotation/experimental/scope.dart';

/*x{{/use_riverpod}}*/

import '../../helpers/helpers.dart';

/*{{#use_bloc}}*/
class _MockAppInitializationBloc
    extends MockBloc<AppInitializationEvent, AppInitializationState>
    implements AppInitializationBloc {}

/*remove-start*/
class _MockLocalDatabase extends Mock implements LocalDatabase {}
/*remove-end*/
/*{{/use_bloc}}*/

@Dependencies([
  /*remove-start*/
  SelectedRouterPackage,
  SelectedStateManagementPackage,
  /*remove-end-x*/
  asyncInitialization,
])
void main() {
  group('$MyApp', () {
    /*{{#use_bloc}}*/

    /*remove-start*/
    group('(using bloc)', () {
      /*remove-end*/

      /*{{#ignore}}*/
      @Dependencies([
        asyncInitialization,
        SelectedStateManagementPackage,
      ])
      @isTestGroup
      void blocTestsGroup(
        String description, {
        required Widget Function() buildSubjectApp,
        required AppInitializationBloc Function() appInitializationBlocFn,
        required Directory Function() applicationDocumentsDirectoryFn,
        required Directory Function() temporaryDirectoryFn,
        required LocalDatabase Function() localDatabaseFn,
      }) {
        /*partial v blocTestsGroup*/
        testWidgets('displays $FlavorBanner', (tester) async {
          /*remove-start*/
          final appInitializationBloc = appInitializationBlocFn();
          /*remove-end*/
          when(
            () => appInitializationBloc.state,
          ).thenReturn(
            const AppInitializing(),
          );
          await tester.pumpWidget(
            buildSubjectApp(),
          );
          expect(find.byType(FlavorBanner), findsOneWidget);
        });

        testWidgets(
          'displays $InitializingScreen '
          'when the initialization process is not completed',
          (tester) async {
            /*remove-start*/
            final appInitializationBloc = appInitializationBlocFn();
            /*remove-end*/
            when(
              () => appInitializationBloc.state,
            ).thenReturn(
              const AppInitializing(),
            );
            await tester.pumpWidget(
              buildSubjectApp(),
            );
            expect(find.byType(InitializingScreen), findsOneWidget);
          },
        );

        testWidgets(
          'displays the router content '
          'when the initialization process is completed',
          (tester) async {
            /*remove-start*/
            final appInitializationBloc = appInitializationBlocFn();
            final applicationDocumentsDirectory =
                applicationDocumentsDirectoryFn();
            final temporaryDirectory = temporaryDirectoryFn();
            final localDatabase = localDatabaseFn();
            /*remove-end*/
            when(
              () => appInitializationBloc.state,
            ).thenReturn(
              /*insert-start*/
              // const
              /*insert-end*/
              SuccessfulAppInitialization(
                /*remove-start*/
                applicationDocumentsDirectory: applicationDocumentsDirectory,
                temporaryDirectory: temporaryDirectory,
                localDatabase: localDatabase,
                /*remove-end*/
              ),
            );
            await tester.pumpWidget(
              buildSubjectApp(),
            );
            await tester.pumpUntilFound(find.text('Fake Screen'));
          },
        );

        testWidgets(
          'displays $ErroredInitializationScreen '
          'when the initialization process fails',
          (tester) async {
            /*remove-start*/
            final appInitializationBloc = appInitializationBlocFn();
            final applicationDocumentsDirectory =
                applicationDocumentsDirectoryFn();
            final temporaryDirectory = temporaryDirectoryFn();
            final localDatabase = localDatabaseFn();
            /*remove-end*/
            when(
              () => appInitializationBloc.state,
            ).thenReturn(
              /*insert-start*/
              // const
              /*insert-end*/
              FailedAppInitialization(
                /*remove-start*/
                applicationDocumentsDirectory: applicationDocumentsDirectory,
                temporaryDirectory: temporaryDirectory,
                localDatabase: localDatabase,
                hiveDatabaseInitialized: false,
                /*remove-end*/
              ),
            );
            await tester.pumpWidget(
              buildSubjectApp(),
            );
            expect(find.byType(ErroredInitializationScreen), findsOneWidget);
          },
        );

        testWidgets(
          'allows requesting a new initialization process '
          'when the initialization process fails',
          (tester) async {
            /*remove-start*/
            final appInitializationBloc = appInitializationBlocFn();
            final applicationDocumentsDirectory =
                applicationDocumentsDirectoryFn();
            final temporaryDirectory = temporaryDirectoryFn();
            final localDatabase = localDatabaseFn();
            /*remove-end*/
            when(
              () => appInitializationBloc.state,
            ).thenReturn(
              /*insert-start*/
              // const
              /*insert-end*/
              FailedAppInitialization(
                /*remove-start*/
                applicationDocumentsDirectory: applicationDocumentsDirectory,
                temporaryDirectory: temporaryDirectory,
                localDatabase: localDatabase,
                hiveDatabaseInitialized: false,
                /*remove-end*/
              ),
            );
            await tester.pumpWidget(
              buildSubjectApp(),
            );
            expect(find.byType(ErroredInitializationScreen), findsOneWidget);
            await tester.tap(find.byType(ElevatedButton));
            verify(
              () => appInitializationBloc.add(
                const AppInitializationRequested(),
              ),
            ).called(1);
          },
        );
        /*partial ^ blocTestsGroup*/
      }
      /*{{/ignore}}*/

      /*{{#use_auto_route}}x*/

      /*remove-start*/
      group('(using auto_route)', () {
        /*remove-end*/
        late RootStackRouter router;
        late AppInitializationBloc appInitializationBloc;
        /*remove-start*/
        late Directory applicationDocumentsDirectory;
        late Directory temporaryDirectory;
        late LocalDatabase localDatabase;
        /*remove-end*/

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
          /*remove-start*/
          applicationDocumentsDirectory = Directory.systemTemp.createTempSync();
          temporaryDirectory = Directory.systemTemp.createTempSync();
          localDatabase = _MockLocalDatabase();
          /*remove-end*/
        });

        tearDown(() {
          router.dispose();
          debugFlavor = null;
        });

        /*x-remove-start*/
        @Dependencies([
          asyncInitialization,
          SelectedRouterPackage,
        ])
        /*remove-end*/
        Widget buildSubjectApp() {
          return
          /*remove-start*/
          ProviderScope(
            overrides: [
              selectedStateManagementPackagePod.overrideWithValue(
                StateManagementPackage.bloc,
              ),
            ],
            child:
                /*remove-end*/
                BlocProvider.value(
                  value: appInitializationBloc,
                  child: MyApp(
                    routerConfig: router.config(),
                  ),
                ) /*remove-start*/,
          ) /*remove-end*/;
        }

        /*replace-start*/
        blocTestsGroup(
          '(bloc & auto_route)',
          buildSubjectApp: buildSubjectApp,
          appInitializationBlocFn: () => appInitializationBloc,
          applicationDocumentsDirectoryFn: () => applicationDocumentsDirectory,
          temporaryDirectoryFn: () => temporaryDirectory,
          localDatabaseFn: () => localDatabase,
        );
        /*with*/
        // {{> blocTestsGroup.partial }}
        /*replace-end*/
        /*remove-start*/
      });
      /*remove-end*/
      /*x{{/use_auto_route}}x*/

      /*x{{#use_go_router}}x*/
      /*remove-start*/
      group('(using go_router)', () {
        /*remove-end*/
        late GoRouter router;
        late AppInitializationBloc appInitializationBloc;
        /*remove-start*/
        late Directory applicationDocumentsDirectory;
        late Directory temporaryDirectory;
        late LocalDatabase localDatabase;
        /*remove-end*/

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
          /*remove-start*/
          applicationDocumentsDirectory = Directory.systemTemp.createTempSync();
          temporaryDirectory = Directory.systemTemp.createTempSync();
          localDatabase = _MockLocalDatabase();
          /*remove-end*/
        });

        tearDown(() {
          router.dispose();
          debugFlavor = null;
        });

        /*x-remove-start*/
        @Dependencies([
          asyncInitialization,
          SelectedRouterPackage,
        ])
        /*remove-end*/
        Widget buildSubjectApp() {
          return /*remove-start*/ ProviderScope(
            overrides: [
              selectedStateManagementPackagePod.overrideWithValue(
                StateManagementPackage.bloc,
              ),
            ],
            child: /*remove-end*/ BlocProvider.value(
              value: appInitializationBloc,
              child: MyApp(
                routerConfig: router,
              ),
            ) /*remove-start*/,
          ) /*remove-end*/;
        }

        /*replace-start*/
        blocTestsGroup(
          '(bloc & go_router)',
          buildSubjectApp: buildSubjectApp,
          appInitializationBlocFn: () => appInitializationBloc,
          applicationDocumentsDirectoryFn: () => applicationDocumentsDirectory,
          temporaryDirectoryFn: () => temporaryDirectory,
          localDatabaseFn: () => localDatabase,
        );
        /*with*/
        // {{> blocTestsGroup.partial }}
        /*replace-end*/
        /*remove-start*/
      });
      /*remove-end*/
      /*x{{/use_go_router}}*/
      /*remove-start*/
    });
    /*remove-end*/
    /*{{/use_bloc}}*/

    /*{{#use_riverpod}}*/

    /*remove-start*/
    group('(using riverpod)', () {
      /*remove-end*/

      /*{{#ignore}}*/
      @Dependencies([
        asyncInitialization,
        SelectedStateManagementPackage,
      ])
      @isTestGroup
      void riverpodTestsGroup(
        String description, {
        required Widget Function() buildSubjectApp,
      }) {
        /*partial v riverpodTestsGroup*/
        testWidgets('displays $FlavorBanner', (tester) async {
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                asyncInitializationPod.overrideWithValue(
                  const AsyncLoading(),
                ),
              ],
              child: buildSubjectApp(),
            ),
          );
          expect(find.byType(FlavorBanner), findsOneWidget);
        });

        testWidgets(
          'displays $InitializingScreen '
          'when the initialization process is not completed',
          (tester) async {
            await tester.pumpWidget(
              ProviderScope(
                overrides: [
                  asyncInitializationPod.overrideWithValue(
                    const AsyncLoading(),
                  ),
                ],
                child: buildSubjectApp(),
              ),
            );
            expect(find.byType(InitializingScreen), findsOneWidget);
          },
        );

        testWidgets(
          'displays the router content '
          'when the initialization process is completed',
          (tester) async {
            await tester.pumpWidget(
              ProviderScope(
                overrides: [
                  asyncInitializationPod.overrideWithValue(
                    const AsyncData(null),
                  ),
                ],
                child: buildSubjectApp(),
              ),
            );
            await tester.pumpUntilFound(find.text('Fake Screen'));
          },
        );

        testWidgets(
          'displays $ErroredInitializationScreen '
          'when the initialization process fails',
          (tester) async {
            await tester.pumpWidget(
              ProviderScope(
                overrides: [
                  asyncInitializationPod.overrideWithValue(
                    AsyncError(
                      Exception('error'),
                      StackTrace.current,
                    ),
                  ),
                ],
                child: buildSubjectApp(),
              ),
            );
            expect(find.byType(ErroredInitializationScreen), findsOneWidget);
          },
        );

        testWidgets(
          'allows requesting a new initialization process '
          'when the initialization process fails',
          (tester) async {
            var refreshed = false;
            await tester.pumpWidget(
              ProviderScope(
                overrides: [
                  asyncInitializationPod.overrideWith((ref) async {
                    if (ref.isRefresh) refreshed = true;
                    throw Exception('error');
                  }),
                ],
                child: buildSubjectApp(),
              ),
            );
            expect(find.byType(ErroredInitializationScreen), findsOneWidget);
            await tester.tap(find.byType(ElevatedButton));
            expect(refreshed, isTrue);
          },
          skip: true, // Riverpod 3.0 behaves differently in test mode
        );
        /*partial ^ riverpodTestsGroup*/
      }
      /*{{/ignore}}*/

      /*{{#use_auto_route}}x*/
      /*remove-start*/
      group('(using auto_route)', () {
        /*remove-end*/

        late RootStackRouter router;

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

        @Dependencies([
          asyncInitialization,
          /*x-remove-start*/
          SelectedRouterPackage,
          /*remove-end*/
        ])
        Widget buildSubjectApp() {
          return /*remove-start*/ ProviderScope(
            overrides: [
              selectedStateManagementPackagePod.overrideWithValue(
                StateManagementPackage.riverpod,
              ),
            ],
            child: /*remove-end*/ MyApp(
              routerConfig: router.config(),
              /*remove-start*/
            ),
            /*remove-end*/
          );
        }

        /*replace-start*/
        riverpodTestsGroup(
          '(riverpod & auto_route)',
          buildSubjectApp: buildSubjectApp,
        );
        /*with*/
        // {{> riverpodTestsGroup.partial }}
        /*replace-end*/
        /*remove-start*/
      });
      /*remove-end*/
      /*x{{/use_auto_route}}x*/

      /*x{{#use_go_router}}x*/
      /*remove-start*/
      group('(using go_router)', () {
        /*remove-end*/
        late GoRouter router;

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

        @Dependencies([
          asyncInitialization,
          /*x-remove-start*/
          SelectedRouterPackage,
          /*remove-end*/
        ])
        Widget buildSubjectApp() {
          return /*remove-start*/ ProviderScope(
            overrides: [
              selectedStateManagementPackagePod.overrideWithValue(
                StateManagementPackage.riverpod,
              ),
            ],
            child: /*remove-end*/ MyApp(
              routerConfig: router,
              /*remove-start*/
            ),
            /*remove-end*/
          );
        }

        /*replace-start*/
        riverpodTestsGroup(
          '(riverpod & go_router)',
          buildSubjectApp: buildSubjectApp,
        );
        /*with*/
        // {{> riverpodTestsGroup.partial }}
        /*replace-end*/
        /*remove-start*/
      });
      /*remove-end*/
      /*x{{/use_go_router}}*/
      /*remove-start*/
    });
    /*remove-end*/
    /*{{/use_riverpod}}*/
  });
}
