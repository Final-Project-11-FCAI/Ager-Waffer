import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/show_full_image_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({super.key, required this.product});
  final ProductData product;

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final images = widget.product.itemImages ?? [];

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 220.h,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          items: images.isNotEmpty
              ? images.map((image) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: isDark ? kSomeDarkModeColor : kOpacityGreyColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.r),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 400),
                          pageBuilder: (_, __, ___) => ShowFullImageScreen(
                            images: images,
                            initialIndex: currentIndex,
                          ),
                        ),
                      );
                    },
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        Image.asset("assets/images/virtual_image.jpg"),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
              ),
            );
          }).toList()
              : [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: kOpacityGreyColor,
              ),
              child: Image.asset(
                "assets/images/virtual_image.jpg",
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
        Gap(10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.isEmpty ? 1 : images.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              width: currentIndex == index ? 20.w : 8.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? kPrimaryColor
                    : kInactiveColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}