import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../auth/views/registration.dart';
import '../../../resources/routes_manager.dart';
import '../../../app/functions.dart';
import '../../../helpers/cache_helper.dart';
import '../../../helpers/services_locator.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import 'dart:math' as math;
import '../cubits/onboarding_cubit/onboarding_cubit.dart';
import 'package:easy_localization/easy_localization.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        var onboardingCubit = context.read<OnboardingCubit>();
        return Align(
          alignment: AlignmentDirectional.center,
          child: InkWell(
              onTap: () async {
                onboardingCubit.isLast
                    ? await getIt
                        .get<CacheHelper>()
                        .saveOnBoarding(true)
                        .then((value) =>
                            // buildPushReplacement(context, const Registration())
                            Get.offAllNamed(HelmyRoutes.userStartRoute))
                    : onboardingButtonFunc(onboardingCubit, context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    onboardingCubit.isLast
                        ? tr(StringsManager.start)
                        : tr(StringsManager.next),
                    style: const TextStyle(
                        fontSize: 22,
                        color: ColorsManager.primaryLightPurple,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    width: 1.3,
                  ),
                  Transform.rotate(
                      angle: 180 * math.pi / 180,
                      child: const Icon(
                        Icons.skip_next_rounded,
                        color: ColorsManager.primaryLightPurple,
                        size: 24,
                      ))
                ],
              )),
        );
      },
    );
  }

  void onboardingButtonFunc(
      OnboardingCubit onboardingCubit, BuildContext context) {
    buildNextPage(onboardingCubit.svgPictureController);
    // buildNextPage(onboardingCubit.screenTextController);
    buildNextPage(onboardingCubit.titlesController);
  }
}
