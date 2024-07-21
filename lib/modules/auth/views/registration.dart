import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/components.dart';
import 'login_view.dart';
import 'register_view.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusBarChangedWidget(
      statusBarColor: ColorsManager.trans,
      widget:  Scaffold(
        backgroundColor: ColorsManager.primaryLightPurple,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderImage(context: context),
               SizedBox(
                height: 65.sp,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                
                    _buildContentText(),
                     SizedBox(
                      height: 59.sp,
                    ),
                    _buildLoginButton(),
                     SizedBox(
                      height: 24.sp,
                    ),
                    _buildRegisterButton(),
                     SizedBox(
                      height: 24.sp,
                    ),
                    // _buildTextOR(),
                    // const SizedBox(
                    //   height: 24,
                    // ),
                    // _buildCreateAccountWithGoogle(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // write (Or)
  Widget _buildTextOR() {
    return  Text(
      'Or',
      style:getRegularStyle(color:  ColorsManager.primaryDarkPurple, fontSize: 18,)
     ,
    );
  }

  Widget _buildLoginButton() {
    return DefaultPrimaryButton(
      buttonText: tr(StringsManager.login),
      textColor: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 16,
      showArrow: false,
      color: ColorsManager.primaryDarkPurple,
      onPressed: () {
        Get.offAll(()=> const LoginView());
      },
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: ColorsManager.black),
          borderRadius: BorderRadius.circular(8)),
      child: DefaultPrimaryButton(
          buttonText: tr(StringsManager.createAccount),
          textColor: ColorsManager.black,
          fontWeight: FontWeight.w700,
          fontSize: 16,
          showArrow: false,
          color: ColorsManager.secondaryBtnBg,
          onPressed: () {
            Get.offAll(()=> const  RegisterView());
          }),
    );
  }

  Widget _buildCreateAccountWithGoogle() {
    return DefaultPrimaryButtonWithIcon(
        buttonText: tr(StringsManager.loginWithGoogle),
        textColor: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: ColorsManager.thirdBtnBg,
        icon: Icons.account_box,
        iconColor: Colors.white,
        onPressed: () {});
  }

  Widget _buildHeaderImage({required BuildContext context}) {
    return Image.asset(
      AssetsManager.registration,
      width: MediaQuery.of(context).size.width,
      height: 341,
      fit: BoxFit.cover,
    );
  }

  Widget _buildContentText() {
    return Center(
      child: Text(
        tr(StringsManager.registrationContent),
        style:   getRegularStyle(
            color: ColorsManager.black,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
