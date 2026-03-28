import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/data/models/login_model.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/login_bloc.dart';
import 'package:ager_waffer/Features/Home/domain/entities/category_entity.dart';
import 'package:ager_waffer/Features/Home/domain/entities/product_entity.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/category_pages/baby_items_screen.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/category_pages/books_screen.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/category_pages/electronics_screen.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/category_pages/home_essentials_screen.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/category_pages/other_screen.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/category_pages/travel_essentials_screen.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/carousel_slider_container.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/category_item_list_view.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/custom_home_app_bar.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/drawer_details.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/product_card_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

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
    final List<CategoryEntity> categories = [
      CategoryEntity(
        image: 'assets/images/electronics.png',
        title: "إلكترونيات",
        onTap: () {
          customAnimatedPushNavigation(context, ElectronicsScreen());
        },
      ),
      CategoryEntity(
        image: 'assets/images/home_supplies.png',
        title: "مستلزمات المنزل",
        onTap: () {
          customAnimatedPushNavigation(context, HomeEssentialsScreen());
        },
      ),
      CategoryEntity(
        image: 'assets/images/travel_supplies.png',
        title: "مستلزمات السفر",
        onTap: () {
          customAnimatedPushNavigation(context, TravelEssentialsScreen());
        },
      ),
      CategoryEntity(
        image: 'assets/images/books.png',
        title: "كتب",
        onTap: () {
          customAnimatedPushNavigation(context, BooksScreen());
        },
      ),
      CategoryEntity(
        image: 'assets/images/children_items.png',
        title: "أغراض أطفال",
        onTap: () {
          customAnimatedPushNavigation(context, BabyItemsScreen());
        },
      ),
      CategoryEntity(
        image: 'assets/images/others.png',
        title: "أخري",
        onTap: () {
          customAnimatedPushNavigation(context, OtherScreen());
        },
      ),
    ];
    return GestureDetector(
      onTap: () {
        Data user = context.read<LoginBloc>().state.user;
        print("user : ${user.toJson()}");
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        drawer: Drawer(width: Shared.width * 0.8, child: DrawerDetails()),
        backgroundColor: kWhiteColor,
        appBar: CustomHomeAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Shared.height * 0.25.h,
                  child: CarouselSliderContainer(),
                ),
                Gap(14.h),
                Text('الفئات', style: font14BlackBold),
                Gap(10.h),
                SizedBox(
                  height: Shared.height * 0.2.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: categories[index].onTap,
                        child: CategoryItemListView(
                          category: categories[index],
                        ),
                      );
                    },
                  ),
                ),
                Gap(18.h),
                Text('العناصر المقترحة', style: font14BlackBold),
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
