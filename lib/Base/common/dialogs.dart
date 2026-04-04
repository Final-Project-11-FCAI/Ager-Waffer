import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/all_items_bloc.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/bottom_nav_cubit.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/home_layout_screen.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/delete_item_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Dialogs {

  static Future<void>? showDialogSuccess(parentContext, {
    required String title,
    required String subTitle,
    required String textButton,
    required VoidCallback onPressed,
  }) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return AlertDialog(
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.02),
            child: Column(
              children: [
                Image.asset('assets/images/success_image.png'),
                SizedBox(height: Shared.height * 0.015),
                Gap(6.h),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: font20PrimaryMedium.copyWith(fontWeight: bold),
                ),
                Gap(6.h),
                Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: font16BlackSemiBold.copyWith(
                    fontWeight: medium,
                    color: kMoreGreyColor,
                  ),
                ),
                Gap(15.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Shared.height * 0.015,
                  ),
                  child: ButtonApp(
                    onPressed: onPressed,
                    text: textButton,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  static Future<void>? showDialogDeleteProduct(parentContext,
      {required int productId}) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return AlertDialog(
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.02),
            child: Column(
              children: [
                Image.asset('assets/images/dialog_delete_icon.png'),
                SizedBox(height: Shared.height * 0.01),
                Gap(6.h),
                Text(
                  " حذف المنتج ؟ ",
                  textAlign: TextAlign.center,
                  style: font20PrimaryMedium.copyWith(fontWeight: bold),
                ),
                Gap(10.h),
                Text(
                  "هل أنت متأكد من حذف هذا المنتج؟ لن تتمكن من استعادته بعد إتمام عملية الحذف.",
                  textAlign: TextAlign.center,
                  style: font16BlackSemiBold.copyWith(
                    fontWeight: medium,
                    color: kMoreGreyColor,
                  ),
                ),
                Gap(15.h),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Shared.height * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<DeleteItemBloc>().add(
                            DeleteItemEvent(
                              productId: productId,
                            ),
                          );
                          Navigator.of(context).pop();
                          context.read<AllItemsBloc>().add(
                            GetAllItemsEvent(),
                          );
                          allItemsBloc.add(GetAllItemsEvent());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Shared.width * 0.05.w,
                            vertical: Shared.height * 0.008.h,
                          ),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: kPrimaryColor,
                              width: 1.w,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Shared.width * 0.04.w,
                              vertical: Shared.height * 0.006.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'حذف'.toString(),
                                  style: font16BlackSemiBold.copyWith(
                                    fontSize: 14.sp,
                                    color: kWhiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Shared.width * 0.06.w,
                            vertical: Shared.height * 0.008.h,
                          ),
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: kPrimaryColor,
                              width: 1.w,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Shared.width * 0.04.w,
                              vertical: Shared.height * 0.006.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'إلغاء'.toString(),
                                  style: font16BlackSemiBold.copyWith(
                                    fontSize: 14.sp,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}