import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kWhiteColor,
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
                  Text('أهلا، علي', style: font15BlackRegular,),
                  Gap(2),
                  Text(' تحب تستأجر ايه؟', style: font14GreyRegular,)
                ],
              )
            ],
          ),
          Image.asset('assets/images/notification_icon.png')
        ],
      ),
    );
  }
}
