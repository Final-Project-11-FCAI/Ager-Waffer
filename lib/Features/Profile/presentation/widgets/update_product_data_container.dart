import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateProductDataContainer extends StatefulWidget {
  const UpdateProductDataContainer({
    super.key,
    required this.hintText,
    this.isOptions = false,
    this.isDescription = false,
    this.options = const [],
    this.optionsLength,
    this.controller,
    this.keyboardType,
    this.onItemSelected,
    this.initialValue, // 🔥 الجديد
  });

  final String hintText;
  final bool isOptions;
  final bool isDescription;
  final int? optionsLength;
  final List<String> options;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String)? onItemSelected;
  final String? initialValue; // 🔥 الجديد

  @override
  State<UpdateProductDataContainer> createState() => _UpdateProductDataContainerState();
}

class _UpdateProductDataContainerState extends State<UpdateProductDataContainer> {
  bool isOpen = false;
  String? selectedValue;

  @override
  void initState() {
    super.initState();

    // 🔥 لو في initial value حطها
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      selectedValue = widget.initialValue;
    }
  }

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
                Text(
                  selectedValue ?? widget.hintText,
                  style: font15SomeBlackColorMedium.copyWith(
                    color: selectedValue == null
                        ? kGreyColor
                        : kBlackColor,
                  ),
                ),
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
                : TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: font15SomeBlackColorMedium,
              ),
            ),
          ),
        ),

        isOpen
            ? AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: isOpen
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Padding(
            padding:
            EdgeInsets.only(top: Shared.height * 0.012.h),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                color: kWhiteColor,
                border:
                Border.all(color: kBorderColor, width: 1.w),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Shared.width * 0.04.w,
                  vertical: Shared.height * 0.02.h,
                ),
                child: ListView.builder(
                  itemCount: widget.optionsLength,
                  shrinkWrap: true,
                  physics:
                  const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        String value = widget.options[index];

                        setState(() {
                          selectedValue = value;
                          isOpen = false;
                        });

                        widget.onItemSelected?.call(value);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical:
                          Shared.height * 0.01.h,
                        ),
                        child: Text(
                          widget.options[index],
                          style:
                          font15SomeBlackColorMedium.copyWith(
                            color: kBlackColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          secondChild: const SizedBox(),
        )
            : const SizedBox(),
      ],
    );
  }
}