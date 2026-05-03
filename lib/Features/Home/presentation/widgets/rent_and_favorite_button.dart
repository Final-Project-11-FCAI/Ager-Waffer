import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Favorite/presentation/manager/favorite_bloc.dart';
import 'package:ager_waffer/Features/Favorite/presentation/manager/favorite_state.dart';
import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/all_items_bloc.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/request_screen.dart';
import 'package:ager_waffer/Features/Authentication/login/data/models/login_model.dart' as login;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:gap/gap.dart';

class RentAndFavoriteButton extends StatelessWidget {
  const RentAndFavoriteButton({super.key, required this.product});

  final ProductData product;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: isDark ? kMoreDarkModeColor : kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                product.isAvailable == true
                    ? customAnimatedPushNavigation(
                        context,
                        RequestScreen(product: product),
                      )
                    : null;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: product.isAvailable == true
                    ? isDark
                          ? kButtonColor
                          : kPrimaryColor
                    : kGreyColor,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Text(
                kRentNow.tr(),
                style: font16BlackSemiBold.copyWith(
                  fontSize: 14.sp,
                  color: kWhiteColor,
                ),
              ),
            ),
          ),
          Gap(10.w),
          Expanded(
            child: BlocBuilder<FavoriteBloc, FavoriteState>(
              buildWhen: (prev, curr) {
                final id = product.id;
                return prev.favorites[id] != curr.favorites[id];
              },
              builder: (context, asyncSnapshot) {
                return OutlinedButton(
                  onPressed: () {
                      product.isFavourite = !product.isFavourite!;
                      context.read<FavoriteBloc>().add(
                        ToggleFavoriteEvent(itemId: product.id!),
                      );
                      context.read<AllItemsBloc>().add(
                        GetAllItemsEvent(),
                      );
                      if(product.isFavourite == true){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 1),
                            backgroundColor: kGreenColor,
                            content: Text(
                              kAddedFavoritesList.tr(),
                            ),
                          ),
                        );
                      }
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: kWhiteColor,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    side: BorderSide(
                      color: kPrimaryColor.withOpacity(0.5)
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    product.isFavourite! ? kRemoveFavorites.tr() : kAddToFavorite.tr(),
                    style: font16BlackSemiBold.copyWith(
                      fontSize: 13.sp,
                      color: kPrimaryColor,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
