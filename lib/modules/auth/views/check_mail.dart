import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../resources/routes_manager.dart';
import '../../../app/components.dart';
import '../../../app/functions.dart';
import 'otp_view.dart';
import '../widgets/build_header_image.dart';
import '../widgets/header_sub_title_text.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';

class CheckMail extends StatelessWidget {
  final String mail;
  final bool isFromRegister;
  const CheckMail(
      {super.key, required this.mail, required this.isFromRegister});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(HelmyRoutes.loginRoute);
        return false;
      },
      child: Scaffold(
        body: Align(
            alignment: AlignmentDirectional.topStart,
            child: SingleChildScrollView(
                padding: EdgeInsets.zero,
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
                        height: 142,
                      ),
                      _buildBtns(context),
                    ]))),
      ),
    );
  }

  Widget _buildHeaderImage(BuildContext context) {
    return BuildHeaderImage(imgPath: AssetsManager.checkEmail, height: 422.sp);
  }

  Widget _buildContentText() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          height: 120,
          child: HeaderSubTitleText(
              header: tr(StringsManager.checkMail),
              subTitle: tr(StringsManager.checkMailContent)),
        ));
  }

  Widget _buildBtns(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          DefaultPrimaryButton(
            color: ColorsManager.primaryDarkPurple,
            textColor: Theme.of(context).primaryColorDark,
            buttonText: tr(StringsManager.enterCode),
            onPressed: () {
              pushNavigatorReplacement(
                  context: context,
                  widget:
                      OTPView(isReset: true, mail: mail, isFromRegister: isFromRegister));
            },
            showArrow: false,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            tr(
              StringsManager.didnotReceiveAnyMail,
            ),
            style: getRegularStyle(
                color: ColorsManager.textShade,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 3,
          ),
          OnTabText(
              text: tr(StringsManager.sendAgain), textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
