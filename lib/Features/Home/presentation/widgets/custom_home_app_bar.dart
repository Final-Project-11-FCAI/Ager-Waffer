import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/login_bloc.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/search_screen.dart';
import 'package:ager_waffer/Features/Notification/presentation/pages/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final user = loginBloc.state.user;
    return AppBar(
      backgroundColor: kWhiteColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: user.imageUrl != null ?
                  NetworkImage(user.imageUrl!)  
                : AssetImage('assets/images/virtual_user.jpg'),
              ),
              Gap(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('أهلا، ${user.firstName}', style: font15BlackRegular),
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
                child: GestureDetector(
                    onTap: (){
                      customAnimatedPushNavigation(context, NotificationsScreen());
                    },
                    child: Image.asset('assets/images/notification_icon.png', width: Shared.width * 0.06.w,)),
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
