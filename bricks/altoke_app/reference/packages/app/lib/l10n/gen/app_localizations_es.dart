// GENERATED CODE - DO NOT MODIFY BY HAND // coverage:ignore-file

import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Altoke App';

  @override
  String get genericRetryButtonLabel => 'Reintentar';

  @override
  String get appInitializationErrorMessage =>
      'Hubo un problema al intentar lanzar la aplicación';

  @override
  String get homeAppBarTitle => 'Ejemplos';

  @override
  String get counterExampleListTileTitle => 'Contador';

  @override
  String get counterAppBarTitle => 'Contador';

  @override
  String counterPushTimesMessage(int pushTimes) {
    final intl.NumberFormat pushTimesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String pushTimesString = pushTimesNumberFormat.format(pushTimes);

    String _temp0 = intl.Intl.pluralLogic(
      pushTimes,
      locale: localeName,
      other: 'Has pulsado el botón $pushTimesString veces',
      one: 'Has pulsado el botón una vez',
      zero: 'Aún no has pulsado el botón',
    );
    return '$_temp0.';
  }

  @override
  String get counterIncrementButtonTooltip => 'Incrementar';

  @override
  String get counterResetButtonTooltip => 'Reiniciar';

  @override
  String get tasksExampleListTileTitle => 'Tareas';

  @override
  String get tasksAppBarTitle => 'Tareas';

  @override
  String get noTasksFoundMessage => 'No se han encontrado tareas';

  @override
  String get createTaskButtonTooltip => 'Crear tarea';

  @override
  String get newTaskFormTitleLabel => 'Título';

  @override
  String get newTaskFormDescriptionLabel => 'Descripción';

  @override
  String get newTaskFormPriorityLabel => 'Prioridad';

  @override
  String get newTaskFormPriorityLowLabel => 'Baja';

  @override
  String get newTaskFormPriorityMediumLabel => 'Media';

  @override
  String get newTaskFormPriorityHighLabel => 'Alta';

  @override
  String get newTaskFormSubmitButtonLabel => 'Crear tarea';

  @override
  String get createTaskSuccessMessage => 'Tarea creada exitosamente';

  @override
  String get createTaskTitleEmptyError => 'El título no puede estar vacío';

  @override
  String get createTaskDescriptionRequiredForHighPriorityTaskError =>
      'Una descripción es necesaria para tareas de alta prioridad';

  @override
  String get createTaskGenericMessage => 'Error inesperado al crear tarea';

  @override
  String get createTaskFailureInvalidDataMessage => 'Datos de tarea inválidos';

  @override
  String deleteTaskButtonTooltip(String taskTitle) {
    return 'Eliminar tarea \"$taskTitle\"';
  }
}
