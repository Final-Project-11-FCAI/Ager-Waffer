
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;
import 'local_const.dart';

class Shared {
  static Uint8List base64ToImage(String base64String) {
    return base64Decode(base64String);
  }
  static showLoadingDialog({required BuildContext context}) {
    showDialog(
        context: context,
        useSafeArea: true,
        barrierDismissible: false,
        builder: (ctx) => SpinKitWave(
            color: Colors.white,
            size: 38.0,
          ),
        );
  }

  static dismissDialog({required BuildContext context}) {
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    }

  }

  // use thos widget to show loading while waiting data from backend
  static final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );

  // use this function to show message to user
  static void showSnackBarView({ String? message, String? backend_message,
    bool? error_status,  bool? sigin_button}) {

    var snackBar = SnackBar(
        content: Text( backend_message?? LocalizeAndTranslate.translate(message!),
          style: TextStyle(color: error_status!? kWhiteColor :kGreenColor,),
          textDirection: LocalizeAndTranslate.getLanguageCode() == 'en'? TextDirection.ltr : TextDirection.rtl,
        ),
      backgroundColor: error_status? kRedColor :kWhiteColor,
      action:  sigin_button!? SnackBarAction(
        label: LocalizeAndTranslate.translate(ksignin),
        textColor: kBlackColor,
        onPressed: () {
     //     customAnimatedPushNavigation(navigatorKey.currentContext!, SiginScreen());
        },
      ): null,
    );
    // Step 3
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
  }

  static Widget text_widget ({String? text,TextStyle?textStyle}){
    return Row(
      children: [
        Text("$text",style: textStyle,)
      ],
    );
  }

 static String carPlateNumberFormatText(String input) {
    // Separate Arabic letters and numbers
    String letters = input.replaceAll(RegExp(r'[0-9]'), '');
    String numbers = input.replaceAll(RegExp(r'[^\d]'), '');

    // Add spaces between letters
    String spacedLetters = letters.split('').join(' ');

    // Add spaces between numbers
    String spacedNumbers = numbers.split('').join(' ');

    // Combine letters and numbers with a hyphen
    return '$spacedLetters - $spacedNumbers';
  }

  // Function to check if this is the first time the app is being opened

  // Future<void> checkFirstTime() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final isFirstTime = prefs.getBool('isFirstTime') ?? true;
  //
  //   if (isFirstTime) {
  //     _navigateToOnboarding();
  //     prefs.setBool('isFirstTime', false);
  //   } else {
  //     startAuthentication();
  //   }
  // }

  // void _navigateToOnboarding() {
  //   customAnimatedPushNavigation(navigatorKey.currentContext!,  OnboardingScreen());
  // }

  // void startAuthentication() {
  //   Timer(const Duration(seconds: 2), () async {
  //     final token = await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
  //     checkAuthentication(token);
  //   });
  // }

  // Function to check if the user is authenticated or not
  // Future<void> checkAuthentication(String? token) async {
  //   if (token == null || token == "null") {
  //     setVisitorMode(value: true);
  //     navigateToHome();
  //   } else if (JwtDecoder.isExpired(token)) {
  //     await refreshToken();
  //   } else {
  //     navigateToHome();
  //   }
  // }

  void setVisitorMode({bool? value}) async{
    sharedPreferenceManager.writeData(CachingKey.VISITOR, value);
  }
  Future<bool> getVisitorMode() async {
    bool visitorMode = await sharedPreferenceManager.readBool(CachingKey.VISITOR);
    Shared.vistor_value = visitorMode;
    return visitorMode;
  }

  // Future<void> refreshToken() async {
  //   final refreshToken = await sharedPreferenceManager.readString(CachingKey.REFRESH_TOKEN);
  //   authenticationBloc.add(RefreshTokenEvent(refreshToken: refreshToken));
  // }

  // void navigateToLogin() {
  //   customAnimatedPushNavigation(navigatorKey.currentContext!, const LoginScreen());
  // }

  // void navigateToHome() {
  //   customAnimatedPushNavigation(navigatorKey.currentContext!,  IndexScreen());
  // }

  static String getTime({String? date}) {
    return intl.DateFormat('hh:mm a',LocalizeAndTranslate.getLanguageCode() == 'ar'? 'ar':'en').format(DateTime.parse(date ?? ''));
  }
  static String getDate({String? date}) {
    DateTime dateTime = DateTime.parse(date ?? '');
    return intl.DateFormat.yMMMMd(LocalizeAndTranslate.getLanguageCode() == 'ar'? 'ar':'en').format(dateTime);
  }


  // use this Object to hold user job search which enter by user then send to backend
  static double width = ScreenUtil.defaultSize.width;
  static double height = ScreenUtil.defaultSize.height;

  static bool hasSeviceProvider = false;

  // we use this variable  to indicate if user is authenticated or not 
  static bool? vistor_value = true;
  static List<Asset> assets_list = [];
  static List<File> carImagesList = [];
  static File? carFormImage ;
  static List<String> uploaded_images_list = [];


  static String car_form_image = '';
  static String car_manfacture_country = '';
}

Shared shared = new Shared();
