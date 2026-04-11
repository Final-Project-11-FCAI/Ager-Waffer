import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Shimmer/loading_shimmer.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/data/models/login_model.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/login_bloc.dart';
import 'package:ager_waffer/Features/Home/domain/entities/category_entity.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/all_items_bloc.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/all_items_state.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/category_pages/baby_items_screen.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/category_pages/books_screen.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/category_pages/electronics_screen.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/category_pages/home_essentials_screen.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/category_pages/travel_essentials_screen.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/carousel_slider_container.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/category_item_list_view.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/custom_home_app_bar.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/drawer_details.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/product_card_list_view.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/custom_error_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.email, required this.password});

  final String email;
  final String password;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AllItemsBloc>().add(GetAllItemsEvent());
  }

  Future<void> _refreshData() async {
    context.read<AllItemsBloc>().add(GetAllItemsEvent());

    context.read<LoginBloc>().add(
      LoginEvent(email: widget.email, password: widget.password),
    );
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final List<CategoryEntity> categories = [
      CategoryEntity(
        image: 'assets/images/electronics.png',
        title: kElectronics.tr(),
        onTap: () {
          final products = allItemsBloc.state.product;
          customAnimatedPushNavigation(
            context,
            ElectronicsScreen(products: products),
          );
        },
      ),
      CategoryEntity(
        image: 'assets/images/home_supplies.png',
        title: kHomeAppliances.tr(),
        onTap: () {
          customAnimatedPushNavigation(context, HomeEssentialsScreen());
        },
      ),
      CategoryEntity(
        image: 'assets/images/travel_supplies.png',
        title: kTravelGear.tr(),
        onTap: () {
          customAnimatedPushNavigation(context, TravelEssentialsScreen());
        },
      ),
      CategoryEntity(
        image: 'assets/images/books.png',
        title: kBooks.tr(),
        onTap: () {
          customAnimatedPushNavigation(context, BooksScreen());
        },
      ),
      CategoryEntity(
        image: 'assets/images/children_items.png',
        title: kBabyGear.tr(),
        onTap: () {
          customAnimatedPushNavigation(context, BabyItemsScreen());
        },
      ),
    ];
    return GestureDetector(
      onTap: () {
        Data user = context.read<LoginBloc>().state.user;
        print("user : ${user.toJson()}");
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(width: Shared.width * 0.8, child: DrawerDetails()),
          backgroundColor: kWhiteColor,
          appBar: CustomHomeAppBar(),
          body: RefreshIndicator(
            color: kPrimaryColor,
            backgroundColor: Colors.white,
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Shared.height * 0.25.h,
                      child: CarouselSliderContainer(),
                    ),
                    Gap(14.h),
                    Text(kCategories.tr(), style: font14BlackBold),
                    Gap(10.h),
                    SizedBox(
                      height: Shared.height * 0.2.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: categories[index].onTap,
                            child: CategoryItemListView(
                              category: categories[index],
                            ),
                          );
                        },
                      ),
                    ),
                    Gap(18.h),
                    Text(kSuggestedItems.tr(), style: font14BlackBold),
                    Gap(8.h),
                    BlocBuilder<AllItemsBloc, AllItemsState>(
                      builder: (context, state) {
                        if (state.status == allItemsStatus.loading) {
                          return const LoadingPlaceHolder(
                            shimmerType: ShimmerType.list,
                            cellShimmerHeight: 50,
                            shimmerCount: 10,
                          );
                        } else if (state.status == allItemsStatus.success) {
                          final products = state.product;

                          return FutureBuilder<Data?>(
                            future: sharedPreferenceManager.getUser(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return SizedBox();
                              }

                              final user = snapshot.data;

                              final filteredProducts = products.where((product) {
                                final ownerId = product.ownerId?.toString().trim();
                                final userId = user?.id?.toString().trim();
                                return ownerId != userId;
                              }).toList();

                              return ListView.builder(
                                itemCount: filteredProducts.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ProductCardListView(
                                    product: filteredProducts[index],
                                  );
                                },
                              );
                            }
                          );
                        } else if (state.status == allItemsStatus.failure) {
                          return LayoutBuilder(
                            builder: (context, constraints) {
                              return SizedBox(
                                width: double.infinity,
                                height: Shared.height * 0.3,
                                child: Center(
                                  child: CustomErrorWidget(
                                    message: state.failureMessage,
                                    onRetry: () {
                                      context.read<AllItemsBloc>().add(
                                        GetAllItemsEvent(),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(child: Text(kNoDataYet.tr()));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
