import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/bottom_nav_cubit.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/home_screen.dart';
import 'package:ager_waffer/Features/Profile/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      // Scaffold(),
      HomeScreen(),
      Scaffold(),
      Scaffold(),
      ProfileScreen(),
    ];
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: screens,
          ),
          bottomNavigationBar: Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
        ),
          border: BoxBorder.all(color: kPrimaryColor, width: 0.7)
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
                selectedLabelStyle: font14BlackBold.copyWith(color: kPrimaryColor,fontSize: 12),
                unselectedLabelStyle: font15BlackRegular.copyWith(color: kMoreGreyColor,fontSize: 12),
                items: [
                  // BottomNavigationBarItem(
                  //   icon: Image.asset('assets/images/nimbus_list.png', color: currentIndex == 0 ? kPrimaryColor : kMoreGreyColor,),
                  //   label: "القائمة",
                  //   backgroundColor: kWhiteColor,
                  // ),
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/images/home.png', color: currentIndex == 0 ? kPrimaryColor : kMoreGreyColor,),
                    label: "الرئيسية",
                    backgroundColor: kWhiteColor,
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/images/heart.png', color: currentIndex == 1 ? kPrimaryColor : kMoreGreyColor,),
                    label: "المفضلة",
                    backgroundColor: kWhiteColor,
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/images/shopping-cart.png', color: currentIndex == 2 ? kPrimaryColor : kMoreGreyColor,),
                    label: "مستأجراتي",
                    backgroundColor: kWhiteColor,
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/images/profile.png', color: currentIndex == 3 ? kPrimaryColor : kMoreGreyColor,),
                    label: "حسابي",
                    backgroundColor: kWhiteColor,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}




