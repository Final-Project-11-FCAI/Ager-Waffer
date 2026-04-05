import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
class InputValidation{
  static String isValidName(String name, bool isFirstName) {
    /*final regex = RegExp(r'^[a-zA-Z\s]+$');
    return name.isNotEmpty && name.length > 2 && regex.hasMatch(name);*/
    if (name == null || name.isEmpty) {
      return isFirstName ? kEnter_first_name.tr() : kEnter_last_name.tr();
    }
    if (name.length < 3 || name.length > 100) {
      return kfull_name_validation.tr();
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(name)) {
      return kfull_name_special_char.tr();
    }
    return '';
  }


  static String isValidAddress(String value, String errorMessage) {
    if (value.trim().isEmpty) {
      return errorMessage;
    }
    return '';
  }

  static String isValidEgyptianPhone(String phone) {
    if (phone.isEmpty) {
      return 'من فضلك أدخل رقم الهاتف';
    }

    // يشيل أي مسافات
    phone = phone.trim();

    // Regex للموبايل المصري
    final regex = RegExp(r'^01[0125][0-9]{8}$');

    if (!regex.hasMatch(phone)) {
      return 'رقم هاتف غير صحيح';
    }

    return '';
  }

  static String? isValidEditEgyptianPhone(String phone) {
    if (phone.isEmpty) {
      return 'من فضلك أدخل رقم الهاتف';
    }

    phone = phone.trim();

    final regex = RegExp(r'^01[0125][0-9]{8}$');

    if (!regex.hasMatch(phone)) {
      return 'رقم هاتف غير صحيح';
    }

    return null;
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

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "كلمة المرور مطلوبة";
    }

    if (value.length < 8) {
      return "كلمة المرور يجب أن تكون 8 أحرف على الأقل";
    }

    // حرف كبير
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "يجب أن تحتوي على حرف كبير";
    }

    // حرف صغير
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "يجب أن تحتوي على حرف صغير";
    }

    // رقم
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "يجب أن تحتوي على رقم";
    }

    // رمز خاص
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "يجب أن تحتوي على رمز خاص";
    }

    return null; // ✅ valid
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
      return 'ksaudi_wrong_number'.tr();
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
