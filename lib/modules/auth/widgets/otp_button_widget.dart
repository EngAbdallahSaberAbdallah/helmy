import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import '../../../app/components.dart';
import '../../../app/functions.dart';
import '../../../helpers/cache_helper.dart';
import '../../../helpers/services_locator.dart';
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

  const OtpButtonWidget({
    super.key,
    required this.isReset,
    required this.phoneNumber,
    required this.code
  });

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
          } else {
            Get.offAllNamed(HelmyRoutes.userStartRoute);
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
                        authContext.read<AuthBloc>().add(VerifyOTP(
                            otp: pinCodeState.otp, phoneNumber: phoneNumber));
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
