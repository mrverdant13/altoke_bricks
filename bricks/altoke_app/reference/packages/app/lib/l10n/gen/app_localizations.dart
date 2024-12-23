import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// App title
  ///
  /// In en, this message translates to:
  /// **'Altoke App'**
  String get appTitle;

  /// Label for a generic retry button
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get genericRetryButtonLabel;

  /// Message displayed when the app fails to initialize
  ///
  /// In en, this message translates to:
  /// **'There was an issue while trying to launch the app'**
  String get appInitializationErrorMessage;

  /// Title for the home screen app bar
  ///
  /// In en, this message translates to:
  /// **'Examples'**
  String get homeAppBarTitle;

  /// Title for the counter example list tile
  ///
  /// In en, this message translates to:
  /// **'Counter'**
  String get counterExampleListTileTitle;

  /// App bar title for the counter screen
  ///
  /// In en, this message translates to:
  /// **'Counter'**
  String get counterAppBarTitle;

  /// Message with the number of times the button has been pushed
  ///
  /// In en, this message translates to:
  /// **'You have {pushTimes, plural, =0{not pushed the button yet} =1{pushed the button one time} other{pushed the button {pushTimes} times}}.'**
  String counterPushTimesMessage(int pushTimes);

  /// Tooltip for the increment button
  ///
  /// In en, this message translates to:
  /// **'Increment'**
  String get counterIncrementButtonTooltip;

  /// Tooltip for the reset button
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get counterResetButtonTooltip;

  /// Title for the tasks example list tile
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasksExampleListTileTitle;

  /// Title for the tasks screen app bar
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasksAppBarTitle;

  /// Message displayed when no tasks are found
  ///
  /// In en, this message translates to:
  /// **'No tasks found'**
  String get noTasksFoundMessage;

  /// Create task button tooltip
  ///
  /// In en, this message translates to:
  /// **'Create task'**
  String get createTaskButtonTooltip;

  /// Label for the task title input field
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get newTaskFormTitleLabel;

  /// Label for the task description input field
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get newTaskFormDescriptionLabel;

  /// Label for the task priority input field
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get newTaskFormPriorityLabel;

  /// Label for the low priority option in the task form
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get newTaskFormPriorityLowLabel;

  /// Label for the medium priority option in the task form
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get newTaskFormPriorityMediumLabel;

  /// Label for the high priority option in the task form
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get newTaskFormPriorityHighLabel;

  /// Label for the submit button in the new task form
  ///
  /// In en, this message translates to:
  /// **'Create task'**
  String get newTaskFormSubmitButtonLabel;

  /// Message displayed when creating a task succeeds
  ///
  /// In en, this message translates to:
  /// **'Task created successfully'**
  String get createTaskSuccessMessage;

  /// Message displayed when the task title is empty
  ///
  /// In en, this message translates to:
  /// **'The title should not be empty'**
  String get createTaskTitleEmptyError;

  /// Message displayed when no description is provided for a high priority task
  ///
  /// In en, this message translates to:
  /// **'A description is required for high priority tasks'**
  String get createTaskDescriptionRequiredForHighPriorityTaskError;

  /// Generic message displayed when creating a task fails unexpectedly
  ///
  /// In en, this message translates to:
  /// **'Unexpected error creating task'**
  String get createTaskGenericMessage;

  /// Message displayed when creating a task fails due to invalid data
  ///
  /// In en, this message translates to:
  /// **'Invalid task data'**
  String get createTaskFailureInvalidDataMessage;

  /// Delete task button tooltip
  ///
  /// In en, this message translates to:
  /// **'Delete task \"{taskTitle}\"'**
  String deleteTaskButtonTooltip(String taskTitle);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
