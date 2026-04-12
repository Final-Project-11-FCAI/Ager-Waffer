import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../Base/common/theme.dart';
import '../../domain/entities/current_orders_entity.dart';
import 'build_date_card.dart';
import 'build_order_action_buttons.dart';
import 'build_price_summary_card.dart';
import 'build_product_card.dart';
import 'build_renter_info_card.dart';

class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({super.key});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor, // kPrimaryColor
          elevation: 0,
          title: Text(
            "تفاصيل الطلب",
            style: font14BlackBold.copyWith(color: kWhiteColor),
          ),
          centerTitle: true,
        ),
        body: Container(
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      BuildProductCard(),
                      const SizedBox(height: 15),
                      BuildDateCard(),
                      const SizedBox(height: 15),
                      BuildRenterInfoCard(),
                      const SizedBox(height: 15),
                      BuildPriceSummaryCard(),
                    ],
                  ),
                ),
              ),
              BuildOrderActionsButtons(),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: const Color.fromARGB(255, 240, 240, 240),
      borderRadius: BorderRadius.circular(20),
    );
  }
}

