import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kWhiteColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile_image.png'),
              ),
              Gap(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('أهلا، علي', style: font15BlackRegular),
                  Gap(2),
                  Text(' تحب تستأجر ايه؟', style: font14GreyRegular),
                ],
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: (){
                    customAnimatedPushNavigation(context, SearchScreen());
                  },
                  child: Image.asset('assets/images/search_icon.png', width: 19.sp,)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.04.w),
                child: Image.asset('assets/images/notification_icon.png', width: Shared.width * 0.06.w,),
              ),
              GestureDetector(
                  onTap: (){
                    Scaffold.of(context).openDrawer();
                  },
                  child: Icon(Icons.menu, size: 26.sp,)),
            ],
          ),
        ],
      ),
    );
  }
}
