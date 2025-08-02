import 'package:formz/formz.dart';

enum UnitValidationError { empty }

class UnitInput extends FormzInput<String, UnitValidationError> {
  const UnitInput.pure() : super.pure('');

  const UnitInput.dirty({String value = ''}) : super.dirty(value);

  @override
  UnitValidationError? validator(String value) {
    if (value.isEmpty) return UnitValidationError.empty;
    return null;
  }

  String? get errorMessage {
    return switch (displayError) {
      UnitValidationError.empty => 'Оберіть одиницю виміру',
      null => null,
    };
  }
}
