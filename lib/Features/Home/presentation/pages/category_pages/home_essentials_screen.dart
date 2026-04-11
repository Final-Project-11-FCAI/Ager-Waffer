import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Shimmer/loading_shimmer.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/all_items_bloc.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/all_items_state.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/product_card_list_view.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/custom_error_widget.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/empty_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class HomeEssentialsScreen extends StatefulWidget {
  const HomeEssentialsScreen({super.key});

  @override
  State<HomeEssentialsScreen> createState() => _HomeEssentialsScreenState();
}

class _HomeEssentialsScreenState extends State<HomeEssentialsScreen> {

  @override
  void initState() {
    super.initState();
    allItemsBloc.add(GetAllItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        foregroundColor: kWhiteColor,
        title: Text(
          "مستلزمات المنزل",
          style: font16BlackSemiBold.copyWith(fontSize: 20, color: kWhiteColor),
        ),
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Shared.width * 0.04.w,
            vertical: Shared.height * 0.025.h,
          ),
          child: BlocBuilder<AllItemsBloc, AllItemsState>(
            bloc: allItemsBloc,
            builder: (context, state) {
              if (state.status == allItemsStatus.loading) {
                return const LoadingPlaceHolder(
                  shimmerType: ShimmerType.list,
                  cellShimmerHeight: 50,
                  shimmerCount: 10,
                );
              } else if (state.status == allItemsStatus.success) {
                final products = state.product;
                final homeAppliances = products.where((e) => e.categoryName == kHomeAppliances.tr()).toList();

                if (homeAppliances.isEmpty) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Center(
                            child: EmptyProducts(
                              image: 'assets/images/no_products.png',
                              title: 'لا توجد عناصر متاحة',
                              subTitle: 'لم يتم العثور على منتجات ضمن هذه الفئة حالياً',
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return ListView.builder(
                  itemCount: homeAppliances.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ProductCardListView(product: homeAppliances[index]);
                  },
                );
              } else if (state.status == allItemsStatus.failure) {
                return CustomErrorWidget(
                  message: state.failureMessage,
                  onRetry: () {
                    context.read<AllItemsBloc>().add(
                      GetAllItemsEvent(),
                    );
                  },
                );
              } else {
                return Center(child: Text("No Data Yet"));
              }
            },
          ),
        ),
      ),
    );
  }
}
