import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/components.dart';
import '../../../app/cubits/theme_mode_cubit/theme_mode_cubit.dart';

import '../../../app/cubits/theme_mode_cubit/theme_mode_state.dart';
import '../../../resources/colors_manager.dart';
import '../cubits/pin_code_cubit/pin_code_cubit.dart';
import '../cubits/timer_cubit/timer_cubit.dart';
import '../widgets/otp_view_body.dart';

class OTPView extends StatelessWidget {
  final String mail;
  final bool isReset;

  const OTPView({super.key, required this.isReset, required this.mail});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PinCodeCubit(),
          ),
          BlocProvider(
            create: (context) => TimerCubit()..startTimer(),
          ),
        ],
        child:
            // BlocBuilder<ThemeModeCubit, ThemeModeState>(
            //   builder: (context, state) {
            //     return
            StatusBarChangedWidget(
                statusBarColor: ColorsManager.trans,
                widget: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: OTPViewBody(isReset: isReset, mail: mail),
                )));
  }
}
