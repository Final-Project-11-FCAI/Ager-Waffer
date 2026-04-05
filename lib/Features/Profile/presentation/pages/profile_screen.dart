import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Shimmer/loading_shimmer.dart';
import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/data/models/login_model.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/delete_item_bloc.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/delete_item_state.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/my_listings_bloc.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/my_listings_state.dart';
import 'package:ager_waffer/Features/Profile/presentation/pages/add_product_screen.dart';
import 'package:ager_waffer/Features/Profile/presentation/pages/edit_profile_screen.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/custom_error_widget.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/empty_products.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/my_products_item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Data? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
    context.read<MyListingsBloc>().add(GetMyListingsEvent());
  }

  Future<void> _loadUser() async {
    final user = await sharedPreferenceManager.getUser();
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Center(child: CircularProgressIndicator());
    }

    final user = _user!;

    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        floatingActionButton: CircleAvatar(
          radius: 25.r,
          child: FloatingActionButton(
            tooltip: 'إضافة منتج',
            onPressed: () {
              customAnimatedPushNavigation(context, AddProductScreen());
            },
            elevation: 3.sp,
            backgroundColor: kPrimaryColor,
            child: Icon(Icons.add, color: kWhiteColor),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: Shared.height * 0.22.h),
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
                child: Padding(
                  padding: EdgeInsets.only(top: Shared.height * 0.07.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Shared.width * 0.04.w,
                    ),
                    child: Column(
                      children: [
                        Gap(2.h),
                        Text(
                          user.fullName.toString(),
                          style: font24PrimarySemiBold.copyWith(
                            color: kBlackColor,
                          ),
                        ),
                        Text(
                          user.email.toString(),
                          style: font16BlackSemiBold.copyWith(
                            color: kBlackColor.withOpacity(0.64),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '4.5',
                              style: font20PrimaryMedium.copyWith(
                                fontSize: 15.sp,
                              ),
                            ),
                            Gap(3.w),
                            Icon(Icons.star, size: 17.sp, color: Colors.amber),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'منتجاتي',
                              style: font16BlackSemiBold.copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                        Gap(5.h),
                        SizedBox(
                          height: Shared.height * 0.57.h,
                          child: BlocListener<DeleteItemBloc, DeleteItemState>(
                            listener: (context, state) {
                              if (state.status == deleteItemStatus.loading) {
                                Shared.showLoadingDialog(context: context);
                              } else if (state.status ==
                                  deleteItemStatus.success) {
                                Shared.dismissDialog(context: context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("تم حذف المنتج بنجاح"),
                                  ),
                                );
                                context.read<MyListingsBloc>().add(
                                  GetMyListingsEvent(),
                                );
                              } else if (state.status ==
                                  deleteItemStatus.failure) {
                                Shared.dismissDialog(context: context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.failureMessage)),
                                );
                              }
                            },
                            child: BlocBuilder<MyListingsBloc, MyListingsState>(
                              builder: (context, state) {
                                if (state.status == myListingsStatus.loading) {
                                  return const LoadingPlaceHolder(
                                    shimmerType: ShimmerType.list,
                                    cellShimmerHeight: 50,
                                    shimmerCount: 10,
                                  );
                                } else if (state.status ==
                                    myListingsStatus.success) {
                                  final myListings = state.myListings;
                                  return myListings.isNotEmpty
                                      ? ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: myListings.length,
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return MyProductsItemListView(
                                              myListings: myListings[index],
                                            );
                                          },
                                        )
                                      : EmptyProducts(
                                          image: 'assets/images/empty_products.png',
                                          title: 'لم تقم بإضافة أي منتجات بعد',
                                          subTitle: 'أضف منتجاتك ليتمكن الآخرون من استئجارها',
                                        );
                                } else if (state.status ==
                                    myListingsStatus.failure) {
                                  return CustomErrorWidget(
                                    message: state.failureMessage,
                                    onRetry: () {
                                      context.read<MyListingsBloc>().add(
                                        GetMyListingsEvent(),
                                      );
                                    },
                                  );
                                } else {
                                  return Center(child: Text("لا توجد منتجات"));
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: Shared.width * 0.25.sp,
              left: Shared.width * 0.25.sp,
              top: Shared.height * 0.08.sp,
              child: CircleAvatar(
                radius: 70.r,
                backgroundImage: user.imageUrl != null
                    ? NetworkImage(
                        "${user.imageUrl}?t=${DateTime.now().millisecondsSinceEpoch}",
                      )
                    : AssetImage('assets/images/virtual_user.jpg')
                          as ImageProvider,
              ),
            ),
            Positioned(
              right: Shared.width * -0.08.sp,
              left: Shared.width * 0.28.sp,
              top: Shared.height * 0.01.sp,
              child: GestureDetector(
                onTap: () async {
                  final Data? userData = await sharedPreferenceManager.getUser();
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProfileScreen(user: user, userData: userData,),
                    ),
                  );

                  if (result == true) {
                    await _loadUser();
                  }
                },
                child: Image.asset('assets/images/edit_profile.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
