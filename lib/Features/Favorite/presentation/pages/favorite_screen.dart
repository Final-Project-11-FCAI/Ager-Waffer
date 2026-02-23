import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Favorite/domain/entities/favorite_entity.dart';
import 'package:ager_waffer/Features/Favorite/presentation/widgets/favorite_item_gide_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final List<FavoriteEntity> favorites = [
    FavoriteEntity(
      title: 'بروجيكتور محمول',
      price: '100ج',
      image: 'assets/images/portable_projector.png',
      rating: 4.5,
      isAvailable: true,
    ),
    FavoriteEntity(
      title: 'سكوتر كهربائي',
      price: '120ج',
      image: 'assets/images/electric_scooter.png',
      rating: 4.7,
      isAvailable: true,
    ),
    FavoriteEntity(
      title: 'ميزان 60 كيلو',
      price: '60ج',
      image: 'assets/images/balance.png',
      rating: 4.0,
      isAvailable: false,
    ),
    FavoriteEntity(
      title: 'جهاز بخار للتعقيم',
      price: '60ج',
      image: 'assets/images/steam_sterilizer.png',
      rating: 5.0,
      isAvailable: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'العناصر المفضلة',
          style: font16BlackSemiBold.copyWith(
            color: kWhiteColor,
            fontWeight: bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
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
          child: GridView.builder(
            itemCount: favorites.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15.w,
              crossAxisSpacing: 15.w,
              childAspectRatio: 2 / 3.1,
            ),
            itemBuilder: (context, index) {
              return FavoriteItemGideView(favoriteEntity: favorites[index]);
            },
          ),
        ),
      ),
    );
  }
}
