import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helmy_project/resources/colors_manager.dart';

import '../../../app/components.dart';
import '../../../resources/strings_manager.dart';
import '../blocs/auth_bloc/auth_bloc.dart';

class ResetPasswordButtonWidget extends StatelessWidget {
  final TextEditingController? sResetPassController;
  final TextEditingController? sOldPasswordController;
  final String phoneNumber;
  final String code;
  final GlobalKey<FormState> resetFormKey;
  final bool isRestFromRoot;

  const ResetPasswordButtonWidget(
      {super.key,
      this.sResetPassController,
      this.sOldPasswordController,
      required this.phoneNumber,
      required this.code,
      required this.resetFormKey,
      required this.isRestFromRoot});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (isRestFromRoot) {
          if (state is! ResetPasswordLoading) {
            return DefaultPrimaryButton(color: ColorsManager.primaryDarkPurple,
                textColor: Theme.of(context).primaryColorDark,
                buttonText: StringsManager.changePassword,showArrow: false,
                onPressed: () {
                  if (resetFormKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(ResetPassword(
                        sResetPassController!.text,
                        code: code,
                        isRestFromRoot: isRestFromRoot));
                  }
                });
          }
        }
        if (state is! ChangePasswordLoading) {
          return DefaultPrimaryButton(
            textColor: Theme.of(context).primaryColorDark,
            color: ColorsManager.primaryDarkPurple,
            buttonText: StringsManager.changePassword,
            
            onPressed: () {
              if (resetFormKey.currentState!.validate()) {
                context.read<AuthBloc>().add(ChangePassword(
                      oldPassword: sOldPasswordController!.text,
                      newPassword: sResetPassController!.text,
                      code: code
                    ));
              }
            },
            showArrow: false,
            
          );
        } else {
          return const CustomCircleProgressIndicator();
        }
      },
    );
  }
}
