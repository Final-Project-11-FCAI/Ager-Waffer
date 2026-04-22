import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Shimmer/loading_shimmer.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/all_items_bloc.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/all_items_state.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/custom_search_text_field.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/product_card_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';

  @override
  void initState() {
    super.initState();
    context.read<AllItemsBloc>().add(GetAllItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: isDark ? kDarkModeColor : kWhiteColor,
        body: CustomScrollView(
      slivers: [
      SliverAppBar(
      pinned: true,
        backgroundColor: isDark ? kDarkModeColor : kWhiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 80.h,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Shared.width * 0.04.w,
              vertical: Shared.height * 0.01.h,
            ),
            child: CustomSearchTextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),
        ),
      ),
      BlocBuilder<AllItemsBloc, AllItemsState>(
        builder: (context, state) {
          if (state.status == allItemsStatus.loading) {
            return SliverToBoxAdapter(
              child: LoadingPlaceHolder(
                shimmerType: ShimmerType.list,
                cellShimmerHeight: 50,
                shimmerCount: 10,
              ),
            );
          }

          final products = state.product;

          final results = products.where((product) {
            return product.name!
                .toLowerCase()
                .contains(query.toLowerCase());
          }).toList();

          if (query.isEmpty) {
            return SliverToBoxAdapter(child: SizedBox());
          }

          if (results.isEmpty) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: Shared.height * 0.02.h),
                child: Center(child: Text("No results found",style: font14BlackBold.copyWith(fontSize: 16),)),
              ),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: Shared.width * 0.04.w,
                    right: Shared.width * 0.04.w,
                  ),
                  child: ProductCardListView(
                    product: results[index],
                  ),
                );
              },
              childCount: results.length,
            ),
          );
        },
      ),
      ],
    ),
      ),
    );;
  }
}
