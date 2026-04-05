import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EmptyProducts extends StatelessWidget {
  const EmptyProducts({super.key, required this.image, required this.title, required this.subTitle, this.titleFontSize = 24,});

  final String image;
  final String title;
  final String subTitle;
  final double titleFontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Shared.height * 0.02.h),
      child: Column(
        children: [
          Image.asset(image),
          Text(title,
            textAlign: TextAlign.center,
            style: font24PrimarySemiBold.copyWith(fontWeight: bold, fontSize: titleFontSize.sp),),
          Gap(5.h),
          Text(subTitle,
            textAlign: TextAlign.center,
            style: font20PrimaryMedium.copyWith(color: kBorderColor,fontSize: 18.sp),),
          //
          // ButtonApp(onPressed: (){}, text: 'إضافة منتج', color: kPrimaryColor, borderRadius: Shared.width * 0.06.h,)
        ],
      ),
    );
  }
}
