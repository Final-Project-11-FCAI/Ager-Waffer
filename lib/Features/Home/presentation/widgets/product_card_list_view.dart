import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Favorite/presentation/manager/all_favorite_items_bloc.dart';
import 'package:ager_waffer/Features/Favorite/presentation/manager/favorite_bloc.dart';
import 'package:ager_waffer/Features/Favorite/presentation/manager/favorite_state.dart';
import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/product_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ProductCardListView extends StatefulWidget {
  final ProductData product;

  const ProductCardListView({super.key, required this.product});

  @override
  State<ProductCardListView> createState() => _ProductCardListViewState();
}

class _ProductCardListViewState extends State<ProductCardListView> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: (){
        customAnimatedPushNavigation(
          context,
          ProductDetailsScreen(product: widget.product),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
          color: isDark ? kDarkModeColor : kWhiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isDark ? kLightDarkModeColor : Color.fromRGBO(110, 122, 135, 1)),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: LocalizeAndTranslate.getLanguageCode() == 'en'
                          ? 0
                          : 12.sp,
                      left: LocalizeAndTranslate.getLanguageCode() == 'en'
                          ? 12.sp
                          : 0,
                    ),
                    child:
                    widget.product.itemImages != null &&
                        widget.product.itemImages!.isNotEmpty
                        ? CachedNetworkImage(
                      imageUrl: widget.product.itemImages!.first,
                      width: 95.w,
                      height: 95.h,
                      fit: BoxFit.contain,
                      placeholder: (context, url) =>
                          Image.asset("assets/images/virtual_image.jpg",
                            width: 95.w,
                            height: 95.h,
                            fit: BoxFit.contain,
                          ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                    )
                        : Image.asset(
                      "assets/images/virtual_image.jpg",
                      width: 95.w,
                      height: 95.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Gap(10.w),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.name!,
                            style: font16BlackSemiBold.copyWith(color: isDark ? kWhiteColor : kBlackColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Gap(8.w),
                        Text(
                          "${widget.product.price} ${kEgp.tr()}/${widget.product.rentUnit}",
                          style: font16BlackSemiBold.copyWith(fontSize: 10, color: isDark ? kWhiteColor : kBlackColor),
                        ),
                      ],
                    ),
                    Text(
                      widget.product.condition!,
                      style: font16BlackSemiBold.copyWith(
                        color: isDark ? kWhiteColor.withOpacity(0.6) : Color.fromRGBO(85, 85, 85, 0.61),
                      ),
                    ),
                    Gap(5.h),
                    Row(
                      children: [
                        Text(
                          "${widget.product.averageRate}",
                          style: font16BlackSemiBold.copyWith(
                            fontSize: 10,
                            color: isDark ? kWhiteColor.withOpacity(0.8) : Color.fromRGBO(151, 151, 151, 1),
                          ),
                        ),
                        Gap(5.w),
                        ...List.generate(
                          5,
                              (index) => Icon(
                            Icons.star,
                            size: 14.sp,
                            color: index < widget.product.averageRate!.floor()
                                ? Colors.amber
                                : Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: BlocBuilder<FavoriteBloc, FavoriteState>(
                        buildWhen: (prev, curr) {
                          final id = widget.product.id;
                          return prev.favorites[id] != curr.favorites[id];
                        },
                        builder: (context, state) {
                          final isFavorite =
                              state.favorites[widget.product.id!] ?? false;

                          return GestureDetector(
                            onTap: () {
                              context.read<FavoriteBloc>().add(
                                ToggleFavoriteEvent(itemId: widget.product.id!),
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: Shared.height * 0.04.h,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              decoration: BoxDecoration(
                                color: isFavorite
                                    ? kRedColor.withOpacity(0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(14.sp),
                                border: Border.all(
                                  color: isFavorite ? kRedColor : Colors.grey,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite ? kRedColor : kGreyColor,
                                    size: 16.sp,
                                  ),
                                  Gap(4.w),
                                  Text(
                                    isFavorite ? "Saved" : "Save",
                                    style: font16BlackSemiBold.copyWith(
                                      fontSize: 12.sp,
                                      color: isFavorite ? kRedColor : kGreyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}