import 'dart:io';

import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/domain/entities/add_item_entity.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Profile/data/models/my_listings_model.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/my_listings_bloc.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/update_item_bloc.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/update_item_state.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/update_product_data_container.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/update_rental_type_container.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/update_upload_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});
  final MyListingsData product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
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
  String rentalType = kDaily.tr();
  String selectedCategory = "";
  String selectedCondition = "";
  String selectedCity = "";
  List<File> images = [];

  bool isFormValid = false;

  /// Snapshot of loaded product — button stays off until current state differs.
  late String _initialName;
  late String _initialDescription;
  late String _initialPriceText;
  late String _initialInsuranceText;
  late String _initialCategory;
  late String _initialCondition;
  late String _initialCity;
  late String _initialRentalType;
  late bool _initialIsAvailable;

  bool _hasChangesFromInitial() {
    if (nameController.text.trim() != _initialName) return true;
    if (descriptionController.text.trim() != _initialDescription) return true;
    if (priceController.text.trim() != _initialPriceText) return true;
    if (insuranceController.text.trim() != _initialInsuranceText) return true;
    if (selectedCategory != _initialCategory) return true;
    if (selectedCondition != _initialCondition) return true;
    if (selectedCity != _initialCity) return true;
    if (rentalType != _initialRentalType) return true;
    if (isAvailable != _initialIsAvailable) return true;
    if (images.isNotEmpty) return true;
    return false;
  }

  void validateForm() {
    setState(() {
      final baseValid =
          nameController.text.isNotEmpty &&
              descriptionController.text.isNotEmpty &&
              priceController.text.isNotEmpty &&
              insuranceController.text.isNotEmpty &&
              selectedCategory.isNotEmpty &&
              selectedCondition.isNotEmpty &&
              selectedCity.isNotEmpty &&
              (images.isNotEmpty || widget.product.itemImages?.isNotEmpty == true);
      isFormValid = baseValid && _hasChangesFromInitial();
    });
  }

  @override
  void initState() {
    super.initState();

    final product = widget.product;

    nameController.text = product.name ?? '';
    descriptionController.text = product.description ?? '';
    priceController.text = product.price?.toString() ?? '';
    insuranceController.text = product.insurance?.toString() ?? '';

    selectedCategory = product.categoryName ?? '';
    selectedCondition = product.condition ?? '';
    selectedCity = product.city ?? '';

    isAvailable = product.isAvailable ?? true;
    rentalType = mapRentUnit(product.rentUnit);

    if (product.itemImages != null && product.itemImages!.isNotEmpty) {
    }

    _initialName = nameController.text.trim();
    _initialDescription = descriptionController.text.trim();
    _initialPriceText = priceController.text.trim();
    _initialInsuranceText = insuranceController.text.trim();
    _initialCategory = selectedCategory;
    _initialCondition = selectedCondition;
    _initialCity = selectedCity;
    _initialRentalType = rentalType;
    _initialIsAvailable = isAvailable;

    nameController.addListener(validateForm);
    descriptionController.addListener(validateForm);
    priceController.addListener(validateForm);
    insuranceController.addListener(validateForm);

    validateForm();
  }

  @override
  void dispose() {
    nameController.removeListener(validateForm);
    descriptionController.removeListener(validateForm);
    priceController.removeListener(validateForm);
    insuranceController.removeListener(validateForm);
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    insuranceController.dispose();
    super.dispose();
  }

  String mapRentUnit(String? value) {
    if (value == null) return kDaily.tr();

    if (value.contains("يوم") || value.toLowerCase().contains("day")) {
      return "يومي";
    } else if (value.contains("أسبوع") || value.toLowerCase().contains("week")) {
      return "أسبوعي";
    } else if (value.contains("شهر") || value.toLowerCase().contains("month")) {
      return "شهري";
    }

    return kDaily.tr();
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
        body: BlocListener<UpdateItemBloc, UpdateItemState>(
            listener: (context, state) {
              if (state.status == updateItemStatus.loading) {
                Shared.showLoadingDialog(context: context);
              } else if (state.status == updateItemStatus.success) {
                Shared.dismissDialog(context: context);
                context.read<MyListingsBloc>().add(GetMyListingsEvent());
                Navigator.of(context).pop();
              } else if (state.status == updateItemStatus.failure) {
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
          child: Container(
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
                      child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UpdateUploadImages(
                                initialImage: widget.product.itemImages?.isNotEmpty == true
                                    ? widget.product.itemImages!.first
                                    : null,
                                onImagesSelected: (files) {
                                  images = files;
                                  validateForm();
                                },
                              ),
                              Gap(50.h),
                              UpdateProductDataContainer(
                                hintText: 'اسم المنتج',
                                keyboardType: TextInputType.name,
                                controller: nameController,
                              ),
                              Gap(20.h),
                              UpdateProductDataContainer(
                                hintText: 'الفئة',
                                isOptions: true,
                                options: categoryOptions,
                                initialValue: selectedCategory,
                                optionsLength: categoryOptions.length,
                                onItemSelected: (value) {
                                  selectedCategory = value;
                                  validateForm();
                                },
                              ),
                              Gap(20.h),
                              UpdateProductDataContainer(
                                hintText: 'وصف المنتج...',
                                isDescription: true,
                                keyboardType: TextInputType.text,
                                controller: descriptionController,
                              ),
                              Gap(20.h),
                              UpdateProductDataContainer(
                                hintText: 'حالة المنتج',
                                isOptions: true,
                                options: productStatesOptions,
                                initialValue: selectedCondition,
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
                              UpdateRentalTypeContainer(
                                initialValue: rentalType,
                                onChanged: (value) {
                                  setState(() {
                                    rentalType = value;
                                  });
                                  validateForm();
                                },
                              ),
                              Gap(20.h),
                              UpdateProductDataContainer(
                                hintText:
                                'سعر الإيجار (جنيه/${rentalType.substring(0, rentalType.length - 1)})',
                                keyboardType: TextInputType.number,
                                controller: priceController,
                              ),
                              Gap(20.h),
                              UpdateProductDataContainer(
                                hintText: 'قيمة التأمين',
                                keyboardType: TextInputType.number,
                                controller: insuranceController,
                              ),
                              Gap(20.h),
                              UpdateProductDataContainer(
                                hintText: 'المحافظة',
                                isOptions: true,
                                options: governmentOptions,
                                initialValue: selectedCity,
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
                                  validateForm();
                                },
                              ),
                              // Gap(20.h),
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
                        context.read<UpdateItemBloc>().add(
                          UpdateItemEvent(
                              productId: widget.product.id!,
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
                                images: images.isNotEmpty ? images : null,
                              )
                          )
                        );
                      }
                    }
                        : null,
                    text: 'تعديل المنتج',
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
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
