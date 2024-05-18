import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:helmy_project/modules/start/views/start_view.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../app/components.dart';
import '../../../resources/strings_manager.dart';
import '../blocs/auth_bloc/auth_bloc.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    super.key,
    required this.loginFormKey,
    required this.lPhoneController,
    required this.lPassController,
  });

  final GlobalKey<FormState> loginFormKey;
  final TextEditingController? lPhoneController;
  final TextEditingController? lPassController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is LoginLoading) {
            loading(context: context);
          }
          if (state is LoginSuccess) {
            // Navigator.pop(context);
            // if (loginFormKey.currentState!.validate()) {
            //   context.read<AuthBloc>().add(Login(
            //       phoneNumber: lPhoneController!.text,
            //       password: lPassController!.text));
            // }
          }
          if (state is LoginError) {
            Navigator.pop(context);
            if (state.errorStatusCode == 423) {
              Get.toNamed(HelmyRoutes.forgetPasswordRoute, arguments: false);
            }
            // Navigator.pop(context);
          }
        },
        child: DefaultPrimaryButton(
          textColor: Theme.of(context).primaryColorDark,
          buttonText: tr(StringsManager.registerNow),
          onPressed: () {
            if (loginFormKey.currentState!.validate()) {
              context.read<AuthBloc>().add(Login(
                  phoneNumber: lPhoneController!.text,
                  password: lPassController!.text));
              
            }
          },
          showArrow: false,color: ColorsManager.primaryDarkPurple,
        ));
  }
  //   BlocBuilder<AuthBloc, AuthState>(
  //   builder: (authContext, state) {
  //     if (state is! LoginLoading) {
  //       return DefaultPrimaryButton(
  //         textColor: Theme.of(context).primaryColorDark,
  //         buttonText: StringsManager.registerNow,
  //         onPressed: () {
  //           if (loginFormKey.currentState!.validate()) {
  //             authContext.read<AuthBloc>().add(Login(
  //                 phoneNumber: lPhoneController!.text,
  //                 password: lPassController!.text));
  //           }
  //         },
  //           showArrow: false,
  //         );
  //       } else {
  //         return const CustomCircleProgressIndicator();
  //       }
  //     if(state.errorStatusCode == 423) {
  //       Get.toNamed(LawyerRoutes.forgetPasswordRoute,
  //           arguments: false);
  //     }
  //   },
  // );
  // }

  Future loading({required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (context) => const CustomCircleProgressIndicator(),
      barrierDismissible: false,
    );
  }
}
