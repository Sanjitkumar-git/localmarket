

import 'package:formz/formz.dart';
import 'package:easy_localization/easy_localization.dart' ;

class NameInput extends FormzInput<String, ValidationError> {
  const NameInput.pure({String value = ''}) : super.pure(value);
  const NameInput.dirty({String value = ''}) : super.dirty(value);
  

  @override
  ValidationError? validator(String? value) {
    if (isPure) return null;
    if (value == null || value.trim().isEmpty) return ValidationError.empty;

final nameRegex = RegExp(r'^[\p{L}\p{M}]+(\s+[\p{L}\p{M}]+)+$', unicode: true);
    return nameRegex.hasMatch(value.trim())
        ? null
        : ValidationError.invalidName;
  }
}

class PasswordInput extends FormzInput<String, ValidationError> {
  const PasswordInput.pure() : super.pure('');

  const PasswordInput.dirty({String value = ''}) : super.dirty(value);
  static final RegExp passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  @override
  ValidationError? validator(String? value) => isPure
      ? null
      : value == null || value.isWhiteSpace
          ? ValidationError.empty
          : passwordRegex.hasMatch(value)
              ? null
              : ValidationError.passwordIncorrect;
}

class EmailInput extends FormzInput<String, ValidationError> {
  const EmailInput.pure() : super.pure('');

  const EmailInput.dirty({String value = ''}) : super.dirty(value);
 static final RegExp gmailRegex =
    RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');

  @override
  ValidationError? validator(String? value) => isPure
      ? null
      : value == null || value.isWhiteSpace
          ? ValidationError.empty
          :gmailRegex.hasMatch(value) ? null:
            ValidationError.invalidEmail;
            
}

class ConfirmPasswordInput extends FormzInput<String, ValidationError> {
  final String password;

  const ConfirmPasswordInput.pure({this.password = ''}) : super.pure('');

  const ConfirmPasswordInput.dirty({
    required String value,
    required this.password,
  }) : super.dirty(value);

  @override
  ValidationError? validator(String? value) {
    if (isPure) return null;
if (value == null || value.trim().isEmpty) return ValidationError.empty;
  
  return value == password ? null : ValidationError.passwordNotSame;

  
  }
}
class CaloriesInput extends FormzInput<String, ValidationError> {
  // Use '=' for default values, not ':'
  const CaloriesInput.pure({String value = ''}) : super.pure(value);
  const CaloriesInput.dirty({String value = ''}) : super.dirty(value);

  @override
  ValidationError? validator(String? value) {
    if (isPure) return null;
    if (value == null || value.trim().isEmpty) return ValidationError.empty;
    
    // Simple check to see if the string contains only numbers
    final isDigitsOnly = RegExp(r'^[0-9]+$').hasMatch(value);
    
    return isDigitsOnly ? null : ValidationError.invalidCalories;
  }
}

// String Extension for WhiteSpace
extension on String {
  bool get isWhiteSpace => trim().isEmpty;
}

// validationError class
enum ValidationError {
  empty('validation.field_required'),
  invalidName('validation.invalid_name'),
  passwordIncorrect('validation.password_weak'),
  passwordNotSame('validation.password_mismatch'),
  invalidEmail('validation.invalid_email'),
  invalidPhone('validation.invalid_phone'),
  invalidCalories('validation.invalid_number');

  const ValidationError(this.errorKey);

  final String errorKey;

  String get errorText => tr(errorKey);
}