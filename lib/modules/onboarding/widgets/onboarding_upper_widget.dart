// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/assets_manager.dart';
import '../cubits/onboarding_cubit/onboarding_cubit.dart';
import 'onboarding_bottom_buttons.dart';

class OnboardingUpperWidget extends StatelessWidget {
  const OnboardingUpperWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var onboardingCubit = context.read<OnboardingCubit>();
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height:580.sp,
            width: double.infinity,
            child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: onboardingCubit.svgPictureController,
                onPageChanged: (index){
                  onboardingCubit.updatePageStatus(index, onboardingCubit.titles.length);
                },
                itemCount: onboardingCubit.svgPicture.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    onboardingCubit.svgPicture[index],
                    height: 560,
                    fit: BoxFit.cover,
                  );
                }),
          ),
        ),
        Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: SvgPicture.asset(
              AssetsManager.bottomLeftOnboardingScreen,
              width: 190,
            )),
        const Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: OnboardingBottomButtons(),
        ),
      ],
    );
  }
}
