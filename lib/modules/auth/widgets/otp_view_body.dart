import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/components.dart';
import 'build_header_image.dart';
import 'header_sub_title_text.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/styles_manager.dart';

import '../../../app/functions.dart';
import '../../../resources/strings_manager.dart';

import 'enter_send_code_with_phone.dart';
import 'logo_with_bottom_text.dart';
import 'otp_button_widget.dart';
import 'pin_code_custom_widget.dart';
import 'time_row.dart';

String code = "";

class OTPViewBody extends StatefulWidget {
  OTPViewBody(
      {super.key,
      required this.isReset,
      required this.mail,
      required this.isFromRegister,
      required this.isFromLogin,
      required this.isCustomer});

  final bool isFromLogin;
  final bool isCustomer;
  final bool isReset;
  final String mail;
  final bool isFromRegister;

  @override
  State<OTPViewBody> createState() => _OTPViewBodyState();
}

class _OTPViewBodyState extends State<OTPViewBody> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: ListView(
        padding: EdgeInsets.zero,
        // child: SizedBox(
        //   height: MediaQuery.of(context).size.height,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderImage(context),
          SizedBox(
            height: 16.sp,
          ),
          _buildBody(context),
        ],
        // ),
        // ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.sp),
      child: Column(
        children: [
          _buildContentText(),

          // Slots for PIN code
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: PinCodeCustomWidget(controller: controller),
          ),
          SizedBox(
            height: 20.sp,
          ),
          TimerRow(mail: widget.mail),
          SizedBox(
            height: 50.sp,
          ),
          OtpButtonWidget(
            isCustomer: widget.isCustomer,
            isFromLogin: widget.isFromLogin,
            isReset: widget.isReset,
            phoneNumber: widget.mail,
            code: controller.text,
            isFromRegister: widget.isFromRegister,
          ),
          // const SizedBox(
          //   height: 8,
          // ),
          // Text(
          //   tr(
          //     StringsManager.didnotReceiveAnyMail,
          //   ),
          //   style: getRegularStyle(
          //       color: ColorsManager.textShade,
          //       fontSize: 14,
          //       fontWeight: FontWeight.w400),
          // ),
          // const SizedBox(
          //   height: 3,
          // ),
          // OnTabText(text: tr(StringsManager.sendAgain), textAlign: TextAlign.center)
        ],
      ),
    );
  }

  Widget _buildHeaderImage(BuildContext context) {
    return BuildHeaderImage(imgPath: AssetsManager.otp, height: 390.sp);
  }

  Widget _buildContentText() {
    return SizedBox(
      height: 120,
      child: HeaderSubTitleText(
          header: tr(StringsManager.enterVerificationCode),
          subTitle: widget.isReset
              ? tr(StringsManager.otpContentResetPassword)
              : tr(StringsManager.otpContentVerification)),
    );
  }
}
