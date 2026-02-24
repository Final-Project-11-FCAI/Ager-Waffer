import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/product_data_container.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/upload_product_images_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  List<String> categoryOptions = ['مستلزمات سفر', 'إلكترونيات', 'مستلزمات المنزل', 'كتب', 'اخري'];
  List<String> governmentOptions = ['الإسكندرية', 'الإسماعيلية', 'الأقصر', 'البحر الأحمر'];
  List<String> productStatesOptions = ['بحالة ممتازة', 'إستعمال خفيف'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          foregroundColor: kWhiteColor,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Shared.width * 0.04.w,
                vertical: Shared.height * 0.025.h,
              ),
              child: Column(
                children: [
                  UploadProductImagesContainer(),
                  Gap(50.h),
                  ProductDataContainer(hintText: 'اسم المنتج',),
                  Gap(20.h),
                  ProductDataContainer(
                    hintText: 'الفئة',
                    isOptions: true,
                    options: categoryOptions,
                    optionsLength: categoryOptions.length,
                  ),
                  Gap(20.h),
                  ProductDataContainer(hintText: 'وصف المنتج...', isDescription: true,),
                  Gap(20.h),
                  ProductDataContainer(hintText: 'حالة المنتج', isOptions: true,
                    options: productStatesOptions,
                    optionsLength: productStatesOptions.length,
                  ),
                  Gap(20.h),

                  Gap(20.h),
                  ProductDataContainer(hintText: 'سعر الإيجار (جنيه/يوم)',),
                  Gap(20.h),
                  ProductDataContainer(hintText: 'قيمة التأمين',),
                  Gap(20.h),
                  ProductDataContainer(hintText: 'المحافظة', isOptions: true,
                    options: governmentOptions,
                    optionsLength: governmentOptions.length,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}