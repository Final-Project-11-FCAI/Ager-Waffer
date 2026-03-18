import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Manage_Orders/presentation/widgets/current_manage_orders.dart';
import 'package:ager_waffer/Features/Manage_Orders/presentation/widgets/incoming_orders.dart';
import 'package:ager_waffer/Features/Manage_Orders/presentation/widgets/previous_orders.dart';
import 'package:ager_waffer/Features/Orders/presentation/widgets/finished_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManageOrdersScreen extends StatefulWidget {
  const ManageOrdersScreen({super.key});

  @override
  State<ManageOrdersScreen> createState() => _ManageOrdersScreenState();
}

class _ManageOrdersScreenState extends State<ManageOrdersScreen> {
  int selectedIndex = 0;

  final List<String> tabs = [
    "الواردة",
    "الجارية",
    "السابقة",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          foregroundColor: kWhiteColor,
          title: Text(
            'إدارة الطلبات',
            style: font16BlackSemiBold.copyWith(
              fontSize: 20,
              color: kWhiteColor,
            ),
          )
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
            Row(
              children: List.generate(
                tabs.length,
                    (index) => Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            tabs[index],
                            style: font16BlackSemiBold.copyWith(
                              color: selectedIndex == index
                                  ? kLightPrimaryColor
                                  : kBlackColor.withOpacity(0.68),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Divider(height: 1,thickness: 0.5,color: kBlackColor.withOpacity(0.19),),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                height: 3,
                                color: selectedIndex == index
                                    ? kLightPrimaryColor
                                    : Colors.transparent,
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
            selectedIndex == 0 ? Expanded(child: IncomingOrders())
                : selectedIndex == 1 ? Expanded(child: CurrentManageOrders())
                : selectedIndex == 2 ? Expanded(child: PreviousOrders()) : Container(),
          ],
        ),
      ),
    );
  }
}
