import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resources/assets_manager.dart';
import '../../../../resources/strings_manager.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  // var screenTextController = PageController();
  var svgPictureController = PageController();
  var titlesController = PageController();
  int index = 0;

  bool isLast = false;

  void updatePageStatus(int index, int titlesLength) {
    if (index == titlesLength - 1) {
      isLast = !isLast;
      this.index = index;
      emit(OnboardingToggleState());
    } else {
      this.index = index;
      isLast = isLast;
      emit(OnboardingToggleState());
    }
  }

  List<String> titles = [
    tr(StringsManager.onboardingTitle1),
    tr(StringsManager.onboardingTitle2),
  ];

  List<String> screenTitles = [
    StringsManager.customerConsultations,
    StringsManager.consultationsOffer,
  ];

  List<String> svgPicture = [
    AssetsManager.onboarding1,
    AssetsManager.onboarding2,
  ];

  @override
  Future<void> close() {
    svgPictureController.dispose();
    // screenTextController.dispose();
    titlesController.dispose();
    return super.close();
  }
}
