import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../settings/view/settings.dart';
import '../../../home/view/home_page.dart';

import '../../../../resources/strings_manager.dart';
import '../../../../resources/colors_manager.dart';
part 'interpreter_bottom_nav_bar_state.dart';

class InterpreterBottomNavBarCubit extends Cubit<InterpreterBottomNavBarState> {
  InterpreterBottomNavBarCubit() : super(InterpreterBottomNavBarInitial());

  int bottomNavigationBarCurrentIndex = 0;

  List<String> titles = [
    tr(StringsManager.homePage),
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
      icon: const Icon(
        Icons.settings_outlined,
      ),
      label: tr(StringsManager.settings),
      backgroundColor: ColorsManager.primaryDarkPurple,
    ),
  ];

  List<Widget> homeLayoutScreens = [
    const HomePage(
      isFromInterpreter: true,
    ),
    const Settings(),
  ];

  void changeBottomNavIndex(int index) {
    bottomNavigationBarCurrentIndex = index;
    emit(InterpreterNavBarChangeIndex());
  }
}
