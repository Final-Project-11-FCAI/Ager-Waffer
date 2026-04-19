import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/dialogs.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:ager_waffer/Features/Home/domain/entities/send_request_entity.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/send_request_bloc.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/send_request_state.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/renatl_terms_screen.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
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

  int periodCount = 1; // عدد الأسابيع أو الشهور

  int dailyPrice = 50;
  bool agree = false;

  bool isRequestSent = false;

  bool get isValid {
    if (startDate == null || endDate == null) return false;

    return agree && !endDate!.isBefore(startDate!);
  }

  int get totalDays {
    if (startDate != null && endDate != null) {
      return endDate!.difference(startDate!).inDays + 1;
    }
    return 0;
  }

  int calculateMonths(DateTime start, DateTime end) {
    int months = (end.year - start.year) * 12 + (end.month - start.month);

    if (end.day >= start.day) {
      months += 1;
    }

    return months;
  }

  double get totalPrice {
    if (startDate == null) return 0;

    if (widget.product.rentUnit == kWeekly.tr()) {
      return periodCount * widget.product.price!;
    }

    if (widget.product.rentUnit == kMonthly.tr()) {
      return periodCount * widget.product.price!;
    }

    return totalDays * widget.product.price!;
  }

  void updateEndDate() {
    if (startDate == null) return;

    bool isWeekly = widget.product.rentUnit == kWeekly.tr();
    bool isMonthly = widget.product.rentUnit == kMonthly.tr();

    setState(() {
      if (isWeekly) {
        endDate = startDate!.add(Duration(days: (7 * periodCount) - 1));
      } else if (isMonthly) {
        endDate = DateTime(
          startDate!.year,
          startDate!.month + periodCount,
          startDate!.day,
        ).subtract(const Duration(days: 1));
      }
    });
  }

  Future<void> _selectDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        bool isWeekly = widget.product.rentUnit == kWeekly.tr();
        bool isMonthly = widget.product.rentUnit == kMonthly.tr();

        if (isStart) {
          startDate = picked;

          if (isWeekly) {
            endDate = startDate!.add(Duration(days: (7 * periodCount) - 1));
          } else if (isMonthly) {
            endDate = DateTime(
              startDate!.year,
              startDate!.month + periodCount,
              startDate!.day,
            ).subtract(const Duration(days: 1));
          } else {
            if (endDate != null && endDate!.isBefore(startDate!)) {
              endDate = null;
            }
          }
        } else {
          if (isWeekly || isMonthly) return;

          if (startDate != null && picked.isBefore(startDate!)) return;

          endDate = picked;
        }
      });
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return kSelectDate.tr();
    return DateFormat('yyyy/MM/dd').format(date);
  }

  String period(String text) {
    switch (text.toLowerCase()) {
      case 'Daily':
        return kDaily.tr();
      case 'Weekly':
        return kWeekly.tr();
      case 'Monthly':
        return kMonthly.tr();
      default:
        return '';
    }
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

        body: BlocListener<SendRequestBloc, SendRequestState>(
          listener: (context, state) {
            if (state.status == sendRequestStatus.loading) {
              Shared.showLoadingDialog(context: context);
            } else if (state.status == sendRequestStatus.success) {
              Shared.dismissDialog(context: context);

              Dialogs.showDialogSuccess(
                context,
                title: kRequestSuccessTitle.tr(),
                subTitle: kRequestSuccessDesc.tr(),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    isRequestSent = true;
                  });
                },
                textButton: kOk.tr(),
              );
            } else if (state.status == sendRequestStatus.failure) {
              Shared.dismissDialog(context: context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.failureMessage ?? kSomethingWentWrong.tr(),
                  ),
                ),
              );
            }
          },
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.r),
                        topRight: Radius.circular(25.r),
                      ),
                      color: kWhiteColor,
                    ),
                    padding: EdgeInsets.all(Shared.width * 0.04.w),
                    child: SingleChildScrollView(
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
                                widget.product.itemImages != null &&
                                        widget.product.itemImages!.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            widget.product.itemImages!.first,
                                        width: 95.w,
                                        height: 95.h,
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                              "assets/images/virtual_image.jpg",
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
                                Gap(8.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                            "${widget.product.price} ${kPricePerUnit.tr()}/${widget.product.rentUnit == kDay.tr()
                                                ? kDay.tr()
                                                : widget.product.rentUnit == kWeekly.tr()
                                                ? kWeek.tr()
                                                : widget.product.rentUnit == kMonthly.tr()
                                                ? kMonth.tr()
                                                : ''}",
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
                                              color: Color.fromRGBO(
                                                151,
                                                151,
                                                151,
                                                1,
                                              ),
                                            ),
                                          ),
                                          Gap(5.w),
                                          ...List.generate(
                                            5,
                                            (index) => Icon(
                                              Icons.star,
                                              size: 14.sp,
                                              color:
                                                  index <
                                                      widget
                                                          .product
                                                          .averageRate!
                                                          .floor()
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
                            kRentalPeriod.tr(),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        kStartDate.tr(),
                                        style: font15SomeBlackColorMedium
                                            .copyWith(color: kgreyColor),
                                      ),
                                      Text(
                                        kEndDate.tr(),
                                        style: font15SomeBlackColorMedium
                                            .copyWith(color: kgreyColor),
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
                                  widget.product.rentUnit == kWeekly.tr() ||
                                          widget.product.rentUnit ==
                                              kMonthly.tr()
                                      ? Row(
                                          children: [
                                            Text(
                                              widget.product.rentUnit ==
                                                      kWeekly.tr()
                                                  ? kNumberOfWeeks.tr()
                                                  : kNumberOfMonths.tr(),
                                              style: font15SomeBlackColorMedium.copyWith(color: kgreyColor),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () {
                                                if (periodCount > 1) {
                                                  setState(() {
                                                    periodCount--;
                                                  });
                                                  updateEndDate();
                                                }
                                              },
                                              icon: const Icon(Icons.remove),
                                            ),
                                            CircleAvatar(
                                                radius: 15.r,
                                                backgroundColor: kSomeGreyColor,
                                                child: Text("$periodCount",style: font14GreyRegular.copyWith(color: kPrimaryColor, fontWeight: bold),)),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  periodCount++;
                                                });
                                                updateEndDate();
                                              },
                                              icon: const Icon(Icons.add),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(8.w),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16.r),
                                                color: Colors.blue[50],
                                              ),
                                              child: totalDays > 0
                                                  ? Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/period.png',
                                                        ),
                                                        Gap(5.w),
                                                        Text(
                                                          "${kDuration.tr()}: $totalDays ${kDays.tr()}",
                                                        ),
                                                      ],
                                                    )
                                                  : SizedBox.shrink(),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                          Gap(20.h),
                          Text(
                            kPriceSummary.tr(),
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
                                      "${kPricePerUnit.tr()} ${widget.product.rentUnit}",
                                      style: font15SomeBlackColorMedium
                                          .copyWith(
                                            fontSize: 13,
                                            color: kBlackColor,
                                          ),
                                    ),
                                    Text(
                                      "${widget.product.price} ${kEgp.tr()}/${widget.product.rentUnit}",
                                      style: font15SomeBlackColorMedium
                                          .copyWith(
                                            fontSize: 13,
                                            color: kBlackColor,
                                          ),
                                    ),
                                  ),
                                  buildPriceRow(
                                    Text(
                                      "${kNumberOfDays.tr()} ${widget.product.rentUnit == kDaily.tr()
                                          ? kDayss.tr()
                                          : widget.product.rentUnit == kWeekly.tr()
                                          ? kWeeks.tr()
                                          : widget.product.rentUnit == kMonthly.tr()
                                          ? kMonths.tr()
                                          : ''}",
                                      style: font15SomeBlackColorMedium
                                          .copyWith(
                                            fontSize: 13,
                                            color: kBlackColor,
                                          ),
                                    ),
                                    Text(
                                      totalDays > 0
                                          ? widget.product.rentUnit ==
                                                    kWeekly.tr()
                                                ? "$periodCount"
                                                : widget.product.rentUnit ==
                                                      kMonthly.tr()
                                                ? "$periodCount"
                                                : "$totalDays"
                                          : "--",
                                      style: font15SomeBlackColorMedium
                                          .copyWith(
                                            fontSize: 13,
                                            color: kBlackColor,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4.h,
                                    ),
                                    child: Divider(
                                      height: 1,
                                      color: kGreyColor,
                                      thickness: 1,
                                    ),
                                  ),

                                  buildPriceRow(
                                    Text(
                                      kTotal.tr(),
                                      style: font14BlackBold.copyWith(
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      totalDays > 0
                                          ? "$totalPrice ${kCurrency.tr()}"
                                          : "--",
                                      style: font14BlackBold.copyWith(
                                        fontSize: 13,
                                      ),
                                    ),
                                    isTotal: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(14.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                Gap(8.w),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: font15SomeBlackColorMedium
                                          .copyWith(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                      children: [
                                        TextSpan(
                                          text: "${kAgreeTermsPrefix.tr()} ",
                                        ),
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: GestureDetector(
                                            onTap: () async {
                                              final result =
                                                  await showModalBottomSheet<
                                                    bool
                                                  >(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    builder: (context) {
                                                      return const RentalTermsScreen();
                                                    },
                                                  );
                                              if (result == true) {
                                                setState(() {
                                                  agree = true;
                                                });
                                              }
                                            },
                                            child: Text(
                                              kRentalTerms.tr(),
                                              style: font14BlackBold.copyWith(
                                                color: kLightPrimaryColor,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: ButtonApp(
                    onPressed: (isValid && !isRequestSent)
                        ? () {
                            context.read<SendRequestBloc>().add(
                              SendRequestEvent(
                                rentalRequestEntity: SendRequestEntity(
                                  itemId: widget.product.id!,
                                  fromDate: DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(startDate!),
                                  toDate: DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(endDate!),
                                  agreeToTerms: agree,
                                ),
                              ),
                            );
                          }
                        : null,
                    text: isRequestSent ? kSent.tr() : kConfirmRequest.tr(),
                    color: kPrimaryColor,
                    borderRadius: Shared.width * 0.04.w,
                  ),
                ),
              ],
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
