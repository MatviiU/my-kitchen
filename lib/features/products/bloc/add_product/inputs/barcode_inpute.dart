import 'package:formz/formz.dart';

enum BarcodeValidationError { empty, invalid }

class BarcodeInput extends FormzInput<String, BarcodeValidationError> {
  const BarcodeInput.pure() : super.pure('');

  const BarcodeInput.dirty({String value = ''}) : super.dirty(value);

  static final _barcodeRegExp = RegExp(r'^\d{8}\$|^\d{12}\$|^\d{13}\$');

  @override
  BarcodeValidationError? validator(String value) {
    if (value.trim().isEmpty) return BarcodeValidationError.empty;
    if (!_barcodeRegExp.hasMatch(value)) return BarcodeValidationError.invalid;
    return null;
  }

  String? get errorMessage {
    return switch (displayError) {
      BarcodeValidationError.empty => 'Штрихкод не може бути порожнім',
      BarcodeValidationError.invalid => 'Неправильний формат штрихкоду',
      null => null,
    };
  }
}
