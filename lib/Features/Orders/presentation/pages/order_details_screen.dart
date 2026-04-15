import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Orders/data/models/my_orders_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


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
            "تفاصيل الطلب",
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
                  child: Column(
                    children: [
                      _buildProductCard(),
                      _buildDateSection(),
                      _buildPriceSection(),
                      _buildUserSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // 🔹 PRODUCT CARD
  Widget _buildProductCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Image.network(
            currentOrders.itemImages!.first,
            width: 90.w,
            height: 90.w,
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentOrders.itemName!,
                  textAlign: TextAlign.right,
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

  // 🔹 DATE SECTION
  Widget _buildDateSection() {
    return _sectionContainer(
      title: "فترة الإيجار",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: _dateBox("تاريخ البداية", currentOrders.fromDate!)),
          Gap(10.w),
          Expanded(child: _dateBox("تاريخ النهاية", currentOrders.toDate!)),
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
      title: "ملخص السعر",
      child: Column(
        children: [
          _PriceRow("سعر الإيجار/اليوم", "${currentOrders.price} جنيه"),
          _PriceRow("التأمين", "${currentOrders.insurance} جنيه"),
          Divider(),
          _PriceRow("الإجمالي", "${currentOrders.totalPrice} جنيه", isTotal: true),
        ],
      ),
    );
  }

  Widget _buildUserSection() {
    return _sectionContainer(
      title: "بيانات المستأجر",
      child: Column(
        children: [
          _InfoRow(Icons.person, "الاسم", currentOrders.ownerName!),
          _InfoRow(Icons.location_on, "العنوان", "${currentOrders.city} ${currentOrders.governorate} ${currentOrders.street}"),
          _InfoRow(Icons.phone, "رقم الهاتف", currentOrders.phoneNumber!),
          _InfoRow(Icons.email, "البريد الإلكتروني", currentOrders.email!),
        ],
      ),
    );
  }

  Widget _sectionContainer({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
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
          blurRadius: 10,
        )
      ],
    );
  }

  BoxDecoration _innerBoxDecoration() {
    return BoxDecoration(
      color: kWhiteColor,
      borderRadius: BorderRadius.circular(12),
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
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? kPrimaryColor : kBlackColor,
            ),
          ),
          Text(title),
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
          Icon(icon, color: kPrimaryColor),
          Gap(8.w),
          Text("$title :",style: font15SomeBlackColorMedium.copyWith(color: kPrimaryColor),),
          Gap(8.w),
          Expanded(
            child: Text(value, style: font15SomeBlackColorMedium.copyWith(color: kBlackColor),),
          ),
        ],
      ),
    );
  }
}