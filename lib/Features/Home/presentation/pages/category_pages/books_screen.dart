import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Shimmer/loading_shimmer.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/all_items_bloc.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/all_items_state.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/product_card_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key,});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {

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
          title: Text("كتب",
            style: font16BlackSemiBold.copyWith(
              fontSize: 20,
              color: kWhiteColor,
            ),
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
                    final books = products.where((e) => e.categoryName == "Books").toList();

                    if (books.isEmpty) {
                      return Center(
                        child: Text(
                          "No Data Found",
                          style: font16BlackSemiBold.copyWith(color: kBlackColor),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: books.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ProductCardListView(product: books[index]);
                      },
                    );
                  }
                  else if (state.status == allItemsStatus.failure) {
                    return Center(child: Text(state.failureMessage));
                  } else {
                    return Center(child: Text("No Data Yet"));
                  }
                },
              ),
            )
        )
    );
  }
}