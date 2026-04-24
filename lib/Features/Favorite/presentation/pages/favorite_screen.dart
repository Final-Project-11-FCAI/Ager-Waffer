import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Shimmer/loading_shimmer.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Favorite/presentation/manager/all_favorite_items_bloc.dart';
import 'package:ager_waffer/Features/Favorite/presentation/manager/all_favorite_items_state.dart';
import 'package:ager_waffer/Features/Favorite/presentation/manager/favorite_bloc.dart';
import 'package:ager_waffer/Features/Favorite/presentation/widgets/empty_favorite.dart';
import 'package:ager_waffer/Features/Favorite/presentation/widgets/favorite_item_gide_view.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    super.initState();
    context.read<AllFavoriteItemsBloc>().add(GetAllFavoriteItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? kDarkModeColor : kPrimaryColor,
      appBar: AppBar(
        backgroundColor: isDark ? kMoreDarkModeColor : kPrimaryColor,
        title: Text(
          kFavoriteItems.tr(),
          style: font16BlackSemiBold.copyWith(
            color: kWhiteColor,
            fontWeight: bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<AllFavoriteItemsBloc>().add(GetAllFavoriteItemsEvent());
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? kDarkModeColor : kWhiteColor,
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
            child: BlocListener<AllFavoriteItemsBloc, AllFavoriteItemsState>(
              listenWhen: (prev, curr) =>
              prev.favoriteItems != curr.favoriteItems,
              listener: (context, state) {
                if (state.status == allFavoriteItemsStatus.success) {
                  final favoritesMap = {
                    for (var item in state.favoriteItems) item.id!: true,
                  };

                  context.read<FavoriteBloc>().add(
                    SyncFavoritesEvent(favoritesMap),
                  );
                }
              },
              child: BlocBuilder<AllFavoriteItemsBloc, AllFavoriteItemsState>(
                builder: (context, state) {
                  if (state.status == allFavoriteItemsStatus.loading) {
                    return const LoadingPlaceHolder(
                      shimmerType: ShimmerType.list,
                      cellShimmerHeight: 50,
                      shimmerCount: 10,
                    );
                  }

                  if (state.status == allFavoriteItemsStatus.failure) {
                    return CustomErrorWidget(
                      message: state.failureMessage,
                      onRetry: () {
                        context.read<AllFavoriteItemsBloc>().add(
                          GetAllFavoriteItemsEvent(),
                        );
                      },
                    );
                  }

                  final items = state.favoriteItems;

                  if (items.isEmpty) {
                    return EmptyFavorite();
                  }

                  return GridView.builder(
                    itemCount: items.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15.w,
                      crossAxisSpacing: 15.w,
                      childAspectRatio: 2.h / 3.2.h,
                    ),
                    itemBuilder: (context, index) {
                      return FavoriteItemGideView(
                        allFavoriteItems: items[index],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
