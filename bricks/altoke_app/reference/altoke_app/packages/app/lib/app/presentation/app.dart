import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/flavors/flavors.dart';
import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:flutter/material.dart';
/*{{#use_bloc}}*/
import 'package:flutter_bloc/flutter_bloc.dart';
/*{{/use_bloc}}*/
/*x{{#use_riverpod}}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
/*x{{/use_riverpod}}*/

@Dependencies([
  asyncInitialization,
  /*x-remove-start*/
  SelectedRouterPackage,
  SelectedStateManagementPackage,
  /*remove-end*/
])
class MyApp extends ConsumerWidget {
  const MyApp({
    required this.routerConfig,
    super.key,
  });

  final RouterConfig<Object> routerConfig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: routerConfig,
      builder: (context, router) {
        router!;
        /*replace-start*/
        final child =
            /*with*/
            // return
            /*replace-end*/ NavigatorUriListener(
              router: router as Router<Object>,
              child: FlavorBanner(child: InitializationWrapper(child: router)),
            );
        /*x-remove-start*/
        return OptionsSwitcherWrapper(child: child);
        /*remove-end*/
      },
    );
  }
} /*w 2v w*/

/*remove-start*/
// coverage:ignore-start
@Dependencies([
  SelectedRouterPackage,
  SelectedStateManagementPackage,
])
class OptionsSwitcherWrapper extends ConsumerWidget {
  const OptionsSwitcherWrapper({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerPackageIdentifier = ref.watch(
      selectedRouterPackagePod.select((package) => package.identifier),
    );
    final stateManagementPackageIdentifier = ref.watch(
      selectedStateManagementPackagePod.select((package) => package.identifier),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: child,
          ),
        ),
        Material(
          shape: const Border(top: BorderSide()),
          child: SafeArea(
            top: false,
            left: false,
            right: false,
            maintainBottomViewPadding: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {
                    final selectedRouterPackageIndex = ref
                        .read(selectedRouterPackagePod)
                        .index;
                    final newRouterPackageIndex =
                        (selectedRouterPackageIndex + 1) %
                        RouterPackage.values.length;
                    ref.read(selectedRouterPackagePod.notifier).value =
                        RouterPackage.values[newRouterPackageIndex];
                  },
                  label: Text(routerPackageIdentifier),
                  icon: const Icon(Icons.travel_explore),
                ),
                TextButton.icon(
                  onPressed: () {
                    final selectedStateManagementPackageIndex = ref
                        .read(selectedStateManagementPackagePod)
                        .index;
                    final newStateManagementPackageIndex =
                        (selectedStateManagementPackageIndex + 1) %
                        StateManagementPackage.values.length;
                    ref
                        .read(selectedStateManagementPackagePod.notifier)
                        .value = StateManagementPackage
                        .values[newStateManagementPackageIndex];
                  },
                  label: Text(stateManagementPackageIdentifier),
                  icon: const Icon(Icons.dashboard),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
// coverage:ignore-end
/*remove-end*/

@Dependencies([
  asyncInitialization,
  /*x-remove-start*/
  SelectedStateManagementPackage,
  /*remove-end*/
])
@visibleForTesting
class InitializationWrapper extends ConsumerWidget {
  const InitializationWrapper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /*remove-start*/
    final selectedStateManagementPackage = ref.watch(
      selectedStateManagementPackagePod,
    );
    switch (selectedStateManagementPackage) {
      case StateManagementPackage.bloc: /*remove-end*/
        /*{{#use_bloc}}*/
        final appInitializationState = context
            .watch<AppInitializationBloc>()
            .state;
        return switch (appInitializationState) {
          AppUninitialized() || AppInitializing() => const InitializingScreen(),
          SuccessfulAppInitialization() => child,
          FailedAppInitialization() => const ErroredInitializationScreen(),
        }; /*{{/use_bloc}}*/
      /*remove-start*/
      case StateManagementPackage.riverpod: /*remove-end*/
        /*{{#use_riverpod}}*/
        final asyncInitialization = ref.watch(asyncInitializationPod);
        return asyncInitialization.when(
          skipError: false,
          skipLoadingOnRefresh: false,
          skipLoadingOnReload: false,
          loading: InitializingScreen.new,
          data: (_) => child,
          // coverage:ignore-start
          error: (_, _) => const ErroredInitializationScreen(),
          // coverage:ignore-end
        ); /*{{/use_riverpod}}*/
      /*remove-start*/
    } /*remove-end*/
  }
}

@visibleForTesting
class InitializingScreen extends StatelessWidget {
  const InitializingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

@Dependencies([
  asyncInitialization,
  /*x-remove-start*/
  SelectedStateManagementPackage,
  /*remove-end*/
])
@visibleForTesting
class ErroredInitializationScreen extends ConsumerWidget {
  const ErroredInitializationScreen({super.key});

  // coverage:ignore-start
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox.expand(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n.appInitializationErrorMessage,
                textAlign: TextAlign.center,
              ),
              const SizedBox.square(dimension: 16),
              ElevatedButton(
                onPressed: () {
                  /*remove-start*/
                  final selectedStateManagementPackage = ref.read(
                    selectedStateManagementPackagePod,
                  );
                  switch (selectedStateManagementPackage) {
                    case StateManagementPackage.bloc:
                      /*remove-end*/
                      /*{{#use_bloc}}*/
                      context.read<AppInitializationBloc>().add(
                        const AppInitializationRequested(),
                      );
                    /*{{/use_bloc}}*/
                    /*remove-start*/
                    case StateManagementPackage.riverpod:
                      /*remove-end*/
                      /*{{#use_riverpod}}*/
                      ref.invalidate(asyncInitializationPod);
                    /*{{/use_riverpod}}*/
                    /*remove-start*/
                  } /*remove-end*/
                },
                child: Text(l10n.genericRetryButtonLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // coverage:ignore-end
}
