import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/product_data_container.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/rental_type_container.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/upload_product_images_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<String> categoryOptions = ['مستلزمات سفر', 'إلكترونيات', 'مستلزمات المنزل', 'كتب', 'اخري'];
  List<String> governmentOptions = ['الإسكندرية', 'الإسماعيلية', 'الأقصر', 'البحر الأحمر'];
  List<String> productStatesOptions = ['بحالة ممتازة', 'إستعمال خفيف'];

  bool isAvailable = true;
  bool acceptNegotiation = false;
  String rentalType = "يومي";

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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Gap(30.h),
                  Text('نوع الإيجار', style: font16BlackSemiBold.copyWith(color: kSomeBlackColor),),
                  Gap(10.h),
                  RentalTypeContainer(
                    onChanged: (value) {
                      setState(() {
                        rentalType = value;
                      });
                    },
                  ),
                  Gap(20.h),
                  ProductDataContainer(hintText: 'سعر الإيجار (جنيه/${rentalType.substring(0, rentalType.length - 1)})',),
                  Gap(20.h),
                  ProductDataContainer(hintText: 'قيمة التأمين',),
                  Gap(20.h),
                  ProductDataContainer(hintText: 'المحافظة', isOptions: true,
                    options: governmentOptions,
                    optionsLength: governmentOptions.length,
                  ),
                  Gap(30.h),
                  buildSwitchRow(
                    title: "المنتج متاح حالياً",
                    value: isAvailable,
                    onChanged: (val) {
                      setState(() {
                        isAvailable = val;
                      });
                    },
                  ),
                  Gap(5.h),
                  buildSwitchRow(
                    title: "أقبل التفاوض على السعر",
                    value: acceptNegotiation,
                    onChanged: (val) {
                      setState(() {
                        acceptNegotiation = val;
                      });
                    },
                  ),
                  Gap(20.h),
                  ButtonApp(onPressed: (){}, text: 'إضافة المنتج', color: kPrimaryColor)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildSwitchRow({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: kLightPrimaryColor,
          activeColor: kWhiteColor,
          inactiveTrackColor: kInactiveSwitchColor.withOpacity(0.3),
          inactiveThumbColor: kWhiteColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          trackOutlineWidth: MaterialStateProperty.all(0),
          trackOutlineColor: MaterialStateProperty.resolveWith<Color?>(
                (states) {
              if (states.contains(MaterialState.selected)) {
                return kLightPrimaryColor;
              }
              return kInactiveSwitchColor.withOpacity(0);
            },
          ),
        ),
        Gap(8.w),
        Text(
          title,
          style: font15BlackRegular.copyWith(fontWeight: semiBold)
        ),
      ],
    );
  }
}