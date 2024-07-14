import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:helmy_project/modules/about_helmy/view/contact_us.dart';
import 'package:helmy_project/modules/about_helmy/view/privacy_policy.dart';
import 'package:helmy_project/modules/about_helmy/view/terms_condition_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:helmy_project/network/network_constants.dart';
import '../../profile/views/profile.dart';
import '../../../helpers/cache_helper.dart';
import '../../../helpers/services_locator.dart';
import '../../about_helmy/view/about_helmy.dart';
import '../../auth/views/login_view.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../resources/styles_manager.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsManager.primaryDarkPurple,
      child: _buildBody(context: context),
    );
  }

  Widget _buildBody({required BuildContext context}) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ColorsManager.drawerColor, ColorsManager.primaryDarkPurple],
        ),
      ),
      child: ListView(
        children: [
          _drawLogo(),
          const SizedBox(
            height: 4,
          ),
          _listTileWidget(
              imgPath: AssetsManager.account,
              title: tr(StringsManager.account),
              onTap: () {
                Get.to(() => const ProfileScreen());
              }),
          _listTileWidget(
              imgPath: AssetsManager.info,
              title: tr(StringsManager.info),
              onTap: () {
                Get.to(() => AboutHelmy());
              }),
          _listTileWidget(
              imgPath: AssetsManager.share,
              title: tr(StringsManager.share),
              onTap: () {
                Share.share(
                    'https://play.google.com/store/apps/details?id=com.helmyapp.helmy');
              }),
          _listTileWidget(
              imgPath: AssetsManager.message,
              title: tr(StringsManager.message),
              onTap: () {
                Get.to(() => const ContactUs());
              }),
          _listTileWidget(
              imgPath: AssetsManager.termsCondition,
              title: tr(StringsManager.termsAndConditions),
              onTap: () {
                Get.to(() => const TermsAndConditionScreen());
              }),
          _listTileWidget(
              imgPath: AssetsManager.privacy,
              title: tr(StringsManager.privacy),
              onTap: () {
                Get.to(() => PrivacyPolicy());
              }),
          _listTileWidget(
              imgPath: NetworkConstants.token.isNotEmpty
                  ? AssetsManager.logout
                  : AssetsManager.loginIcon,
              title: NetworkConstants.token.isNotEmpty
                  ? tr(StringsManager.logout)
                  : tr(StringsManager.login),
              onTap: () async {
                print('logout and remvoe ');
                await getIt.get<CacheHelper>().removeToken();
                await getIt.get<CacheHelper>().removeIsInterpreter();
                Get.offAll(() => const LoginView());
              }),
        ],
      ),
    );
  }

  Widget _drawLogo() {
    return Container(
      width: 154.w,
      height: 90.h,
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                AssetsManager.helmy,
              ),
              fit: BoxFit.fill)),
    );
  }

  Widget _listTileWidget(
      {required String imgPath,
      required String title,
      required dynamic onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Image.asset(
        imgPath,
        width: 19.5.w,
        height: 21.5.h,
        fit: BoxFit.cover,
        color: ColorsManager.primaryLightPurple,
      ),
      title: Text(
        title,
        style: getRegularStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}
