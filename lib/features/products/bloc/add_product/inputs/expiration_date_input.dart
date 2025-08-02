import 'package:formz/formz.dart';

enum ExpirationDateValidationError { empty, past }

class ExpirationDateInput
    extends FormzInput<DateTime?, ExpirationDateValidationError> {
  const ExpirationDateInput.pure() : super.pure(null);

  const ExpirationDateInput.dirty([super.value]) : super.dirty();

  @override
  ExpirationDateValidationError? validator(DateTime? value) {
    if (value == null) return ExpirationDateValidationError.empty;

    final now = DateTime.now();
    if(value.isBefore(DateTime(now.year, now.month, now.day))){
      return ExpirationDateValidationError.past;
    } else {
      return null;
    }
  }

  String? get errorMessage {
    return switch (displayError) {
      ExpirationDateValidationError.empty => 'Дата не може бути порожньою',
      ExpirationDateValidationError.past => 'Дата не може бути у минулому',
      null => null,
    };
  }
}
