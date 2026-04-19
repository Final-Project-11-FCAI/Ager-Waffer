import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Manage_Orders/data/models/orders_management_model.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Orders/data/models/my_orders_model.dart';
import 'package:ager_waffer/Features/Orders/presentation/manager/add_review_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class RenterRatingBottomSheet extends StatefulWidget {
  const RenterRatingBottomSheet({
    super.key,
    required this.reviewType,
    required this.hint,
    required this.previousOrders,
    required this.index,
  });

  final String reviewType;
  final String hint;
  final List<OrderManagementData> previousOrders;
  final int index;

  @override
  State<RenterRatingBottomSheet> createState() => _RenterRatingBottomSheetState();
}

class _RenterRatingBottomSheetState extends State<RenterRatingBottomSheet> {
  double rating = 0;
  TextEditingController commentController = TextEditingController();

  bool get isButtonEnabled {
    return rating > 0;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: Shared.width * 0.04.w,
              right: Shared.width * 0.04.w,
              top: Shared.height * 0.02.h,
              bottom: Shared.height * 0.02.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Gap(20.h),
                Text(
                    kHowWasExperience.tr(),
                  style: font20PrimaryMedium.copyWith(fontWeight: bold),
                ),
                Gap(5.h),
                Text(
                  kYourOpinionMatters.tr(),
                  style: font20PrimaryMedium.copyWith(
                    color: kLightPrimaryColor,
                    fontSize: 15,
                  ),
                ),
                Gap(15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: kPrimaryColor),
                        Gap(5.w),
                        Text(
                          "${kRate.tr()} ${widget.reviewType}",
                          style: font20PrimaryMedium.copyWith(
                            fontWeight: bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
                      itemBuilder: (context, _) =>
                          const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                    ),
                  ],
                ),
          
                Gap(15),
                TextField(
                  controller: commentController,
                  maxLines: 3,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    hintText:"${kCommentHint.tr()} ${widget.hint} (${kOptional.tr()})",
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Gap(20.h),
          
                SizedBox(
                  width: double.infinity,
                  child: ButtonApp(
                    onPressed: isButtonEnabled ?
                        () {
                      context.read<AddReviewBloc>().add(
                        AddReviewEvent(
                          reviewType: 3,
                          itemId: widget.previousOrders[widget.index].itemId!,
                          reviewedUserId: widget.previousOrders[widget.index].renteeId,
                          reviewText: commentController.text,
                          rate: rating.toInt(),
                        ),
                      );
                    } : null,
                    text: kSubmitReview.tr(),
                    color: kPrimaryColor,
                    isReview: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
