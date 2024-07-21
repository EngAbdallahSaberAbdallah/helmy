import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'login_view.dart';
import '../widgets/build_header_image.dart';
import '../widgets/header_sub_title_text.dart';
import '../widgets/otp_view_body.dart';
import '../../../resources/assets_manager.dart';

import '../../../../app/components.dart';
import '../../../helpers/validation.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import '../widgets/reset_password_button_widget.dart';

class ResetPasswordView extends StatefulWidget {
  final String phoneNumber;
  final String code;
  final bool isRestFromRoot;

  const ResetPasswordView(
      {super.key, required this.phoneNumber, required this.code,required this.isRestFromRoot});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  GlobalKey<FormState> resetFormKey = GlobalKey();

  TextEditingController? sOldPasswordController = TextEditingController();
  TextEditingController? sNewPasswordController = TextEditingController();
  TextEditingController? sNewConfirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StatusBarChangedWidget(
      statusBarColor: ColorsManager.trans,
      widget: WillPopScope(
        onWillPop: () async {
          Get.offAll(() => const LoginView());
          return true;
        },
        child: Scaffold(
          // floatingActionButton: const WhatsAppIcon(),
          body: Align(
            alignment: AlignmentDirectional.topStart,
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Form(
                key: resetFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderImage(context),
                    const SizedBox(
                      height: 16,
                    ),
                    _buildBody(context)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(children: [
          _buildContentText(),
          widget.isRestFromRoot == false
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSecureTextFormField(
                      controller: sOldPasswordController,
                      validator: (oldPassword) =>
                          ValidationHelper.validatePassword(
                              context, oldPassword),
                      hint: StringsManager.oldPassword,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                )
              : const SizedBox(),
          CustomSecureTextFormField(
            controller: sNewPasswordController,
            validator: (newPassword) =>
                ValidationHelper.validatePassword(context, newPassword),
            hint: tr(StringsManager.newPassword),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomSecureTextFormField(
            controller: sNewConfirmPasswordController,
            validator: (newConfirmPassword) =>
                ValidationHelper.validateConfirmPassword(
                    newConfirmPassword!, sNewPasswordController!.text, context),
            hint: tr(StringsManager.confirmNewPassword),
          ),
          const SizedBox(
            height: 75,
          ),
          ResetPasswordButtonWidget(
              phoneNumber: widget.phoneNumber,
              code: code,
              resetFormKey: resetFormKey,
              sOldPasswordController: sOldPasswordController,
              sResetPassController: sNewPasswordController,
              isRestFromRoot: widget.isRestFromRoot),
        ]));
  }

  Widget _buildHeaderImage(BuildContext context) {
    return BuildHeaderImage(imgPath: AssetsManager.newPassword, height: 400.sp);
  }

  Widget _buildContentText() {
    return SizedBox(
      height: 120,
      child: HeaderSubTitleText(
          header: tr(StringsManager.enterNewPassword),
          subTitle: tr(StringsManager.newPassContent)),
    );
  }

  @override
  void dispose() {
    sOldPasswordController!.dispose();
    sNewConfirmPasswordController!.dispose();
    sNewPasswordController!.dispose();
    super.dispose();
  }
}
