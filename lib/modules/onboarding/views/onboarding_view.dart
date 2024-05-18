import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import '../../../app/functions.dart';
import '../cubits/onboarding_cubit/onboarding_cubit.dart';
import '../widgets/upper_widget.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    statusBarDarkLightSwitchFunction(context);
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: const Scaffold(
          backgroundColor: ColorsManager.primaryDarkPurple,
          body: UpperWidget()),
    );
  }
}
