import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 60.h, left: 20.w, right: 20.w, bottom: 30.h),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kEmergency.tr(),
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: kWhiteColor,
                        fontWeight: bold,
                      ),
                    ),
                    Gap(5.h),
                    Text(
                      kNeedHelp.tr(),
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(20.h),
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kCall.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: kPrimaryColor,
                  ),
                ),
                Gap(15.h),
                _buildRow("122", kPolice.tr()),
                _buildRow("123", kAmbulance.tr()),
                _buildRow("180", kFirefighters.tr()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      ),
    );
  }

  Widget _buildRow(String number, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: ListTile(
          onTap: () async{
            final Uri url = Uri.parse("tel:$number");
            await launchUrl(url);
          },
          title: Row(
            children: [
              Text(
                title,
                style: const TextStyle(color: kWhiteColor),
              ),
              Gap(10.w),
              Text(
                number,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: kWhiteColor
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.call, color: kWhiteColor),
        ),
      ),
    );
  }
}