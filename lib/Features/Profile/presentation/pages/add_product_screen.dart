import 'dart:io';

import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/dialogs.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/domain/entities/add_item_entity.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/bottom_nav_cubit.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/home_layout_screen.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/user_information.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/add_item_bloc.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/add_item_state.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/my_listings_bloc.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/product_data_container.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/rental_type_container.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/upload_product_images_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../Home/presentation/manager/all_items_bloc.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<String> categoryOptions = [
    kElectronics.tr(),
    kHomeAppliances.tr(),
    kBabyGear.tr(),
    kBooks.tr(),
    kTravelGear.tr(),
  ];
  List<String> governmentOptions = [
    'الإسكندرية',
    'الإسماعيلية',
    'الأقصر',
    'البحر الأحمر',
  ];
  List<String> productStatesOptions = [
    kBrandNew.tr(),
    kNew.tr(),
    kUsed.tr(),
    kHeavilyUsed.tr(),
  ];

  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController insuranceController = TextEditingController();

  bool isAvailable = true;
  bool acceptNegotiation = false;
  String rentalType = "يومي";
  String selectedCategory = "";
  String selectedCondition = "";
  String selectedCity = "";
  List<File> images = [];

  bool isFormValid = false;

  void validateForm() {
    setState(() {
      isFormValid =
          nameController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty &&
          priceController.text.isNotEmpty &&
          insuranceController.text.isNotEmpty &&
          selectedCategory.isNotEmpty &&
          selectedCondition.isNotEmpty &&
          selectedCity.isNotEmpty &&
          images.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(validateForm);
    descriptionController.addListener(validateForm);
    priceController.addListener(validateForm);
    insuranceController.addListener(validateForm);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: false,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            Navigator.pop(context);
            return false;
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, // 🔥 ده الحل
            ),
            child: UserInformation(),
          ),
        );
      },
      );
    });
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
          foregroundColor: kWhiteColor,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Shared.width * 0.04.w,
                      vertical: Shared.height * 0.025.h,
                    ),
                    child: BlocListener<AddItemBloc, AddItemState>(
                      bloc: addItemBloc,
                      listener: (context, state) {
                        if (state.status == addItemStatus.loading) {
                          Shared.showLoadingDialog(context: context);
                        } else if (state.status == addItemStatus.success) {
                          Shared.dismissDialog(context: context);

                          Dialogs.showDialogSuccess(
                            context,
                            title: "تم إضافة المنتج بنجاح.",
                            subTitle: "أصبح منتجك الآن متاحًا للإيجار.",
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              allItemsBloc.add(GetAllItemsEvent());
                              context.read<MyListingsBloc>().add(GetMyListingsEvent());
                            },
                            textButton: "عرض منتجاتي"
                          );
                        } else if (state.status == addItemStatus.failure) {
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
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UploadProductImagesContainer(
                              onImagesSelected: (files) {
                                images = files;
                                validateForm();
                              },
                            ),
                            Gap(50.h),
                            ProductDataContainer(
                              hintText: 'اسم المنتج',
                              keyboardType: TextInputType.name,
                              controller: nameController,
                            ),
                            Gap(20.h),
                            ProductDataContainer(
                              hintText: 'الفئة',
                              isOptions: true,
                              options: categoryOptions,
                              optionsLength: categoryOptions.length,
                              onItemSelected: (value) {
                                selectedCategory = value;
                                validateForm();
                              },
                            ),
                            Gap(20.h),
                            ProductDataContainer(
                              hintText: 'وصف المنتج...',
                              isDescription: true,
                              keyboardType: TextInputType.text,
                              controller: descriptionController,
                            ),
                            Gap(20.h),
                            ProductDataContainer(
                              hintText: 'حالة المنتج',
                              isOptions: true,
                              options: productStatesOptions,
                              optionsLength: productStatesOptions.length,
                              onItemSelected: (value) {
                                selectedCondition = value;
                                validateForm();
                              },
                            ),
                            Gap(30.h),
                            Text(
                              'نوع الإيجار',
                              style: font16BlackSemiBold.copyWith(
                                color: kSomeBlackColor,
                              ),
                            ),
                            Gap(10.h),
                            RentalTypeContainer(
                              onChanged: (value) {
                                setState(() {
                                  rentalType = value;
                                });
                                validateForm();
                              },
                            ),
                            Gap(20.h),
                            ProductDataContainer(
                              hintText:
                                  'سعر الإيجار (جنيه/${rentalType.substring(0, rentalType.length - 1)})',
                              keyboardType: TextInputType.number,
                              controller: priceController,
                            ),
                            Gap(20.h),
                            ProductDataContainer(
                              hintText: 'قيمة التأمين',
                              keyboardType: TextInputType.number,
                              controller: insuranceController,
                            ),
                            Gap(20.h),
                            ProductDataContainer(
                              hintText: 'المحافظة',
                              isOptions: true,
                              options: governmentOptions,
                              optionsLength: governmentOptions.length,
                              onItemSelected: (value) {
                                selectedCity = value;
                                validateForm();
                              },
                            ),
                            Gap(30.h),
                            buildSwitchRow(
                              title: "المنتج متاح حالياً",
                              value: isAvailable,
                              onChanged: (val) {
                                setState(() {
                                  isAvailable = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
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
                  onPressed: isFormValid
                      ? () {
                          if (formKey.currentState!.validate()) {
                            addItemBloc.add(
                              AddItemEvent(
                                addItemEntity: AddItemEntity(
                                  name: nameController.text,
                                  description: descriptionController.text,
                                  price: priceController.text,
                                  insurance: insuranceController.text,
                                  isAvailable: isAvailable,
                                  rentUnit: rentalType,
                                  condition: selectedCondition,
                                  categoryName: selectedCategory,
                                  city: selectedCity,
                                  images: images,
                                ),
                              ),
                            );
                          }
                        }
                      : null,
                  text: 'إضافة المنتج',
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSwitchRow({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: kLightPrimaryColor,
          activeColor: kWhiteColor,
          inactiveTrackColor: kInactiveSwitchColor.withOpacity(0.3),
          inactiveThumbColor: kWhiteColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          trackOutlineWidth: MaterialStateProperty.all(0),
          trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((
            states,
          ) {
            if (states.contains(MaterialState.selected)) {
              return kLightPrimaryColor;
            }
            return kInactiveSwitchColor.withOpacity(0);
          }),
        ),
        Gap(8.w),
        Text(title, style: font15BlackRegular.copyWith(fontWeight: semiBold)),
      ],
    );
  }
}
