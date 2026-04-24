import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/search_screen.dart';
import 'package:ager_waffer/Features/Notification/presentation/pages/notifications_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../Authentication/login/data/models/login_model.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return FutureBuilder<Data?>(
      future: sharedPreferenceManager.getUser(),
      builder: (context, snapshot) {
        print("snapshot : $snapshot");
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('${kError.tr()}: ${snapshot.error}');
        }

        final user = snapshot.data;
        return AppBar(
          backgroundColor: isDark ? kDarkModeColor : kWhiteColor,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      child: ClipOval(
                        child: user?.imageUrl != null && user!.imageUrl!.isNotEmpty
                            ? CachedNetworkImage(
                          imageUrl: user.imageUrl!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Image.asset(
                            'assets/images/virtual_user.jpg',
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/virtual_user.jpg',
                            fit: BoxFit.cover,
                          ),
                        )
                            : Image.asset(
                          'assets/images/virtual_user.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Gap(8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${kHello.tr()}, ${user!.firstName}",
                            overflow: TextOverflow.ellipsis,
                            style: font15BlackRegular.copyWith(color: isDark ? kWhiteColor : kBlackColor,),
                          ),
                          Gap(2),
                          Text(
                            kWhatDoYouWant.tr(),
                            overflow: TextOverflow.ellipsis,
                            style: font14GreyRegular,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      customAnimatedPushNavigation(context, SearchScreen());
                    },
                    child: Image.asset(
                      'assets/images/search_icon.png',
                      width: 19.sp,
                      color: isDark ? kWhiteColor : kBlackColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Shared.width * 0.04.w,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        customAnimatedPushNavigation(
                          context,
                          NotificationsScreen(),
                        );
                      },
                      child: Image.asset(
                        'assets/images/notification_icon.png',
                        width: Shared.width * 0.06.w,
                        color: isDark ? kWhiteColor : kBlackColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Icon(Icons.menu, size: 26.sp,
                      color: isDark ? kWhiteColor : kBlackColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
