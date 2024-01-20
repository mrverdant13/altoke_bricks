import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasks/tasks.dart';

import '../../helpers/helpers.dart';

void main() {
  final dropdownFinder =
      find.byType(DropdownButtonFormField<TasksStatusFilter>);
  final dropdownItemsFinder = find.descendant(
    of: find.byType(ListView),
    matching: find.byType(DropdownMenuItem<TasksStatusFilter>),
  );

  group(
    '''

GIVEN a localization variant for the tasks content filter text field label''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10n) =>
            l10n.tasksTaskContentSearchTextFieldLabel,
        partialCases: {
          const (
            Locale('en'),
            'Search by content',
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'Buscar por contenido',
          ),
        },
      );

      testExhaustiveLocalizationVariant(
        '''

WHEN testing the tasks content filter text field label
THEN all supported locales should be considered
''',
        localizationVariant,
      );

      testLocalizedWidget(
        '''

AND a tasks content filter text field
WHEN the text field is displayed
THEN the field should include the localized label
''',
        const ProviderScope(
          child: Scaffold(
            body: TasksContentFilterTextField(),
          ),
        ),
        ancestorFinder: find.byKey(
          const Key(
            '<tasks::task-content-filter-text-field::label>',
          ),
        ),
        variant: localizationVariant,
      );
    },
  );

  group(
    '''
GIVEN a tasks content filter text field''',
    () {
      late ProviderContainer container;
      late Widget textField;

      setUp(
        () {
          container = ProviderContainer();
          textField = UncontrolledProviderScope(
            container: container,
            child: const Scaffold(
              body: TasksContentFilterTextField(),
            ),
          );
        },
      );

      tearDown(
        () {
          container.dispose();
        },
      );

      testWidgets(
        '''

WHEN it is displayed
THEN the field should use the proper prefix
''',
        (tester) async {
          await tester.pumpTestableWidget(textField);
          final textFieldPrefixIconDataFinder = find.descendant(
            of: find.byKey(
              const Key(
                '<tasks::task-content-filter-text-field::prefix-icon>',
              ),
            ),
            matching: find.byIcon(Icons.search),
          );
          expect(textFieldPrefixIconDataFinder, findsOneWidget);
        },
      );

      testWidgets(
        '''

AND the task search term pod
WHEN the user types a search term
THEN the updated field value should be debounced
THEN the search term should be updated in the pod
''',
        (tester) async {
          await tester.pumpTestableWidget(textField);
          final subscription = container.listen(
            taskSearchTermPod,
            (previousValue, newValue) {},
            fireImmediately: true,
          );
          addTearDown(subscription.close);
          final textFieldFinder = find.byType(TextFormField);
          expect(find.textContaining('new value'), findsNothing);
          await tester.enterText(textFieldFinder, ' new value ');
          expect(find.textContaining('new value'), findsOneWidget);
          expect(subscription.read(), isNot('new value'));
          await tester.pump(const Duration(milliseconds: 499));
          expect(subscription.read(), isNot('new value'));
          await tester.pump(const Duration(milliseconds: 1));
          expect(subscription.read(), 'new value');
        },
      );
    },
  );

  group(
    '''

GIVEN a localization variant for the tasks status filter dropdown label''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10n) =>
            l10n.tasksTaskStatusFilterDropdownLabel,
        partialCases: {
          const (
            Locale('en'),
            'Filter by status',
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'Filtrar por estado',
          ),
        },
      );

      testExhaustiveLocalizationVariant(
        '''

WHEN testing the tasks status filter dropdown label
THEN all supported locales should be considered
''',
        localizationVariant,
      );

      testLocalizedWidget(
        '''

AND a tasks status filter dropdown
WHEN the dropdown is displayed
THEN the dropdown should include the localized label
''',
        const ProviderScope(
          child: Scaffold(
            body: TasksStatusFilterDropdown(),
          ),
        ),
        ancestorFinder: find.byKey(
          const Key(
            '<tasks::task-status-filter-dropdown::label>',
          ),
        ),
        variant: localizationVariant,
      );
    },
  );

  group(
    '''
GIVEN a tasks status filter dropdown''',
    () {
      late ProviderContainer container;
      late Widget dropdown;

      setUp(
        () {
          container = ProviderContainer();
          dropdown = UncontrolledProviderScope(
            container: container,
            child: const Scaffold(
              body: TasksStatusFilterDropdown(),
            ),
          );
        },
      );

      tearDown(
        () {
          container.dispose();
        },
      );

      testWidgets(
        '''

WHEN it is displayed
THEN the dropdown should include items for all filters
├─ THAT should include the proper icon
''',
        (tester) async {
          await tester.pumpTestableWidget(dropdown);
          await tester.tap(dropdownFinder);
          await tester.pumpAndSettle();
          expect(
            dropdownItemsFinder,
            findsNWidgets(TasksStatusFilter.values.length),
          );
          for (final filter in TasksStatusFilter.values) {
            final itemFinder = find.descendant(
              of: dropdownItemsFinder,
              matchRoot: true,
              matching: find.byWidgetPredicate(
                (widget) =>
                    widget is DropdownMenuItem<TasksStatusFilter> &&
                    widget.value == filter,
              ),
            );
            expect(
              itemFinder,
              findsOneWidget,
              reason: 'The item for the filter $filter was not found',
            );
            final expectedIcon = switch (filter) {
              TasksStatusFilter.all => Icons.filter_list_off,
              TasksStatusFilter.uncompleted => Icons.check_box_outline_blank,
              TasksStatusFilter.completed => Icons.check_box,
            };
            final iconFinder = find.descendant(
              of: itemFinder,
              matching: find.byIcon(expectedIcon),
            );
            expect(
              iconFinder,
              findsOneWidget,
              reason:
                  'The icon $expectedIcon for the filter $filter was not found',
            );
          }
        },
      );

      testWidgets(
        '''

AND the selected task status filter pod
WHEN the user picks a filter from the dropdown
THEN the selected filter should be updated in the pod
''',
        (tester) async {
          await tester.pumpTestableWidget(dropdown);
          final subscription = container.listen(
            selectedTasksStatusFilterPod,
            (previousValue, newValue) {},
            fireImmediately: true,
          );
          addTearDown(subscription.close);
          for (final filter in TasksStatusFilter.values) {
            await tester.tap(dropdownFinder);
            await tester.pumpAndSettle();
            final itemFinder = find.descendant(
              of: dropdownItemsFinder,
              matchRoot: true,
              matching: find.byWidgetPredicate(
                (widget) =>
                    widget is DropdownMenuItem<TasksStatusFilter> &&
                    widget.value == filter,
              ),
            );
            await tester.tap(itemFinder, warnIfMissed: false);
            await tester.pumpAndSettle();
            expect(subscription.read(), filter);
            final selectedItemFinder = find.descendant(
              of: dropdownFinder,
              matchRoot: true,
              matching: find.byWidgetPredicate(
                (widget) =>
                    widget is DropdownMenuItem<TasksStatusFilter> &&
                    widget.value == filter,
              ),
            );
            expect(selectedItemFinder, findsOneWidget);
          }
        },
      );
    },
  );

  group(
    '''

GIVEN a localization variant for a dropdown item label that corresponds to the option that does not filter by status''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10n) =>
            l10n.tasksTaskStatusFilterDropdownAllItemLabel,
        partialCases: {
          const (
            Locale('en'),
            'All',
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'Todos',
          ),
        },
      );

      testExhaustiveLocalizationVariant(
        '''

WHEN testing the dropdown item label that corresponds to the option that does not filter by status
THEN all supported locales should be considered
''',
        localizationVariant,
      );

      testLocalizedWidget(
        '''

AND a tasks status filter dropdown
WHEN the options are displayed
THEN the option that does not filter by status should include the localized label
''',
        const ProviderScope(
          child: Scaffold(
            body: TasksStatusFilterDropdown(),
          ),
        ),
        postPumpAction: (tester) async {
          await tester.tap(dropdownFinder);
          await tester.pumpAndSettle();
        },
        ancestorFinder: dropdownItemsFinder,
        variant: localizationVariant,
      );
    },
  );

  group(
    '''

GIVEN a localization variant for a dropdown item label that corresponds to the option that filters completed tasks''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10n) =>
            l10n.tasksTaskStatusFilterDropdownCompletedItemLabel,
        partialCases: {
          const (
            Locale('en'),
            'Completed',
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'Completadas',
          ),
        },
      );

      testExhaustiveLocalizationVariant(
        '''

WHEN testing the dropdown item label that corresponds to the option that filters completed tasks
THEN all supported locales should be considered
''',
        localizationVariant,
      );

      testLocalizedWidget(
        '''

AND a tasks status filter dropdown
WHEN the options are displayed
THEN the option that filters completed tasks should include the localized label
''',
        const ProviderScope(
          child: Scaffold(
            body: TasksStatusFilterDropdown(),
          ),
        ),
        postPumpAction: (tester) async {
          await tester.tap(dropdownFinder);
          await tester.pumpAndSettle();
        },
        ancestorFinder: dropdownItemsFinder,
        variant: localizationVariant,
      );
    },
  );

  group(
    '''

GIVEN a localization variant for a dropdown item label that corresponds to the option that filters uncompleted tasks''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10n) =>
            l10n.tasksTaskStatusFilterDropdownUncompletedItemLabel,
        partialCases: {
          const (
            Locale('en'),
            'Uncompleted',
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'No completadas',
          ),
        },
      );

      testExhaustiveLocalizationVariant(
        '''

WHEN testing the dropdown item label that corresponds to the option that filters uncompleted tasks
THEN all supported locales should be considered
''',
        localizationVariant,
      );

      testLocalizedWidget(
        '''

AND a tasks status filter dropdown
WHEN the options are displayed
THEN the option that filters uncompleted tasks should include the localized label
''',
        const ProviderScope(
          child: Scaffold(
            body: TasksStatusFilterDropdown(),
          ),
        ),
        postPumpAction: (tester) async {
          await tester.tap(dropdownFinder);
          await tester.pumpAndSettle();
        },
        ancestorFinder: dropdownItemsFinder,
        variant: localizationVariant,
      );
    },
  );
}
