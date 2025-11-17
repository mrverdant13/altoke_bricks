import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/flavors/flavors.dart';
import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:flutter/material.dart';
/*{{#use_bloc}}*/
import 'package:flutter_bloc/flutter_bloc.dart';
/*{{/use_bloc}}*/
/*{{#use_riverpod}}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([
  routerConfig,
  asyncInitialization,
  /*x-remove-start*/
  SelectedRouterPackage,
  SelectedStateManagementPackage,
  /*remove-end*/
])
/*{{/use_riverpod}}*/
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerConfig = ref.watch(routerConfigPod);
    return /*{{#use_bloc}}*/ BlocProvider(
      create: (context) =>
          AppInitializationBloc()..add(const AppInitializationRequested()),
      child: /*{{/use_bloc}}*/ MaterialApp.router(
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
                child: FlavorBanner(
                  child: InitializationWrapper(child: router),
                ),
              );
          /*x-remove-start*/
          return OptionsSwitcherWrapper(
            child: child,
          );
          /*remove-end*/
        },
      ) /*{{/use_bloc}}*/,
    ) /*{{/use_bloc}}*/;
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
                  icon: const Icon(Icons.route),
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
                  icon: const Icon(Icons.precision_manufacturing),
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

/*{{#use_riverpod}}*/
@Dependencies([
  asyncInitialization,
  /*x-remove-start*/
  SelectedStateManagementPackage,
  /*remove-end-x*/
])
/*{{/use_riverpod}}*/
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
      case StateManagementPackage.bloc:
        /*remove-end-x*/ /*{{#use_bloc}}x*/
        return switch (context.watch<AppInitializationBloc>().state) {
          AppUninitialized() || AppInitializing() => const InitializingScreen(),
          SuccessfulAppInitialization() => child,
          FailedAppInitialization() => const ErroredInitializationScreen(),
        };
      /*x{{/use_bloc}}*/ /*x-remove-start*/
      case StateManagementPackage.riverpod:
        /*remove-end-x*/ /*{{#use_riverpod}}x*/
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
        );
      /*x{{/use_riverpod}}*/ /*x-remove-start*/
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

/*{{#use_riverpod}}*/
@Dependencies([
  asyncInitialization,
])
/*{{/use_riverpod}}*/
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
                  /*{{#use_bloc}}*/
                  context.read<AppInitializationBloc>().add(
                    const AppInitializationRequested(),
                  );
                  /*{{/use_bloc}}x*/
                  /*x{{#use_riverpod}}*/
                  ref.invalidate(asyncInitializationPod);
                  /*{{/use_riverpod}}*/
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
