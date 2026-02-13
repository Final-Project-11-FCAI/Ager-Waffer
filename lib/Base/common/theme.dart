import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 24.0;
double defaultRadius = 10.0;

const Color kPrimaryColor = Color(0xff00334E);
const Color kLightPrimaryColor = Color(0xff145374);
const Color kWhiteColor = const Color(0xffFFFFFF);
const Color kBlackColor = const Color(0xFF2A2A2A);
const Color kGreyColor = const Color(0xff81868D);
const Color kBoldGreyColor = const Color(0xff00334EBD);


TextStyle font15BlackRegular = GoogleFonts.notoSansArabic(
  fontSize: 15.sp,
  color: kBlackColor,
  fontWeight: regular,
);
TextStyle font14GreyRegular = GoogleFonts.notoSansArabic(
  fontSize: 14.sp,
  color: kGreyColor,
  fontWeight: regular,
);
TextStyle font14BlackBold = GoogleFonts.notoSansArabic(
  fontSize: 14.sp,
  color: kBlackColor,
  fontWeight: bold,
);
TextStyle font20BoldGreyRegular = GoogleFonts.notoSansArabic(
  fontSize: 20.sp,
  color: kBoldGreyColor,
  fontWeight: regular,
);

TextStyle font24LightPrimarySemiBold = GoogleFonts.notoSansArabic(
  fontSize: 24.sp,
  color: kLightPrimaryColor,
  fontWeight: semiBold,
);
TextStyle font24PrimarySemiBold = GoogleFonts.notoSansArabic(
  fontSize: 24.sp,
  color: kPrimaryColor,
  fontWeight: semiBold,
);

TextStyle font20PrimaryMedium = GoogleFonts.notoSansArabic(
  fontSize: 20.sp,
  color: kPrimaryColor,
  fontWeight: medium,
);
TextStyle font16BlackSemiBold = GoogleFonts.notoSansArabic(
  fontSize: 16.sp,
  color: kBlackColor,
  fontWeight: semiBold,
);


FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

const Color kLightBlackColor = const Color(0xFF000D1B);
const Color kroseColor = const Color(0xFF62BAA1);
const Color kBlueAccentColor = const Color(0xFF009AB9);
const Color kMoreGreenColor = const Color(0xFF81C784);
const Color kUnActiveStepColor = const Color(0xFF979797);
const Color kredCarColor = const Color(0xFFFF0000);
const Color kborderColor = const Color(0xFFBDB8B8);
const Color kOpacityGreyColor = const Color(0xFFCFCFCF);
const Color kMoreYellowColor = const Color(0xFFFFBD52);
const Color kBrownColor = const Color(0xFF403430);
const Color kgreenCarColor = const Color(0xFF006D3D);
const Color kSomeRedColor = const Color(0xFFE57373);
const Color kblueCarColor = const Color(0xFF1D00CF);
const Color kDarkBlueColor = const Color(0xFF0A0067);
const Color kgreyCarColor = const Color(0xFFC4C4C4);
const Color kBorderColor = const Color(0xFFA5A5A5);
const Color kSomeNavyBlackColor = const Color(0xFF201C2C);
const Color kNavyBlackColor = const Color(0xFF354259);
const Color kyellowCarColor = const Color(0xFFFFE500);
const Color kSelectedTimeColor = const Color(0xFFC6C6C6);
const Color korangeCarColor = const Color(0xFFFF5C00);
const Color kburgundyCarColor = const Color(0xFF6D0115);
const Color kBoldRoseColor = const Color(0xFF28846E);
const Color kYellowCanaryColor = const Color(0xffFFCD1A);
const Color kContainerColor = const Color(0xffDDF5EA);
const Color kPickImageColor = const Color(0xff666666);
const Color kContainerBackgroundColor = const Color(0xffF0FAEF);
const Color kAssistantServices = const Color(0xff1E2245);
const Color kBackgroundNavBar = const Color(0xff62BAA1);
const Color kButtonNavBarColor = const Color(0xffFF7602);
const Color kPartWhiteColor = const Color(0xffd0cece);
const Color kPinkColor = const Color(0xffFF4B5C);
const Color kSemiBlackColor = const Color(0xff101C2D);
const Color kSomeWhiteColor = const Color(0xffececec);
const Color kBlueColor = const Color(0xff0056B3);
const Color kTextColor = const Color(0xFF6C757D);
const Color kButtonColor = const Color(0xFF007BFF);
const Color kMoreWhiteColor = const Color(0xffF8F9FA);
const Color kMoreBlueColor = const Color(0xff0061CA);
const Color kNavyBlueColor = const Color(0xFF343A40);
const Color kDividerColor = const Color(0xFFEDEAEA);
const Color kInactiveColor = const Color(0xFFD0D0D3);// const Color(0xFFC1C1C1);
const Color kBackgroundColor = const Color(0xFFFF6B3B);
const Color kDarkGreenColor = const Color(0xFF006D3D);
const Color kDarkGreyColor = const Color(0xff343A40);
const Color kGreenColor = const Color(0xFF62BAA1);
const Color kButtonAppColor = const Color(0xFFFF7602);
const Color kgreyColor = const Color(0xFF4A4A4A);
const Color kTimeNotificationColor = const Color(0xFF7B7B7B);
const Color kSemiGreyColor = const Color(0xffC1C1C1);
const Color kSomeGreyColor = const Color(0xffA4A0A0);
const Color kCardColor = const Color(0xffF1F1F6);
const Color kRedColor = const Color(0xFFFC1414);
const Color kTransparentColor = Colors.transparent;
const Color kAvailableColor = const Color(0xFFE7F0FD);
const Color kUnavailableColor = const Color(0xffEBECF1);
const Color kYellowColor = const Color(0xFFF39204);
const Color kGreenLight = const Color(0xFFE8F5E9);

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: kBlackColor,
);
TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: kWhiteColor,
);
TextStyle greyTextStyle = GoogleFonts.poppins(
  color: kNavyBlueColor,
);
TextStyle greenTextStyle = GoogleFonts.poppins(
  color: kGreenColor,
);
TextStyle redTextStyle = GoogleFonts.poppins(
  color: kRedColor,
);
TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: kPrimaryColor,
);

BottomNavigationBarThemeData bottomNavigationBarTheme =
    const BottomNavigationBarThemeData(
  selectedItemColor: kGreenColor,
  unselectedItemColor: kPrimaryColor,
  showSelectedLabels: true,
  showUnselectedLabels: true,
  type: BottomNavigationBarType.fixed,
);


ColorScheme kColorScheme = ColorScheme(
  primary: kPrimaryColor,
  primaryContainer: kBlackColor,
  secondary: kGreenColor,
  secondaryContainer: kGreenColor,
  surface: kBlackColor,
  background: kNavyBlueColor,
  error: Colors.red,
  onPrimary: kPrimaryColor,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.light,
);
