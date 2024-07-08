import 'package:flutter/material.dart';
import '../../../resources/colors_manager.dart';

import '../../../../app/functions.dart';
import '../../../resources/values_manager.dart';
import '../cubits/bottom_nav_bar_cubit.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({
    super.key,
    required this.navBarCubit,
  });

  final BottomNavBarCubit navBarCubit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorsManager.primaryDarkPurple,
        selectedItemColor: ColorsManager.buttonDarkColor,
        selectedIconTheme: const IconThemeData(color: ColorsManager.buttonDarkColor),
        unselectedIconTheme: const IconThemeData(color: ColorsManager.primaryLightPurple),
        unselectedItemColor:  ColorsManager.primaryLightPurple,
        currentIndex: navBarCubit.bottomNavigationBarCurrentIndex,
        onTap: (index) {
          navBarCubit.changeBottomNavIndex(index);
        },
        items: navBarCubit.bottomNavListItem,
      ),
    );
  }
}
