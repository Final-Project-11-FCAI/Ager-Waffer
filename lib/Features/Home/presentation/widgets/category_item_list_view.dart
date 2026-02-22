import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CategoryItemListView extends StatelessWidget {
  const CategoryItemListView({super.key, required this.category});

  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Shared.width * 0.31.w,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 3.sp,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.sp)),
            margin: const EdgeInsets.symmetric(horizontal: 0,),
            color: kWhiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Google.png', width: 50.w, height: 40.h,),
              Gap(5.h),
              Text(
                category.title,
                textAlign: TextAlign.center,
              style: font14BlackBold.copyWith(fontWeight: medium,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
