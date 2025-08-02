import 'package:formz/formz.dart';

enum NameValidationError { empty, tooShort, tooLong }

class NameInput extends FormzInput<String, NameValidationError> {
  const NameInput.pure() : super.pure('');

  const NameInput.dirty({String value = ''}) : super.dirty(value);

  static const _minLength = 2;
  static const _maxLength = 50;

  @override
  NameValidationError? validator(String value) {
    if (value.trim().isEmpty) return NameValidationError.empty;
    if (value.trim().length < _minLength) return NameValidationError.tooShort;
    if (value.trim().length > _maxLength) return NameValidationError.tooLong;
    return null;
  }

  String? get errorMessage {
    return switch (displayError) {
      NameValidationError.empty => 'Назва не може бути порожньою',
      NameValidationError.tooShort => 'Назва надто коротка',
      NameValidationError.tooLong => 'Назва надто довга',
      null => null,
    };
  }
}
