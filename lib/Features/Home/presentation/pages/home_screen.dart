import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/domain/entities/category_entity.dart';
import 'package:ager_waffer/Features/Home/domain/entities/product_entity.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/category_item_list_view.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/custom_home_app_bar.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/product_card_list_view.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<ProductEntity> products = [
    ProductEntity(
      title: "خيمة للرحلات",
      subtitle: "جديد",
      price: "20 جنيه/اليوم",
      image: "assets/images/tent.png",
      rating: 4.5,
    ),
    ProductEntity(
      title: "شنطة ظهر",
      subtitle: "استعمال خفيف",
      price: "30 جنيه/اليوم",
      image: "assets/images/Backpack.png",
      rating: 3.5,
    ),
  ];

  final List<CategoryEntity> categories = [
    CategoryEntity(
      title: "إلكترونيات",
    ),
    CategoryEntity(
      title: "مستلزمات المنزل",
    ),
    CategoryEntity(
      title: "كتب",
    ),
    CategoryEntity(
      title: "أغراض أطفال",
    ),
    CategoryEntity(
      title: "أخري",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: kWhiteColor,
        appBar: CustomHomeAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchTextField(),
                Gap(14.h),
                Text('الفئات',
                  style: font14BlackBold,
                ),
                Gap(10.h),
                SizedBox(
                  height: 40.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CategoryItemListView(category: categories[index],);
                    },
                  ),
                ),
                Gap(18.h),
                Text('العناصر المقترحة',
                style: font14BlackBold,
                ),
                Gap(8.h),
                ListView.builder(
                  itemCount: products.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ProductCardListView(product: products[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}