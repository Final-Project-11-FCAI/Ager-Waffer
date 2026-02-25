import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Orders/domain/entities/finished_orders_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinishedOrders extends StatelessWidget {
  FinishedOrders({super.key});

  final List<FinishedOrdersEntity> finishedOrders = [
    FinishedOrdersEntity(
      image: 'assets/images/camera.png',
      title: 'Canon EOS كاميرا',
      owner: 'احمد محمد',
      time: '1 فبراير - 5 فبراير',
      price: '500جنيه',
    ),
    FinishedOrdersEntity(
      image: 'assets/images/stroller.png',
      title: 'عربة أطفال',
      owner: 'ندي خالد',
      time: '5 مارس - 5 يوليو',
      price: '1000جنيه',
    ),
    FinishedOrdersEntity(
      image: 'assets/images/electric_stove.png',
      title: 'بوتجاز كهربائي',
      owner: 'يوسف محمد',
      time: '5 مارس - 5 يوليو',
      price: '200جنيه',
    ),
    ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: finishedOrders.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Shared.width * 0.04.w,
            vertical: Shared.height * 0.025.h,
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: kBlackColor.withOpacity(0.2),
                width: 1.w,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Shared.width * 0.04.w,
                    vertical: Shared.height * 0.02.h,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(finishedOrders[index].image),
                      Gap(20.h),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            finishedOrders[index].title,
                            style: font16BlackSemiBold.copyWith(
                              color: kPrimaryColor,
                            ),
                          ),
                          Gap(2.w),
                          Text(
                            "المالك: ${finishedOrders[index].owner}",
                            style: font13kLightPrimaryColorMedium.copyWith(
                              color: kBlackColor,
                            ),
                          ),
                          Gap(5.w),
                          Row(
                            children: [
                              Image.asset('assets/images/date_determine.png'),
                              Gap(5.w),
                              Text(
                                finishedOrders[index].time,
                                style: font20PrimaryMedium.copyWith(
                                  fontSize: 12.sp,
                                  color: kTextGreyColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gap(10),
                Divider(
                  height: 1,
                  thickness: 0.7,
                  color: kBlackColor.withOpacity(0.19),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Shared.width * 0.04.w,
                    vertical: Shared.height * 0.02.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'إجمالي المبلغ',
                        style: font13kLightPrimaryColorMedium.copyWith(
                          color: kDarkGreyColor,
                        ),
                      ),
                      Text(
                        finishedOrders[index].price,
                        style: font24LightPrimarySemiBold.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Shared.width * 0.1.w,
                  ),
                  child: Divider(
                    height: 1,
                    thickness: 0.5,
                    color: kBlackColor.withOpacity(0.19),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Shared.width * 0.04.w,
                    vertical: Shared.height * 0.02.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      orderButton(text: 'إعادة التأجير', icon: 'assets/images/refresh.png', backgroundColor: kLightPrimaryColor, textColor: kWhiteColor),
                      orderButton(text: 'تقييم المنتج', icon: 'assets/images/star.png', backgroundColor: kWhiteColor, textColor: kPrimaryColor),
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

  GestureDetector orderButton({
    required String text,
    required String icon,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: Shared.width * 0.41.w,
        height: Shared.height * 0.065.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: kLightPrimaryColor, width: 1.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, width: 20.w, height: 20.h),
            Gap(5),
            Text(
              text,
              style: font13kLightPrimaryColorMedium.copyWith(
                fontSize: 15.sp,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
