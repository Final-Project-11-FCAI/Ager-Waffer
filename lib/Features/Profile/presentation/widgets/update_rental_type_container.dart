import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateRentalTypeContainer extends StatefulWidget {
  const UpdateRentalTypeContainer({
    super.key,
    required this.onChanged,
    this.initialValue,
  });

  final ValueChanged<String> onChanged;
  final String? initialValue;

  @override
  State<UpdateRentalTypeContainer> createState() => _UpdateRentalTypeContainerState();
}

class _UpdateRentalTypeContainerState extends State<UpdateRentalTypeContainer> {

  final List<String> items = [
    "يومي",
    "أسبوعي",
    "شهري",
  ];

  int getSelectedIndex() {
    final value = widget.initialValue;

    if (value == null) return 0;

    if (value.contains("يوم")) return 0;
    if (value.contains("أسبوع")) return 1;
    if (value.contains("شهر")) return 2;

    return 0;
  }
  @override
  Widget build(BuildContext context) {
    final currentIndex = getSelectedIndex(); // 🔥 هنا

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
                widget.onChanged(items[index]);
              },
              child: Padding(
                padding: EdgeInsets.all(6.0.w),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: getSelectedIndex() == index ? kLightPrimaryColor : kSmallContainerColor,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Center(
                    child: Text(
                      items[index],
                      style: font15BlackRegular.copyWith(
                        fontSize: 17.sp,
                        fontWeight: medium,
                        color: getSelectedIndex() == index
                            ? kWhiteColor
                            : kBlackColor,
                      ),
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