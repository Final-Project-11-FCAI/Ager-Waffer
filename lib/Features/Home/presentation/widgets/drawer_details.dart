import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/login_screen.dart';
import 'package:ager_waffer/Features/Manage_Orders/presentation/pages/manage_orders_screen.dart';
import 'package:ager_waffer/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../Authentication/login/data/models/login_model.dart';

class DrawerDetails extends StatefulWidget {
  const DrawerDetails({super.key});

  @override
  State<DrawerDetails> createState() => _DrawerDetailsState();
}

class _DrawerDetailsState extends State<DrawerDetails> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Shared.width * 0.04.w,
              vertical: Shared.height * 0.03.h,
            ),
            decoration: BoxDecoration(color: kDrawerColor.withOpacity(0.05)),
            child: FutureBuilder<Data?>(
                  future: sharedPreferenceManager.getUser(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    final user = snapshot.data;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(user?.imageUrl ?? 'assets/images/virtual_user.jpg'),
                            ),
                            Gap(8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${user?.firstName ?? ''} ${user?.lastName ?? ''}",
                                  style: font15BlackRegular.copyWith(fontWeight: semiBold),
                                ),
                                Gap(2),
                                Text(
                                  user?.email ?? '',
                                  style: font13kLightPrimaryColorMedium.copyWith(
                                    color: kGreyColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        CircleAvatar(
                          backgroundColor: kBorderColor.withOpacity(0.09),
                          radius: 20.r,
                          child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: Icon(Icons.arrow_forward_ios_sharp, color: kGreyColor)),
                        ),
                      ],
                    );
                  },
                ),
          ),
          Divider(height: 1.h, thickness: 0.8, color: kBorderColor),
          Gap(Shared.height * 0.02.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.0.w),
            child: Column(
              children: [
                drawerItem(
                  title: kManageOrders.tr(),
                  icon: 'assets/images/management_orders.png',
                  onTap: () {
                    Navigator.of(context).pop();
                    customAnimatedPushNavigation(context, ManageOrdersScreen());
                  },
                ),
                Gap(2.h),
                drawerItem(
                  title: kLanguage.tr(),
                  icon: 'assets/images/language.png',
                  onTap: () {
                    showLanguageDialog();
                  },
                ),
                Gap(2.h),
                drawerItem(
                  title: kDarkMode.tr(),
                  icon: 'assets/images/dark_mode.png',
                  isDarkMode: true,
                ),
                Gap(2.h),
                drawerItem(
                  title: kContactUs.tr(),
                  icon: 'assets/images/contact_us.png',
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Shared.height * 0.03.h),
            child: Divider(height: 1.h, thickness: 0.8, color: kBorderColor),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Shared.height * 0.02.h),
            child: TextButton(
              onPressed: () async {
                sharedPreferenceManager.removeData(CachingKey.AUTH_TOKEN);
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.exit_to_app_outlined,
                    color: kMoreRedColor,
                    size: 30.sp,
                  ),
                  Gap(8.w),
                  Text(
                    kLogout.tr(),
                    style: font16BlackSemiBold.copyWith(
                      color: kMoreRedColor,
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            kLanguage.tr(),
            style: font20PrimaryMedium.copyWith(fontWeight: bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                visualDensity: VisualDensity.compact,
                leading: Image.asset("assets/images/english_flag.png"),
                title: Text("English", style: font16BlackSemiBold,),
                onTap: () async {
                  await changeLanguage("en");
                  MyMaterial.setLocale(context, Locale("en"));
                },
              ),
              Divider(),
              ListTile(
                visualDensity: VisualDensity.compact,
                leading: Image.asset("assets/images/egypt_flag.png"),
                title: Text("العربية", style: font16BlackSemiBold,),
                onTap: () async {
                  await changeLanguage("ar");
                  MyMaterial.setLocale(context, Locale("ar"));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> changeLanguage(String lang) async {
    await LocalizeAndTranslate.setLanguageCode(lang);

    MyMaterial.setLocale(context, Locale(lang));

    sharedPreferenceManager.writeData(
      CachingKey.APP_LANGUAGE,
      lang,
    );

    Navigator.pop(context);
  }


  TextButton drawerItem({
    required String? title,
    required String? icon,
    bool isDarkMode = false,
    Function()? onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(icon!, width: 40.w, height: 40.h),
              Text(
                title!,
                style: font20PrimaryMedium.copyWith(
                  fontSize: 17.sp,
                  color: kLightPrimaryColor,
                ),
              ),
            ],
          ),
          isDarkMode
              ? Switch(
            value: MyMaterial.isDark,
            activeTrackColor: kLightPrimaryColor,
                  activeColor: kWhiteColor,
                  inactiveTrackColor: kInactiveSwitchColor.withOpacity(0.3),
                  inactiveThumbColor: kWhiteColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  trackOutlineWidth: MaterialStateProperty.all(0),
                  trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((
                    states,
                  ) {
                    if (states.contains(MaterialState.selected)) {
                      return kLightPrimaryColor;
                    }
                    return kInactiveSwitchColor.withOpacity(0);
                  }),
              onChanged: (value) {
                MyMaterial.toggleTheme(context, value);

                sharedPreferenceManager.writeData(
                  CachingKey.DARK_MODE,
                  value,
                );
              },
                )
              : Padding(
                padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.04.w),
                child: Icon(Icons.arrow_forward_ios_outlined),
              ),
        ],
      ),
    );
  }
}
