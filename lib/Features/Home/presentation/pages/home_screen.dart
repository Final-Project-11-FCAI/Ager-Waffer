import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    Gap(4),
                    Text(' تحب تستأجر ايه؟', style: font14GreyRegular,)
                  ],
                )
              ],
            ),
            Image.asset('assets/images/notification_icon.png')
          ],
        ),
      ),
    );
  }
}