import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/domain/entities/product_entity.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/product_card_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeEssentialsScreen extends StatelessWidget {
  HomeEssentialsScreen({super.key});

  final List<ProductEntity> products = [
    ProductEntity(
      title: "خيمة للرحلات",
      subtitle: "جديد",
      price: 20,
      image: "assets/images/tent.png",
      rating: 4.5,
    ),
    ProductEntity(
      title: "شنطة ظهر",
      subtitle: "استعمال خفيف",
      price: 30,
      image: "assets/images/Backpack.png",
      rating: 3.5,
    ),
    ProductEntity(
      title: "مشاية أطفال",
      subtitle: "بحالة جيدة",
      price: 30,
      image: "assets/images/baby_walker.png",
      rating: 3.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          foregroundColor: kWhiteColor,
          title: Text("مستلزمات المنزل",
            style: font16BlackSemiBold.copyWith(
              fontSize: 20,
              color: kWhiteColor,
            ),
          ),
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
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Shared.width * 0.04.w,
                vertical: Shared.height * 0.025.h,
              ),
              child: ListView.builder(
                itemCount: products.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ProductCardListView(product: products[index]);
                },
              ),
            )
        )
    );
  }
}