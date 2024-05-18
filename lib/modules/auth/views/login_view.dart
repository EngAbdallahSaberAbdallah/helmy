// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helmy_project/modules/auth/widgets/build_header_image.dart';
import 'package:helmy_project/modules/auth/widgets/header_sub_title_text.dart';
import 'package:helmy_project/modules/auth/widgets/login_button_widget.dart';
import 'package:helmy_project/modules/auth/widgets/row_with_on_tab_text.dart';
import 'package:helmy_project/resources/assets_manager.dart';

import '../../../app/components.dart';
import '../../../helpers/validation.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginFormKey = GlobalKey<FormState>();

  TextEditingController? lEmailController = TextEditingController();
  TextEditingController? lPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // statusBarDarkLightSwitchFunction(context);
    return StatusBarChangedWidget(
      statusBarColor: ColorsManager.trans,
      widget: Scaffold(
        backgroundColor: ColorsManager.primaryLightPurple,
        body: SingleChildScrollView(
          child: Form(
            key: loginFormKey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildHeaderImage(),
                        _buildContentText(),
                        SizedBox(
                          height: 41.sp,
                        ),
                        _buildFormFields(),
                      ],
                    ),
                  ),
                  _buildBtns(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildFormFields() {
    return Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          CustomTextFormField(
            hint: tr(StringsManager.enterEmail),
            heightOfTextFormField: 51,
            textInputType: TextInputType.emailAddress,
            controller: lEmailController,
            borderColor: ColorsManager.primaryDarkPurple,
            onChanged: (value) {
              print('value is $value');
            },
            formatter: [FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))],
            validator: (value) => value!.isEmpty
                ? tr(StringsManager.enterEmail)
                : ValidationHelper.validateEmail(context, value),
            sufixIconBackground: Theme.of(context).dividerColor,
          ),
          SizedBox(
            height: 8.h,
          ),
          CustomSecureTextFormField(
            hint: StringsManager.enterPassword,
            controller: lPassController,
            validator: (value) =>
                ValidationHelper.validatePassword(context, value),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              OnTabText(
                text: tr(StringsManager.forgotPassword),
                textAlign: TextAlign.end,
                textColor: Theme.of(context).focusColor,
                onTab: () {
                  Navigator.pushNamed(context, HelmyRoutes.forgetPasswordRoute,
                      arguments: true);
                },
              ),
            ],
          ),
        ],
      
        // SizedBox(
        //   height: 171.sp,
        // ),
      ),
    );
  }

  Widget _buildBtns() {
    return Transform.translate(
      offset: Offset(0, MediaQuery.of(context).size.height - 120.h),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              LoginButtonWidget(
                  loginFormKey: loginFormKey,
                  lPhoneController: lEmailController,
                  lPassController: lPassController),
              const SizedBox(
                height: 8,
              ),
              RowWithOnTabText(
                firstText: tr(StringsManager.noAccount),
                secondText: tr(StringsManager.createAccount),
                firstTextColor: ColorsManager.borderGrey,
                onTabTextColor: ColorsManager.primaryDarkPurple,
                onTab: () =>
                    Navigator.pushNamed(context, HelmyRoutes.registerRoute),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return BuildHeaderImage(imgPath: AssetsManager.login, height: 277.sp);
  }

  Widget _buildContentText() {
    return Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: HeaderSubTitleText(
            header: tr(StringsManager.welcomeBack),
            subTitle: tr(StringsManager.loginContent)));
  }

  @override
  void dispose() {
    lEmailController!.dispose();
    lPassController!.dispose();
    super.dispose();
  }
}