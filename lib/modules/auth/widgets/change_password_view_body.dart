import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/functions.dart';
import '../views/check_mail.dart';
import 'build_header_image.dart';
import 'header_sub_title_text.dart';
import '../../../resources/assets_manager.dart';
import '../../../app/components.dart';
import '../../../helpers/validation.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import '../blocs/auth_bloc/auth_bloc.dart';

class ChangePasswordViewBody extends StatelessWidget {
  final bool fromChangePassword;
  const ChangePasswordViewBody({
    super.key,
    required this.changePasswordFormKey,
    required this.cPassController,
    required this.fromChangePassword,
  });

  final GlobalKey<FormState> changePasswordFormKey;
  final TextEditingController? cPassController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: SingleChildScrollView(
        child: Form(
          key: changePasswordFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildHeaderImage(context),
              const SizedBox(
                height: 16,
              ),
              _buildContentText(),
              const SizedBox(
                height: 16,
              ),
              _buildFormFields(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          CustomTextFormField(
            hint: tr(StringsManager.enterEmail),
            heightOfTextFormField: 51,
            textInputType: TextInputType.emailAddress,
            controller: cPassController,
            borderColor: ColorsManager.primaryDarkPurple,
            onChanged: (value) {
              print('value is and email is ${cPassController!.text}');
            },
            formatter: [FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))],
            validator: (value) => value!.isEmpty
                ? null
                : ValidationHelper.validateEmail(context, value),
            sufixIconBackground: Theme.of(context).dividerColor,
          ),
          const SizedBox(
            height: 87,
          ),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is ForgetPasswordSuccess) {
                pushNavigator(
                    context: context,
                    widget: CheckMail(mail: cPassController!.text, isFromRegister: false));
              }
            },
            builder: (context, state) {
              if (state is! ForgetPasswordLoading) {
                return DefaultPrimaryButton(
                  color: ColorsManager.primaryDarkPurple,
                  textColor: Theme.of(context).primaryColorDark,
                  buttonText: tr(StringsManager.sendCode),
                  onPressed: () {
                    if (changePasswordFormKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                          ForgetPassword(phoneNumber: cPassController!.text));
                    }
                  },
                  showArrow: false,
                );
              } else {
                return const CustomCircleProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildHeaderImage(BuildContext context) {
    return BuildHeaderImage(
        imgPath: AssetsManager.resetPassword, height: 422.sp);
  }

  Widget _buildContentText() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: HeaderSubTitleText(
            header: tr(StringsManager.resetPassword),
            subTitle: tr(StringsManager.resetPasswordContent)));
  }
}
