import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Chat/presentation/pages/coversations_screen.dart';
import 'package:ager_waffer/Features/Favorite/presentation/pages/favorite_screen.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/bottom_nav_cubit.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/home_screen.dart';
import 'package:ager_waffer/Features/Orders/presentation/pages/my_orders_screen.dart';
import 'package:ager_waffer/Features/Profile/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({super.key, this.email = '', this.password = ''});

  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(email: email, password: password),
      FavoriteScreen(),
      MyOrdersScreen(),
      ConversationsScreen(),
      ProfileScreen(),
    ];

    DateTime? lastBackPressed;

    Future<bool> onWillPop() async {
      final now = DateTime.now();

      if (lastBackPressed == null ||
          now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
        lastBackPressed = now;

        Fluttertoast.showToast(
          msg: kPressBackAgainToExit.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );

        return false;
      }

      return true;
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: IndexedStack(index: currentIndex, children: screens),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                border: BoxBorder.all(color: kPrimaryColor, width: 0.7),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child: BottomNavigationBar(
                  showUnselectedLabels: true,
                  backgroundColor: kWhiteColor,
                  currentIndex: currentIndex,
                  onTap: (index) {
                    context.read<BottomNavCubit>().changeIndex(index);
                  },
                  showSelectedLabels: true,
                  selectedItemColor: kPrimaryColor,
                  unselectedItemColor: kMoreGreyColor,
                  selectedLabelStyle: font14BlackBold.copyWith(
                    color: kPrimaryColor,
                    fontSize: 12,
                  ),
                  unselectedLabelStyle: font15BlackRegular.copyWith(
                    color: kMoreGreyColor,
                    fontSize: 12,
                  ),
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/home.png',
                        color: currentIndex == 0
                            ? kPrimaryColor
                            : kMoreGreyColor,
                      ),
                      label: kHome.tr(),
                      backgroundColor: kWhiteColor,
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/heart.png',
                        color: currentIndex == 1 ? kPrimaryColor : kMoreGreyColor,
                      ),
                      label: kFavorite.tr(),
                      backgroundColor: kWhiteColor,
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/shopping-cart.png',
                        color: currentIndex == 2 ? kPrimaryColor : kMoreGreyColor,
                      ),
                      label: kMyOrders.tr(),
                      backgroundColor: kWhiteColor,
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/shopping-cart.png',
                        color: currentIndex == 3 ? kPrimaryColor : kMoreGreyColor,
                      ),
                      label: kMyChats.tr(),
                      backgroundColor: kWhiteColor,
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/profile.png',
                        color: currentIndex == 4 ? kPrimaryColor : kMoreGreyColor,
                      ),
                      label: kMyAccount.tr(),
                      backgroundColor: kWhiteColor,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
