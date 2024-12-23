import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Altoke App';

  @override
  String get genericRetryButtonLabel => 'Retry';

  @override
  String get appInitializationErrorMessage => 'There was an issue while trying to launch the app';

  @override
  String get homeAppBarTitle => 'Examples';

  @override
  String get counterExampleListTileTitle => 'Counter';

  @override
  String get counterAppBarTitle => 'Counter';

  @override
  String counterPushTimesMessage(int pushTimes) {
    final intl.NumberFormat pushTimesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String pushTimesString = pushTimesNumberFormat.format(pushTimes);

    String _temp0 = intl.Intl.pluralLogic(
      pushTimes,
      locale: localeName,
      other: 'pushed the button $pushTimesString times',
      one: 'pushed the button one time',
      zero: 'not pushed the button yet',
    );
    return 'You have $_temp0.';
  }

  @override
  String get counterIncrementButtonTooltip => 'Increment';

  @override
  String get counterResetButtonTooltip => 'Reset';

  @override
  String get tasksExampleListTileTitle => 'Tasks';

  @override
  String get tasksAppBarTitle => 'Tasks';

  @override
  String get noTasksFoundMessage => 'No tasks found';

  @override
  String get createTaskButtonTooltip => 'Create task';

  @override
  String get newTaskFormTitleLabel => 'Title';

  @override
  String get newTaskFormDescriptionLabel => 'Description';

  @override
  String get newTaskFormPriorityLabel => 'Priority';

  @override
  String get newTaskFormPriorityLowLabel => 'Low';

  @override
  String get newTaskFormPriorityMediumLabel => 'Medium';

  @override
  String get newTaskFormPriorityHighLabel => 'High';

  @override
  String get newTaskFormSubmitButtonLabel => 'Create task';

  @override
  String get createTaskSuccessMessage => 'Task created successfully';

  @override
  String get createTaskTitleEmptyError => 'The title should not be empty';

  @override
  String get createTaskDescriptionRequiredForHighPriorityTaskError => 'A description is required for high priority tasks';

  @override
  String get createTaskGenericMessage => 'Unexpected error creating task';

  @override
  String get createTaskFailureInvalidDataMessage => 'Invalid task data';

  @override
  String deleteTaskButtonTooltip(String taskTitle) {
    return 'Delete task \"$taskTitle\"';
  }
}
