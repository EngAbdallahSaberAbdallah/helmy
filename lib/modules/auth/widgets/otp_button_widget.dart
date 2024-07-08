import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:helmy_project/helpers/snackbar_helper.dart';
import '../../../resources/colors_manager.dart';
import '../../../app/components.dart';
import '../../../app/functions.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../cubits/pin_code_cubit/pin_code_cubit.dart';
import '../cubits/pin_code_cubit/pin_code_state.dart';
import '../views/reset_password_view.dart';

class OtpButtonWidget extends StatelessWidget {
  final String phoneNumber;
  final bool isReset;
  final String code;
  final bool isFromRegister;
  final bool isFromLogin;
  final bool isCustomer;

  const OtpButtonWidget(
      {super.key,
      required this.isReset,
      required this.phoneNumber,
      required this.code,
      required this.isFromRegister,
      required this.isFromLogin,
      required this.isCustomer});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (authContext, authState) async {
        if (authState is VerifyOTPSuccess) {
          if (isReset == true) {
            pushNavigatorReplacement(
                context: authContext,
                widget: ResetPasswordView(
                  code: code,
                  phoneNumber: phoneNumber,
                  isRestFromRoot: true,
                ));
            // await getIt
            //     .get<CacheHelper>()
            //     .saveToken(authState.userResponse.data!.apiToken!);
          } else if (isFromLogin) {
            SnackBarHelper.showSuccessSnackBar(
                tr(StringsManager.success), tr(StringsManager.loginContent));
            Get.offAllNamed(HelmyRoutes.loginRoute);
          }
        }
      },
      builder: (authContext, authState) {
        if (authState is! VerifyOTPLoading) {
          return BlocBuilder<PinCodeCubit, PinCodeState>(
            builder: (pinCodeContext, pinCodeState) {
              return pinCodeState.isCompleted
                  ? DefaultPrimaryButton(
                      textColor: Theme.of(context).primaryColorDark,
                      buttonText: tr(StringsManager.verify),
                      onPressed: () {
                        if (isFromRegister) {
                          authContext.read<AuthBloc>().add(VerifyEmailWithCode(
                              otp: pinCodeState.otp, email: phoneNumber));
                        } else if (isFromLogin) {
                          authContext.read<AuthBloc>().add(VerifyEmailWithCode(
                              otp: pinCodeState.otp, email: phoneNumber));
                        } else {
                          authContext.read<AuthBloc>().add(VerifyOTP(
                              otp: pinCodeState.otp, phoneNumber: phoneNumber));
                        }
                      },
                      showArrow: false,
                      color: ColorsManager.primaryDarkPurple,
                    )
                  : const SizedBox();
            },
          );
        } else {
          return const CustomCircleProgressIndicator();
        }
      },
    );
  }
}
