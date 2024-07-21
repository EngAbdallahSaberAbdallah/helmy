import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../resources/routes_manager.dart';

import '../../../app/components.dart';
import '../../../resources/colors_manager.dart';
import '../widgets/change_password_view_body.dart';

class ForgetPasswordView extends StatefulWidget {
  final bool fromChangePassword;
  const ForgetPasswordView({
    super.key,
    required this.fromChangePassword,
  });

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final changePasswordFormKey = GlobalKey<FormState>();

  TextEditingController? cPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StatusBarChangedWidget(
      statusBarColor: ColorsManager.trans,
      widget: WillPopScope(
        onWillPop: () async {
          // Get.offAll(HelmyRoutes.loginRoute);
          return true;
        },
        child: Scaffold(
          backgroundColor: ColorsManager.primaryLightPurple,
          body: ChangePasswordViewBody(
              fromChangePassword: widget.fromChangePassword,
              changePasswordFormKey: changePasswordFormKey,
              cPassController: cPassController),
        ),
      ),
    );
  }

  @override
  void dispose() {
    cPassController!.dispose();
    super.dispose();
  }
}
