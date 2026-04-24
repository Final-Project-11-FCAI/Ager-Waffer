import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class EmptyFavorite extends StatelessWidget {
  const EmptyFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Image.asset('assets/images/favorite_empty.png'),
        Gap(Shared.height * 0.04.h),
        Text( kNoFavoritesYet.tr(),
          textAlign: TextAlign.center,
          style: font24PrimarySemiBold.copyWith(fontWeight: bold),),
        Gap(5.h),
        Text(kAddFavoritesHint.tr(),
          textAlign: TextAlign.center,
          style: font20PrimaryMedium.copyWith(color: kBorderColor,fontSize: 18),)
      ],
    );
  }
}
