import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
class InputValidation{
  static String isValidName(String name) {
    /*final regex = RegExp(r'^[a-zA-Z\s]+$');
    return name.isNotEmpty && name.length > 2 && regex.hasMatch(name);*/
    if (name == null || name.isEmpty) {
      return kEnter_full_name.tr();
    }
    if (name.length < 3 || name.length > 100) {
      return kfull_name_validation.tr();
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(name)) {
      return kfull_name_special_char.tr();
    }
    return '';
  }
  static bool isValidNameValidation(String name) {
    final regex = RegExp(r'^[a-zA-Z\s]+$');
    return name.isNotEmpty && name.length > 2 && regex.hasMatch(name);

  }

  static bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  static bool isValidMobile(String mobile) {
    final mobileRegExp = RegExp(
        r'^[5-9][0-9]{8}$');
    return mobileRegExp.hasMatch(mobile);
  }
}

class MobileValidator {
  // This function checks if the mobile number is valid.
  static bool isValidMobile(String mobile) {
    final mobileRegExp = RegExp(r'^[5-9][0-9]{8}$');
    return mobileRegExp.hasMatch(mobile);
  }

  // Function to validate the mobile number and return appropriate messages.
  static String validateMobile(String mobile) {
    if (mobile.isEmpty) {
      return kplease_enter_valid_phone_number.tr();
    }

    // Check for length
    if (mobile.length != 9) {
      return ksaudi_wrong_number.tr();
    }

    // Check validity
    if (!isValidMobile(mobile)) {
      return kplease_enter_valid_phone_number.tr();
    }

    // If the number is valid, you can add additional uniqueness checks here.
    // For example, you might check against a database of existing numbers.

    return "";
  }
}
