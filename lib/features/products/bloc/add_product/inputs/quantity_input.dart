import 'package:formz/formz.dart';

enum QuantityValidationError { empty, invalid }

class QuantityInput extends FormzInput<String, QuantityValidationError> {
  const QuantityInput.pure() : super.pure('');

  const QuantityInput.dirty({String value = ''}) : super.dirty(value);

  @override
  QuantityValidationError? validator(String value) {
    if (value.trim().isEmpty) return QuantityValidationError.empty;
    final number = double.tryParse(value);
    if (number == null || number <= 0) return QuantityValidationError.invalid;
    return null;
  }

  String? get errorMessage => switch (displayError) {
    QuantityValidationError.empty => 'Поле не може бути порожнім',
    QuantityValidationError.invalid => 'Введіть число більше нуля',
    null => null,
  };
}
