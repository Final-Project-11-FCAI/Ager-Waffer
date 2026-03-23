import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/login_screen.dart';
import 'package:ager_waffer/Features/Manage_Orders/presentation/pages/manage_orders_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

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
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/profile_image.png',
                  ),
                ),
                Gap(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'أحمد علي',
                      style: font15BlackRegular.copyWith(fontWeight: semiBold),
                    ),
                    Gap(2),
                    Text(
                      'ahmedali@gmail.com',
                      style: font13kLightPrimaryColorMedium.copyWith(
                        color: kGreyColor,
                      ),
                    ),
                  ],
                ),
                Gap(35.w),
                CircleAvatar(
                  backgroundColor: kBorderColor.withOpacity(0.09),
                  radius: 20.r,
                  child: Icon(Icons.arrow_forward_ios_sharp, color: kGreyColor),
                ),
              ],
            ),
          ),
          Divider(height: 1.h, thickness: 0.8, color: kBorderColor),
          Gap(Shared.height * 0.02.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.04.w),
            child: Column(
              children: [
                drawerItem(
                  title: 'إدارة الطلبات',
                  icon: 'assets/images/management_orders.png',
                  onTap: () {
                    Navigator.of(context).pop();
                    customAnimatedPushNavigation(context, ManageOrdersScreen());
                  },
                ),
                Gap(2.h),
                drawerItem(title: 'اللغة', icon: 'assets/images/language.png'),
                Gap(2.h),
                drawerItem(
                  title: 'الوضع الداكن',
                  icon: 'assets/images/dark_mode.png',
                  isDarkMode: true,
                ),
                Gap(2.h),
                drawerItem(
                  title: 'تواصل معنا',
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
                    'تسجيل الخروج',
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
                  value: isSwitched,
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
                    setState(() {
                      isSwitched = value;
                    });
                  },
                )
              : Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
  }
}
