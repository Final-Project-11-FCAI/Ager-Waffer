import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/domain/entities/product_entity.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/renatl_terms_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key,   this.product});
  final ProductEntity? product;
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

  int get totalPrice => totalDays * widget.product!.price;

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
    return Scaffold(
      backgroundColor: kPrimaryColor,

      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kWhiteColor),
      ),

      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: kWhiteColor,
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  children: [
                    Image.asset(widget.product!.image, width: 90),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                widget.product!.title,
                                style: font16BlackSemiBold,
                              ),

                              Text(
                                "${widget.product!.price}ج/اليوم",
                                style: font16BlackSemiBold.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.product!.subtitle,
                            style: font16BlackSemiBold.copyWith(
                              color: kBlueColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "${widget.product!.rating}",
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
                                  color: index < widget.product!.rating.floor()
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
                height: 2,
                color: kBlackColor,
                indent: 100,
                endIndent: 100,
                thickness: 2,
              ),

              const SizedBox(height: 20),

              Text(
                "فترة الإيجار",
                style: font16BlackSemiBold.copyWith(fontSize: 16),
              ),

              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Color.fromARGB(255, 240, 240, 240),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
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
                      SizedBox(height: 10),
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
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 95,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.blue[50],
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.timelapse, color: kBlueColor),
                                Text(
                                  totalDays > 0 ? "المدة: $totalDays أيام" : "",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "ملخص السعر",
                style: font16BlackSemiBold.copyWith(fontSize: 16),
              ),

              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color.fromARGB(255, 240, 240, 240),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      buildPriceRow(
                        Text(
                          "سعر اليوم",
                          style: font15SomeBlackColorMedium.copyWith(
                            fontSize: 13,
                            color: kBlackColor,
                          ),
                        ),
                        Text(
                          "${widget.product!.price}ج/اليوم",
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
                      Divider(height: 2, color: kGreyColor, thickness: 1),

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

              const SizedBox(height: 20),

              const Text(
                "بيانات المستأجر",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              buildTextField(
                Text("الاسم بالكامل", style: font15BlackRegular),
                Icons.person,
              ),

              const SizedBox(height: 10),

              buildTextField(
                Text("رقم الهاتف", style: font15BlackRegular),
                Icons.phone,
              ),

              const SizedBox(height: 10),

              buildTextField(
                Text("العنوان", style: font15BlackRegular),
                Icons.location_on,
              ),

              const SizedBox(height: 10),

              buildTextField(
                Text("البريد الإلكتروني", style: font15BlackRegular),
                Icons.email,
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Checkbox(
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
                    onPressed: () {
                      customAnimatedPushNavigation(
                            context,
                            RenatlTermsScreen()
                          );
                    },
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

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

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

                  child: const Text(
                    "تأكيد طلب الإيجار",
                    style: TextStyle(fontSize: 16, color: kWhiteColor),
                  ),
                ),
              ),
            ],
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
            const Icon(Icons.calendar_today),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 4),

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
