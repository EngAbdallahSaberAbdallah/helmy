import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'onboarding_button.dart';
import '../../../resources/routes_manager.dart';
import '../../../helpers/cache_helper.dart';
import '../../../helpers/services_locator.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import '../cubits/onboarding_cubit/onboarding_cubit.dart';
import 'package:easy_localization/easy_localization.dart';

class OnboardingBottomButtons extends StatelessWidget {
  const OnboardingBottomButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var onboardingCubit = context.read<OnboardingCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 63,
            right: 63,
          ),
          height: MediaQuery.sizeOf(context).height * 0.2,
          child: PageView.builder(
              controller: onboardingCubit.titlesController,
              itemCount: onboardingCubit.titles.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Text(
                  onboardingCubit.titles[index],
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      height: 1.7,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                );
              }),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.035,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22, right: 22, bottom: 36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  await getIt
                      .get<CacheHelper>()
                      .saveOnBoarding(true)
                      .then((value) =>
                          // buildPushReplacement(context, const Registration())
                          Get.offAllNamed(HelmyRoutes.userStartRoute));
                },
                child: Text(
                  tr(StringsManager.skip),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 22,
                      color: ColorsManager.buttonDarkColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const OnboardingButton(),
            ],
          ),
        )
      ],
    );
  }
}
