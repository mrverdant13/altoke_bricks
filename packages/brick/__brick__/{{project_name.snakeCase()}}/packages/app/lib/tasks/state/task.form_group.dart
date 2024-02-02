import 'package:reactive_forms/reactive_forms.dart';

class TaskFormGroup extends FormGroup {
  TaskFormGroup()
      : titleControl = FormControl<String>(
          validators: [
            Validators.required,
          ],
        ),
        descriptionControl = FormControl<String>(
          validators: [],
        ),
        super({}) {
    addAll({
      titleControlName: titleControl,
      descriptionControlName: descriptionControl,
    });
  }

  static const titleControlName = 'title';
  final FormControl<String> titleControl;

  static const descriptionControlName = 'description';
  final FormControl<String> descriptionControl;
}
