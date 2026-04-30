import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Orders/data/models/my_orders_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.currentOrders});

  final OrderData currentOrders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          foregroundColor: kWhiteColor,
          title: Text(
            kOrderDetails.tr(),
            style: font16BlackSemiBold.copyWith(
              fontSize: 20,
              color: kWhiteColor,
            ),
          )
      ),
      body: SafeArea(
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
                    padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.04.w,vertical: Shared.height * 0.02.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProductCard(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.12.w, vertical: Shared.height * 0.02.h),
                          child: Divider(height: 1,color: kBlackColor,),
                        ),
                        Text(kRentalPeriod.tr(), style: font16BlackSemiBold,),
                        Gap(8.h),
                        _buildDateSection(),
                        Gap(15.h),
                        Text(kPriceSummary.tr(), style: font16BlackSemiBold,),
                        Gap(8.h),
                        _buildPriceSection(),
                        Gap(15.h),
                        Text(kRenterData.tr(), style: font16BlackSemiBold,),
                        Gap(8.h),
                        _buildUserSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildProductCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.04.w),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: currentOrders.itemImages!.first,
            width: 90.w,
            height: 90.h,
            fit: BoxFit.contain,
            placeholder: (context, url) => Image.asset(
              "assets/images/virtual_image.jpg",
              fit: BoxFit.contain,
            ),
            errorWidget: (context, url, error) {
              return Image.asset("assets/images/virtual_image.jpg");
            },
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentOrders.itemName!,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: font16BlackSemiBold,
                ),
                Gap(5.h),
                Text(currentOrders.itemCondition!, style: font16BlackSemiBold.copyWith(
                  color: kBlueColor,
                ),),
                Gap(5.h),
                Row(
                  children: [

                    ...List.generate(
                      5,
                          (index) => Icon(
                        Icons.star,
                        size: 14.sp,
                        color: index < (double.tryParse(currentOrders.avrageRate ?? '0')?.floor() ?? 0)
                            ? Colors.amber
                            : Colors.grey.shade300,
                      ),
                    ),
                    Gap(5.w),
                    Text(
                      currentOrders.avrageRate.toString(),
                      style: font16BlackSemiBold.copyWith(
                        fontSize: 10,
                        color: const Color.fromRGBO(151, 151, 151, 1),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDateSection() {
    return _sectionContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: _dateBox(kStartDate.tr(), currentOrders.fromDate!)),
          Gap(10.w),
          Expanded(child: _dateBox(kEndDate.tr(), currentOrders.toDate!)),
        ],
      ),
    );
  }

  Widget _dateBox(String title, String date) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _innerBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: font14GreyRegular.copyWith(fontWeight: medium,fontSize: 15),),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(date),
              const SizedBox(width: 5),
              Image.asset('assets/images/date_determine.png', width: 16.w,),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection() {
    return _sectionContainer(
      child: Column(
        children: [
          _PriceRow(kPricePerDay.tr(), "${currentOrders.price} ${kCurrency.tr()}"),
          _PriceRow(kInsurance.tr(), "${currentOrders.insurance} ${kCurrency.tr()}"),
          Divider(),
          _PriceRow(kTotal.tr(), "${currentOrders.totalPrice} ${kCurrency.tr()}", isTotal: true)
        ],
      ),
    );
  }

  Widget _buildUserSection() {
    return _sectionContainer(
      child: Column(
        children: [
          _InfoRow(Icons.person, kName.tr(), currentOrders.ownerName!),
          _InfoRow(Icons.location_on, kAddress.tr(),
              "${currentOrders.city} ${currentOrders.governorate} ${currentOrders.street}"),
          _InfoRow(Icons.phone, kPhone.tr(), currentOrders.phoneNumber!),
          _InfoRow(Icons.email, kEmail.tr(), currentOrders.email!)
        ],
      ),
    );
  }

  Widget _sectionContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child,
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: kProductDataContainerColor.withOpacity(0.3),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 4,
        )
      ],
    );
  }

  BoxDecoration _innerBoxDecoration() {
    return BoxDecoration(
      color: kWhiteColor,
      borderRadius: BorderRadius.circular(12.r),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;

  const _PriceRow(this.title, this.value, {this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
            style: font13kLightPrimaryColorMedium.copyWith(color: kBlackColor,
              fontWeight: isTotal ? bold : medium,),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isTotal ? bold : medium,
              color: isTotal ? kPrimaryColor : kBlackColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow(this.icon, this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: kLightPrimaryColor),
          Gap(8.w),
          Text("$title :",style: font15SomeBlackColorMedium.copyWith(color: kLightPrimaryColor),),
          Gap(8.w),
          Expanded(
            child: Text(value, style: font15SomeBlackColorMedium.copyWith(color: kBlackColor),),
          ),
        ],
      ),
    );
  }
}