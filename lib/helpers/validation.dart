import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:helmy_project/resources/strings_manager.dart';

class ValidationHelper {
  static String? validatePhone(BuildContext context, String? value) {
    String minimumNumPattern = r'^[0-9]';
    String validNumPattern = r'^01\d+';
    RegExp minimumNumRegExp = RegExp(minimumNumPattern);
    RegExp validNumRegExp = RegExp(validNumPattern);
    if (value!.isEmpty) {
      return tr('enter_correct_phone_number');
    }
    // else if (value.length < 11) {
    //   return tr('enter_phone_number_length');
    // } else if (!minimumNumRegExp.hasMatch(value)) {
    //   return tr('enter_valid_phone_number1');
    // } else if (!validNumRegExp.hasMatch(value)) {
    //   return tr('enter_valid_phone_number2');
    // }
    return null;
  }

  static String? validateConfirmPassword(
      String password, String confirmPassword, BuildContext context) {
    if (password.isEmpty || confirmPassword.isEmpty) {
      return tr('confirm_password_empty');
    }

    if (password != confirmPassword) {
      return tr('password_mismatch');
    }

    return null;
  }

  static String? validateFullName(BuildContext context, String? value) {
    if (value!.isEmpty) {
      return tr('enter_name');
    } else if (!RegExp(
            r'^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z- _]*$')
        .hasMatch(value)) {
      return tr('enter_name');
    }
    return null;
  }

  static String? validateText(BuildContext context, String? value) {
    if (value!.isEmpty) {
      return tr('enter_name');
    } else if (!RegExp(
            r'^[0-9\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z-@!#$ _]*$')
        .hasMatch(value)) {
      return tr('enter_wrongly');
    }
    return null;
  }

  static String? validateNumber(BuildContext context, String? value) {
    if (value!.isEmpty) {
      return tr('enter_wrongly');
    } else if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
      return tr('enter_wrongly');
    }
    return null;
  }

  static String? validateEmail(BuildContext context, String? value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value!)) {
      return tr('enter_valid_email');
    }
    return null;
  }

  static String? validatePassword(BuildContext context, String? password) {
    if (password!.isEmpty) {
      return tr('enter_password');
    } else if (password.length < 8) {
      return tr('pw_must_be_min_8_chars');
    } else {
      return null;
    }
  }

  static String? fillFormValidation(BuildContext context, String? text) {
    if (text!.isEmpty) {
      return '';
    } else {
      return null;
    }
  }

  static String? validateReview(BuildContext context, String? value) {
    if (value!.isEmpty) {
      return tr('enter_review');
    }
    return null;
  }

  static String? validateCity(BuildContext context, String? selectedCity) {
    if (selectedCity == null || selectedCity.isEmpty) {
      return tr('select_city');
    } else {
      return null;
    }
  }

  static String? validateLawyerSpecialty(
      BuildContext context, String? selectedCity) {
    if (selectedCity == null || selectedCity.isEmpty) {
      return tr(StringsManager.selectLawyerSpecialty);
    } else {
      return null;
    }
  }

  static String? validateArea(BuildContext context, String? selectedArea) {
    if (selectedArea == null || selectedArea.isEmpty) {
      return tr('select_area');
    } else {
      return null;
    }
  }
}
