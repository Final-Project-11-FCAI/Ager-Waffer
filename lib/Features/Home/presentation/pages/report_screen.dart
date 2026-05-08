import 'dart:io';

import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:ager_waffer/Features/Home/domain/entities/add_report_entity.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/add_report_bloc.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/add_report_state.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../Profile/presentation/widgets/product_data_container.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key, required this.product});

  final ProductData product;

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  List<String> reportReasons = [
    kReportHarassment,
    kReportInappropriateContent,
    kReportSpam,
    kReportFakeAccount,
    kReportScam,
    kReportOther,
  ];

  String selectedReason = "";
  File? selectedImage;
  bool isReportSent = false;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  bool get isFormValid {
    return selectedReason.isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        selectedImage != null;
  }
  @override
  void initState() {
    super.initState();

    descriptionController.addListener(() {
      setState(() {});
    });
  }
  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? kDarkModeColor : kWhiteColor,
      appBar: AppBar(
        backgroundColor: isDark ? kSomeDarkModeColor : kPrimaryColor,
        foregroundColor: kWhiteColor,
        title: Text(kSubmitReport.tr()),
        centerTitle: true,
      ),
      body: BlocListener<AddReportBloc, AddReportState>(
        listener: (context, state) {
          if (state.status == addReportStatus.loading) {
            Shared.showLoadingDialog(context: context);
          } else if (state.status == addReportStatus.success) {
            Shared.dismissDialog(context: context);
            setState(() {
              isReportSent = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: kGreenColor,
                content: Text(
                    kReportSentSuccessfully.tr()
              ),)
            );
          } else if (state.status == addReportStatus.failure) {
            Shared.dismissDialog(context: context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.failureMessage ??
                      kSomethingWentWrong.tr(),
                ),
              ),
            );
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Shared.width * 0.04.w,
                    vertical: Shared.height * 0.02.h,),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                        kReportUser.tr(),
                          style: font24PrimarySemiBold.copyWith(
                            color: isDark ? kWhiteColor : kBlackColor,
                          ),
                        ),
                        Gap(15.h),
                        Text(
                          kReportedUser.tr(),
                          style: font16BlackSemiBold.copyWith(
                            color: isDark ? kWhiteColor : kBlackColor,
                          ),
                        ),
                        Gap(8.h),
                        Container(
                          width: double.infinity,
                          height: Shared.height * 0.08.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.r),
                            color: isDark
                                ? kLightDarkModeColor
                                : kProductDataContainerColor,
                            border: Border.all(color: kBorderColor, width: 1.w),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Shared.width * 0.04.w,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.product.ownerName!,
                                  style: font16BlackSemiBold.copyWith(
                                    color: isDark ? kWhiteColor : kBlackColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(20.h),
                        Text(
                          kWhyReportingUser.tr(),
                          style: font16BlackSemiBold.copyWith(
                            color: isDark ? kWhiteColor : kBlackColor,
                          ),
                        ),
                        Gap(8.h),
                        ProductDataContainer(
                          hintText: kSelectReason.tr(),
                          isOptions: true,
                          options: reportReasons,
                          optionsLength: reportReasons.length,
                            onItemSelected: (value) {
                              setState(() {
                                selectedReason = value.tr();
                              });
                            },
                        ),
                        Gap(20.h),
                        Row(
                          children: [
                            Text(
                              kReportDetails.tr(),
                              style: font16BlackSemiBold.copyWith(
                                color: isDark ? kWhiteColor : kBlackColor,
                              ),
                            ),
                            Text(
                              " (${kRequire.tr()})",
                              style: font16BlackSemiBold.copyWith(
                                color: isDark ? kWhiteColor : kBlackColor,
                                fontWeight: regular,
                              ),
                            ),
                          ],
                        ),
                        Gap(8.h),
                        ProductDataContainer(
                          hintText: kReportDescription.tr(),
                          isDescription: true,
                          keyboardType: TextInputType.text,
                          controller: descriptionController,
                        ),
                        Gap(20.h),
                        GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            width: double.infinity,
                            height: Shared.height * 0.07.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.r),
                              color: isDark
                                  ? kLightDarkModeColor
                                  : kProductDataContainerColor,
                              border: Border.all(color: kBorderColor, width: 1.w),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Shared.width * 0.04.w,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.attachment,
                                    color: isDark ? kWhiteColor : kBlackColor,
                                    size: 22,
                                  ),
                                  Text(
                                    " ${kAttachImage.tr()}",
                                    style: font16BlackSemiBold.copyWith(
                                      color: isDark ? kWhiteColor : kBlackColor,
                                      fontWeight: medium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Gap(20.h),
                        if (selectedImage != null)
                          Stack(
                            children: [
                              Container(
                                width: Shared.width * 0.3.w,
                                height: Shared.height * 0.13.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.file(
                                      selectedImage!, fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedImage = null;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: kGreyColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
              decoration: BoxDecoration(
                color: isDark ? kDarkModeColor : kWhiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: ButtonApp(
                onPressed:  (isFormValid && !isReportSent)
                    ? () {
                  if (!isFormValid) return;
                  if(formKey.currentState!.validate()) {
                    context.read<AddReportBloc>().add(
                      AddReportEvent(
                        addReportEntity: AddReportEntity(
                          reportedUserId: widget.product.ownerId!,
                          type: selectedReason,
                          description: descriptionController.text,
                          attachment: selectedImage!,
                        ),
                    )
                    );
                  }
                }
                    : null,
                text: isReportSent ? kSent.tr() : kSubmitReport.tr(),
                color: isDark && !(isFormValid && !isReportSent) ? kGreyColor.withOpacity(0.5) :
                isDark && (isFormValid && !isReportSent) ?
                kButtonColor : !isDark && !(isFormValid && !isReportSent) ? kGreyColor.withOpacity(0.35) : kPrimaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
