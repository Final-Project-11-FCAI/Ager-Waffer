import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDataContainer extends StatefulWidget {
  const ProductDataContainer({
    super.key,
    required this.hintText,
    this.isOptions = false,
    this.isDescription = false, this.options, this.optionsLength,
  });

  final String hintText;
  final bool isOptions;
  final bool isDescription;
  final int? optionsLength;
  final List<String>? options;

  @override
  State<ProductDataContainer> createState() => _ProductDataContainerState();
}

class _ProductDataContainerState extends State<ProductDataContainer> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: widget.isDescription
              ? Shared.height * 0.2.h
              : Shared.height * 0.08.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            color: kProductDataContainerColor,
            border: Border.all(color: kBorderColor, width: 1.w),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.04.w),
            child: widget.isOptions
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.hintText, style: font15SomeBlackColorMedium),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isOpen = !isOpen;
                          });
                        },
                        child: Icon(
                          isOpen
                              ? CupertinoIcons.chevron_up
                              : CupertinoIcons.chevron_down,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  )
                : TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      hintStyle: font15SomeBlackColorMedium,
                    ),
                  ),
          ),
        ),
        isOpen
            ? Padding(
                padding: EdgeInsets.only(top: Shared.height * 0.012.h),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    color: kWhiteColor,
                    border: Border.all(color: kBorderColor, width: 1.w),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Shared.width * 0.04.w,
                      vertical: Shared.height * 0.02.h,
                    ),
                    child: ListView.builder(
                      itemCount: widget.optionsLength,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: Shared.height * 0.01.h),
                          child: Text(widget.options![index] ?? '', style: font15SomeBlackColorMedium.copyWith(color: kBlackColor),
                          ),
                        );
                    },)
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
