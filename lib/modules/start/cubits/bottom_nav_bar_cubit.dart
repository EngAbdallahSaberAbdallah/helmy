import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helmy_project/modules/favourite/view/favourite_page.dart';
import 'package:helmy_project/modules/home/view/home_page.dart';
import 'package:helmy_project/modules/my_dreams/view/my_dreams.dart';
import 'package:helmy_project/modules/profile/views/user_full_profile.dart';
import 'package:helmy_project/modules/settings/view/settings.dart';
import '../../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import 'package:helmy_project/modules/profile/views/user_profile_data.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarInitial());

  int bottomNavigationBarCurrentIndex = 0;

  List<String> titles = [
    tr(StringsManager.homeScreen),
    tr(StringsManager.favorite),
    tr(StringsManager.addDream),
    tr(StringsManager.myDreams),
    tr(StringsManager.settings),
  ];

  //List For Bottom Navigation Bar
  List<BottomNavigationBarItem> bottomNavListItem = [
    BottomNavigationBarItem(
        backgroundColor: ColorsManager.primaryDarkPurple,
        icon: const Icon(
          Icons.home_filled,
        ),
        label: tr(StringsManager.homePage)),
    BottomNavigationBarItem(
        backgroundColor: ColorsManager.primaryDarkPurple,
        icon: const Icon(
          Icons.favorite_outline_outlined,
        ),
        label: tr(StringsManager.favorite)),
    const BottomNavigationBarItem(
      icon:  Icon(
        Icons.add,color: ColorsManager.primaryDarkPurple,
      ),
      label: '',
      backgroundColor: ColorsManager.primaryDarkPurple,
    ),
    BottomNavigationBarItem(
      icon: const Icon(
        Icons.settings_system_daydream_outlined,
      ),
      label: tr(StringsManager.myDreams),
      backgroundColor: ColorsManager.primaryDarkPurple,
    ),
    BottomNavigationBarItem(
      icon: const Icon(
        Icons.settings_outlined,
      ),
      label: tr(StringsManager.settings),
      backgroundColor: ColorsManager.primaryDarkPurple,
    ),
  ];

  List<Widget> homeLayoutScreens = [
    const HomePage(),
    const FavouritePage(),
    const Placeholder(),
     MyDreams(),
    const Settings(),
  ];

  void changeBottomNavIndex(int index) {
    bottomNavigationBarCurrentIndex = index;
    emit(NavBarChangeIndex());
  }
}