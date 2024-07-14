import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'login_view.dart';

import '../../../app/components.dart';
import '../../../app/functions.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import '../widgets/logo_with_bottom_text.dart';

class ResetPasswordDoneView extends StatelessWidget {
  final bool isRestFromRoot;
  const ResetPasswordDoneView({super.key, required this.isRestFromRoot});

  @override
  Widget build(BuildContext context) {
    return StatusBarChangedWidget(
      statusBarColor: ColorsManager.primaryDarkPurple,
      statusBarBrightness: Brightness.light,
      widget:  WillPopScope(
        onWillPop: () async {
          Get.offAll(() => const LoginView());
          return true;
        },
        child:  Scaffold(
          body: Align(
              alignment: AlignmentDirectional.center,
              child: ListView(
                padding: EdgeInsets.only(
                    top: MediaQuery.paddingOf(context).top,
                    left: AppSize.s16,
                    right: AppSize.s16),
                children: [
                  SizedBox(
                    height: calcHeight(62, context),
                  ),
                  const LogoWithBottomText(title: ''),
                  SvgPicture.asset(
                    AssetsManager.resetPassword,
                    height: calcHeight(78.05, context),
                    width: calcWidth(78.05, context),
                  ),
                  SizedBox(
                    height: calcHeight(AppSize.s28, context),
                  ),
                  Text(
                    tr('password_reset_successfully'),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: AppSize.s22.sp),
                  ),
                  SizedBox(
                    height: calcHeight(AppSize.s38, context),
                  ),
                  DefaultPrimaryButton(
                    textColor: Theme.of(context).primaryColorDark,
                      color: ColorsManager.primaryDarkPurple,
                    buttonText: isRestFromRoot
                        ? tr('log_in_now')
                        : tr(StringsManager.goBack),
                    onPressed: () {
                      if (isRestFromRoot == true) {
                        Get.offAllNamed(HelmyRoutes.loginRoute);
                      } else {
                        Get.back();
                      }
                    },
                    showArrow: false,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
