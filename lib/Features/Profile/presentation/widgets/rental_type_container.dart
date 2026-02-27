import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RentalTypeContainer extends StatefulWidget {
  const RentalTypeContainer({super.key, required this.onChanged});
  final ValueChanged<String> onChanged;

  @override
  State<RentalTypeContainer> createState() => _RentalTypeContainerState();
}

class _RentalTypeContainerState extends State<RentalTypeContainer> {
  int selectedIndex = 0;
  final List<String> items = [
    "يومي",
    "أسبوعي",
    "شهري",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        color: kProductDataContainerColor,
        border: Border.all(color: kBorderColor, width: 1.w),
      ),
      child: Row(
        children: List.generate(
          items.length,
              (index) => Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onChanged(items[index]);
              },
              child: Padding(
                padding: EdgeInsets.all(6.0.w),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? kLightPrimaryColor
                        : kSmallContainerColor,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Center(
                    child: Text(
                      items[index],
                      style: font15BlackRegular.copyWith(
                        fontSize: 17.sp,
                        fontWeight: medium,
                        color: selectedIndex == index
                            ? kWhiteColor
                            : kBlackColor,
                      )
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
