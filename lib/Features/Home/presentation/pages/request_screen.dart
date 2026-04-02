import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:ager_waffer/Features/Home/domain/entities/product_entity.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key, required this.product});
  final ProductData product;

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  DateTime? startDate;
  DateTime? endDate;

  int dailyPrice = 50;

  bool agree = false;

  int get totalDays {
    if (startDate != null && endDate != null) {
      return endDate!.difference(startDate!).inDays + 1;
    }
    return 0;
  }

  double get totalPrice => totalDays * widget.product.price!;

  Future<void> _selectDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;

          if (endDate != null && endDate!.isBefore(startDate!)) {
            endDate = null;
          }
        } else {
          endDate = picked;
        }
      });
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return "اختر التاريخ";
    return DateFormat('yyyy/MM/dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: kWhiteColor),
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: kWhiteColor,
              ),
              padding: EdgeInsets.all(Shared.width * 0.04.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(Shared.width * 0.04),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Row(
                      children: [
                        // Image.asset(widget.product.itemImages![0], width: 90),
                        widget.product.itemImages != null && widget.product.itemImages!.isNotEmpty
                            ? CachedNetworkImage(
                          imageUrl: widget.product.itemImages!.first,
                          width: 90.w,
                          height: 90.h,
                          fit: BoxFit.contain,
                          placeholder: (context, url) =>
                              Image.asset("assets/images/virtual_image.jpg"),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ) : Image.asset(
                          "assets/images/virtual_image.jpg",
                          width: 90.w,
                          height: 90.h,
                          fit: BoxFit.contain,
                        ),
                        Gap(8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.product.name!,
                                      overflow: TextOverflow.ellipsis,
                                      style: font16BlackSemiBold,
                                    ),
                                  ),
                                  Gap(8.w),
                                  Text(
                                    "${widget.product.price}ج/${widget.product.rentUnit}",
                                    style: font16BlackSemiBold.copyWith(
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                widget.product.condition!,
                                style: font16BlackSemiBold.copyWith(
                                  color: kBlueColor,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    "${widget.product.averageRate!}",
                                    style: font16BlackSemiBold.copyWith(
                                      fontSize: 10,
                                      color: Color.fromRGBO(151, 151, 151, 1),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: kBlackColor,
                    indent: 50,
                    endIndent: 50,
                    thickness: 1,
                  ),
                  Gap(20.h),
                  Text(
                    "فترة الإيجار",
                    style: font16BlackSemiBold.copyWith(fontSize: 16),
                  ),
                  Gap(10.h),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Color.fromARGB(255, 240, 240, 240),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(Shared.width * 0.05),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "تاريخ البداية",
                                style: font15SomeBlackColorMedium.copyWith(
                                  color: kgreyColor,
                                ),
                              ),
                              Text(
                                "تاريخ النهاية",
                                style: font15SomeBlackColorMedium.copyWith(
                                  color: kgreyColor,
                                ),
                              ),
                            ],
                          ),
                          Gap(10.h),
                          Row(
                            children: [
                              Expanded(
                                child: buildDateBox(
                                  startDate,
                                      () => _selectDate(true),
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: buildDateBox(
                                  endDate,
                                      () => _selectDate(false),
                                ),
                              ),
                            ],
                          ),
                          Gap(10.h),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: Colors.blue[50],
                                ),
                                child: totalDays > 0 ?
                                Row(
                                  children: [
                                    Image.asset('assets/images/period.png'),
                                    Gap(5.w),
                                    Text(
                                      "المدة: $totalDays أيام",
                                    ),
                                  ],
                                ) : SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(20.h),
                  Text(
                    "ملخص السعر",
                    style: font16BlackSemiBold.copyWith(fontSize: 16),
                  ),
                  Gap(10.h),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: const Color.fromARGB(255, 240, 240, 240),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(Shared.width * 0.04),
                      child: Column(
                        children: [
                          buildPriceRow(
                            Text(
                              "سعر ${widget.product.rentUnit}",
                              style: font15SomeBlackColorMedium.copyWith(
                                fontSize: 13,
                                color: kBlackColor,
                              ),
                            ),
                            Text(
                              "${widget.product.price}ج/${widget.product.rentUnit}",
                              style: font15SomeBlackColorMedium.copyWith(
                                fontSize: 13,
                                color: kBlackColor,
                              ),
                            ),
                          ),
                          buildPriceRow(
                            Text(
                              "عدد الأيام",
                              style: font15SomeBlackColorMedium.copyWith(
                                fontSize: 13,
                                color: kBlackColor,
                              ),
                            ),
                            Text(
                              totalDays > 0 ? "$totalDays" : "--",
                              style: font15SomeBlackColorMedium.copyWith(
                                fontSize: 13,
                                color: kBlackColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Divider(height: 1, color: kGreyColor, thickness: 1),
                          ),

                          buildPriceRow(
                            Text(
                              "الإجمالي",
                              style: font14BlackBold.copyWith(fontSize: 13),
                            ),
                            Text(
                              totalDays > 0 ? "$totalPrice جنيه" : "--",
                              style: font14BlackBold.copyWith(fontSize: 13),
                            ),
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(20.h),
                  const Text(
                    "بيانات المستأجر",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Gap(15.h),
                  buildTextField(
                    Text("الاسم بالكامل", style: font15BlackRegular),
                    Icons.person,
                  ),
                  Gap(25.h),
                  buildTextField(
                    Text("رقم الهاتف", style: font15BlackRegular),
                    Icons.phone,
                  ),
                  Gap(25.h),
                  buildTextField(
                    Text("العنوان", style: font15BlackRegular),
                    Icons.location_on,
                  ),
                  Gap(25.h),
                  buildTextField(
                    Text("البريد الإلكتروني", style: font15BlackRegular),
                    Icons.email,
                  ),
                  Gap(25.h),
                  Row(
                    children: [
                      Checkbox(
                        visualDensity: VisualDensity.compact,
                        value: agree,
                        onChanged: (value) {
                          setState(() {
                            agree = value!;
                          });
                        },
                        activeColor: kPrimaryColor,
                      ),
                      Text(
                        "بإرسال الطلب أنت توافق علي",
                        style: font15SomeBlackColorMedium.copyWith(fontSize: 14),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'شروط الإيجار',
                          style: font14BlackBold.copyWith(
                            color: kPrimaryColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(20.h),
                  ButtonApp(
                      onPressed: () {
                        if (!agree) {
                          AwesomeDialog(
                            titleTextStyle: font14BlackBold.copyWith(fontSize: 24),
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: "يجب الموافقة على الشروط",
                            headerAnimationLoop: false,
                          ).show();
                          return;
                        }

                        if (startDate == null || endDate == null) {
                          AwesomeDialog(
                            titleTextStyle: font14BlackBold.copyWith(fontSize: 24),
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: "اختر فترة الإيجار",
                            headerAnimationLoop: false,
                          ).show();
                          return;
                        }
                      },
                      text: "تأكيد طلب الإيجار",
                      color: kPrimaryColor,
                    borderRadius: Shared.width * 0.04.w,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDateBox(DateTime? date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kPartGreyColor),
        ),

        child: Row(
          children: [
            Image.asset('assets/images/date_determine.png'),
            Gap(10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(4.h),
                Text(formatDate(date), style: const TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPriceRow(Widget title, Widget value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [title, value],
      ),
    );
  }

  Widget buildTextField(Widget text, IconData icon) {
    return SizedBox(
      height: 60,
      child: TextField(
        textAlign: TextAlign.right,

        decoration: InputDecoration(
          label: text,
          contentPadding: EdgeInsets.all(36),
          prefixIcon: Icon(icon),

          filled: true,

          fillColor: kWhiteColor,

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}