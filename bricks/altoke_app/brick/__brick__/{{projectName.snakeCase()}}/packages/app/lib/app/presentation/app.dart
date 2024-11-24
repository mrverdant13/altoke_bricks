import 'package:{{projectName.snakeCase()}}/app/app.dart';
import 'package:{{projectName.snakeCase()}}/l10n/l10n.dart';
import 'package:{{projectName.snakeCase()}}/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@visibleForTesting
final lightTheme = ThemeData.light();

@visibleForTesting
final darkTheme = ThemeData.dark();

@visibleForTesting
String onGenerateTitle(BuildContext context) => context.l10n.appTitle;

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncInitialization = ref.watch(asyncInitializationPod);
    return asyncInitialization.when(
      skipError: false,
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      loading: () => const AppInitializing(),
      data: (_) => const InitializedApp(),
      error: (_, __) => const AppWithErroredInitialization(),
    );
  }
}

@visibleForTesting
class InitializedApp extends ConsumerWidget {
  const InitializedApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerConfig = ref.watch(routerConfigPod);
    return MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      onGenerateTitle: onGenerateTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: routerConfig,
    );
  }
}

@visibleForTesting
class AppInitializing extends StatelessWidget {
  const AppInitializing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      onGenerateTitle: onGenerateTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}

@visibleForTesting
class AppWithErroredInitialization extends ConsumerWidget {
  const AppWithErroredInitialization({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      onGenerateTitle: onGenerateTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox.expand(
            child: Builder(
              builder: (context) {
                final l10n = context.l10n;
                return Column(
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
