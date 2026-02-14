import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/data/models/product_model.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/custom_home_app_bar.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/product_card_list_view.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<ProductModel> products = [
    ProductModel(
      title: "خيمة للرحلات",
      subtitle: "جديد",
      price: "20 جنيه/اليوم",
      image: "assets/images/tent.png",
      rating: 4.5,
    ),
    ProductModel(
      title: "شنطة ظهر",
      subtitle: "استعمال خفيف",
      price: "30 جنيه/اليوم",
      image: "assets/images/Backpack.png",
      rating: 3.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: CustomHomeAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchTextField(),
              Gap(14),
              Text('العناصر المقترحة',
              style: font14BlackBold,
              ),
              Gap(8),
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
    );
  }
}