import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/app/app.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/flavors/flavors.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/l10n/l10n.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';
import 'package:flutter/material.dart';
{{#use_bloc}}
import 'package:flutter_bloc/{{#use_bloc}}flutter_bloc.dart{{/use_bloc}}';
{{/use_bloc}}
{{#use_riverpod}}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';{{/use_riverpod}}

{{#use_riverpod}}@Dependencies([
  asyncInitialization,
]){{/use_riverpod}}
class MyApp extends {{#use_riverpod}}ConsumerWidget{{/use_riverpod}}{{^use_riverpod}}StatelessWidget{{/use_riverpod}} {
  const MyApp({
    required this.routerConfig,
    super.key,
  });

  final RouterConfig<Object> routerConfig;

  @override
  Widget build(BuildContext context{{#use_riverpod}}, WidgetRef ref{{/use_riverpod}}) {
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

{{#use_riverpod}}@Dependencies([
  asyncInitialization,
]){{/use_riverpod}}
@visibleForTesting
class InitializationWrapper extends {{#use_riverpod}}ConsumerWidget{{/use_riverpod}}{{^use_riverpod}}StatelessWidget{{/use_riverpod}} {
  const InitializationWrapper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context{{#use_riverpod}}, WidgetRef ref{{/use_riverpod}}) {
    
        {{#use_bloc}}
        final appInitializationState = context
            .watch<AppInitializationBloc>()
            .state;
        return switch (appInitializationState) {
          AppUninitialized() || AppInitializing() => const InitializingScreen(),
          SuccessfulAppInitialization() => child,
          FailedAppInitialization() => const ErroredInitializationScreen(),
        }; {{/use_bloc}}
      
        {{#use_riverpod}}
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
        ); {{/use_riverpod}}
      
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

{{#use_riverpod}}@Dependencies([
  asyncInitialization,
]){{/use_riverpod}}
@visibleForTesting
class ErroredInitializationScreen extends {{#use_riverpod}}ConsumerWidget{{/use_riverpod}}{{^use_riverpod}}StatelessWidget{{/use_riverpod}} {
  const ErroredInitializationScreen({super.key});

  // coverage:ignore-start
  @override
  Widget build(BuildContext context{{#use_riverpod}}, WidgetRef ref{{/use_riverpod}}) {
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
                  
                      {{#use_bloc}}
                      context.read<AppInitializationBloc>().add(
                        const AppInitializationRequested(),
                      );
                    {{/use_bloc}}
                    
                      {{#use_riverpod}}
                      ref.invalidate(asyncInitializationPod);
                    {{/use_riverpod}}
                    
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
