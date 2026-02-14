import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItemListView extends StatelessWidget {
  const CategoryItemListView({super.key, required this.category});

  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5,),
        padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
      border: BoxBorder.all(
        width: 1.w,
        color: Color.fromRGBO(0, 0, 0, 0.5)
      ),
        borderRadius: BorderRadius.circular(18.sp),
        color: kWhiteColor,
      ),
      child: Center(
        child: Text(
          category.title,
        style: font14BlackBold.copyWith(fontWeight: medium,),
        ),
      ),
    );
  }
}
