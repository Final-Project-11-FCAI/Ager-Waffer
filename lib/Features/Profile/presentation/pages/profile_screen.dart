import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/domain/entities/product_entity.dart';
import 'package:ager_waffer/Features/Profile/presentation/pages/add_product_screen.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/my_products_item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final List<ProductEntity> products = [
    ProductEntity(
      title: "كرسي طعام للأطفال",
      subtitle: "جديد",
      price: "30 جنيه/اليوم",
      image: "assets/images/children_chair.png",
      rating: 4.5,
    ),
    ProductEntity(
      title: "شنطة تبريد",
      subtitle: "استعمال خفيف",
      price: "10 جنيه/اليوم",
      image: "assets/images/cooler_bag.png",
      rating: 3.5,
    ),
    ProductEntity(
      title: "مكنسة كهربائية",
      subtitle: "جديد",
      price: "50 جنيه/اليوم",
      image: "assets/images/vacuum_cleaner.png",
      rating: 4.5,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButton: CircleAvatar(
        radius: 25.r,
        child: FloatingActionButton(
          tooltip: 'إضافة منتج',
        onPressed: (){
            customAnimatedPushNavigation(context, AddProductScreen());
        },
            elevation: 3.sp,
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.add, color: kWhiteColor,))),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: Shared.height * 0.22.h),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: Shared.height * 0.05.h),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.04.w),
                  child: Column(
                    children: [
                      Text(
                        'Ahmed Ali',
                        style: font24PrimarySemiBold.copyWith(color: kBlackColor),
                      ),
                      Text(
                        'ahmedali@gmail.com',
                        style: font16BlackSemiBold.copyWith(color: kBlackColor.withOpacity(0.64),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('4.5', style: font20PrimaryMedium.copyWith(fontSize: 15.sp),),
                          Gap(3.w),
                          Icon(Icons.star, size: 17.sp, color: Colors.amber),
                        ],
                      ),
                      // Container(
                      //   height: Shared.height * 0.075.sp,
                      //   width: Shared.width * 0.75.sp,
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //     color: kOpacityWhiteColor,
                      //     borderRadius: BorderRadius.circular(20.r),
                      //   ),
                      //   child: Padding(
                      //     padding: EdgeInsets.all(5.0.h),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         editOrAddProductButton(title: 'تعديل', onTap: () {},),
                      //         editOrAddProductButton(title: 'إضافة منتج', onTap: () {})
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Gap(14.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('منتجاتي', style: font16BlackSemiBold.copyWith(fontSize: 20),)
                        ],
                      ),
                      Gap(5.h),
                      SizedBox(
                        height: Shared.height * 0.62.h,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: products.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return MyProductsItemListView(product: products[index],);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: Shared.width * 0.25.sp,
            left: Shared.width * 0.25.sp,
            top: Shared.height * 0.032.sp,
            child: Image.asset('assets/images/user_profile_image.png'),
          ),
        ],
      ),
    );
  }

  GestureDetector editOrAddProductButton({required String? title, required void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Shared.width * 0.35.sp,
        decoration: BoxDecoration(
          color: kSomeGreyColor,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Center(child: Text(title.toString(),style: font16BlackSemiBold.copyWith(fontSize: 14.sp),)),
      ),
    );
  }
}
