import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/flavors/flavors.dart';
import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerConfig = ref.watch(routerConfigPod);
    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: routerConfig,
      builder: (context, child) => /*remove-start*/
          RouterPackageSwitcherWrapper(
        child: /*remove-end*/ FlavorBanner(
          child: InitializationWrapper(
            child: child!,
          ),
        ), /*remove-start*/
      ), /*remove-end*/
    );
  }
}

/*remove-start*/
class RouterPackageSwitcherWrapper extends ConsumerWidget {
  const RouterPackageSwitcherWrapper({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerPackageIdentifier = ref.watch(
      selectedRouterPackagePod.select(
        (package) => package.identifier,
      ),
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
          shape: const Border(
            top: BorderSide(),
          ),
          child: SafeArea(
            top: false,
            left: false,
            right: false,
            maintainBottomViewPadding: true,
            child: Center(
              child: TextButton.icon(
                onPressed: () {
                  final selectedRouterPackageIndex =
                      ref.read(selectedRouterPackagePod).index;
                  final newRouterPackageIndex =
                      (selectedRouterPackageIndex + 1) %
                          RouterPackage.values.length;
                  ref.read(selectedRouterPackagePod.notifier).value =
                      RouterPackage.values[newRouterPackageIndex];
                },
                label: Text(routerPackageIdentifier),
                icon: const Icon(Icons.travel_explore),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
/*remove-end*/

@visibleForTesting
class InitializationWrapper extends ConsumerWidget {
  const InitializationWrapper({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncInitialization = ref.watch(asyncInitializationPod);
    return asyncInitialization.when(
      skipError: false,
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      loading: InitializingScreen.new,
      data: (_) => child,
      error: (_, __) => const ErroredInitializationScreen(),
    );
  }
}

@visibleForTesting
class InitializingScreen extends StatelessWidget {
  const InitializingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

@visibleForTesting
class ErroredInitializationScreen extends ConsumerWidget {
  const ErroredInitializationScreen({
    super.key,
  });

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
                  ref.invalidate(asyncInitializationPod);
                },
                child: Text(
                  l10n.genericRetryButtonLabel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
