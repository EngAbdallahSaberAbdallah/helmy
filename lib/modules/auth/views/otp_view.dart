import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../resources/routes_manager.dart';
import '../../../app/components.dart';
import '../../../resources/colors_manager.dart';
import '../cubits/pin_code_cubit/pin_code_cubit.dart';
import '../cubits/timer_cubit/timer_cubit.dart';
import '../widgets/otp_view_body.dart';

class OTPView extends StatelessWidget {
  final String mail;
  final bool isReset;
  final bool isFromRegister;
  bool? isFromLogin= false ;
  bool? isCustomer = false;

   OTPView(
      {super.key,
      required this.isReset,
      required this.mail,
      required this.isFromRegister,
      this.isFromLogin,
      this.isCustomer
      });

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
                widget: WillPopScope(
                  onWillPop: () async {
                    Get.offAllNamed(HelmyRoutes.loginRoute);
                    return false;
                  },
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: OTPViewBody(
                      isCustomer: isCustomer!,
                      isFromLogin:  isFromLogin!,
                        isReset: isReset,
                        mail: mail,
                        isFromRegister: isFromRegister),
                  ),
                )));
  }
}
