import 'dart:developer';

import 'package:email_validator/email_validator.dart';

class Validator {

  validateEmail(String email) {
    final formatted = email.trim();
    if (formatted.isEmpty) {
      return "Digite seu e-mail";
    }
    if (!EmailValidator.validate(formatted)) {
      return "E-mail inválido.";
    }
    return null;
  }

  validatePassword(String password) {
    final formatted = password.trim();
    if (formatted.isEmpty) {
      return "Digite sua senha";
    }
    return null;
  }

  validateName(String name) {
    final formatted = name.trim();
    if (formatted.isEmpty) {
      return "Digite seu nome";
    }
    return null;
  }

}