import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/app/app.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/flavors/flavors.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/l10n/l10n.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerConfig = ref.watch(routerConfigPod);
    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: routerConfig,
      builder: (context, router) {
        router!;
        return NavigatorUriListener(
          router: router as Router<Object>,
          child: FlavorBanner(child: InitializationWrapper(child: router)),
        );
      },
    );
  }
}

@visibleForTesting
class InitializationWrapper extends ConsumerWidget {
  const InitializationWrapper({required this.child, super.key});

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
  const InitializingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

@visibleForTesting
class ErroredInitializationScreen extends ConsumerWidget {
  const ErroredInitializationScreen({super.key});

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
                child: Text(l10n.genericRetryButtonLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
