import 'package:get/get.dart';

/// returns a validator that validates emtpy for the given field name
String? Function(String? name) validateEmptyField(String fieldname) {
  return (String? value) {
    if (value!.isEmpty) {
      return "$fieldname Can't be Empty";
    }
    return null;
  };
}

String? validatePassword(String? password) {
  if (password!.isEmpty) {
    return "Password Can't be Empty";
  }
  if ((password.trim().length) < 6) {
    return "Password Can't be less than 6";
  }

  return null;
}

String? validateEmail(String? email) {
  if (!GetUtils.isEmail(email?.trim() ?? "")) {
    return "Provide valid Email";
  }

  return null;
}

String? validateName(String? name) {
  if (name!.isEmpty) {
    return "Name Can't be Empty";
  }
  return null;
}
