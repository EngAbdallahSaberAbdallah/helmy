import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:helmy_project/helpers/cache_helper.dart';
import 'package:helmy_project/helpers/services_locator.dart';
import 'package:helmy_project/modules/about_helmy/about_helmy.dart';
import 'package:helmy_project/modules/auth/views/login_view.dart';
import 'package:helmy_project/modules/auth/views/registration.dart';
import 'package:helmy_project/resources/assets_manager.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import 'package:helmy_project/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:helmy_project/resources/styles_manager.dart';

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
               
              }),
          _listTileWidget(
              imgPath: AssetsManager.info,
              title: tr(StringsManager.info),
              onTap: () {
                 Get.to(()=> AboutHelmy());
              }),
          _listTileWidget(
              imgPath: AssetsManager.share,
              title: tr(StringsManager.share),
              onTap: () {}),
          _listTileWidget(
              imgPath: AssetsManager.message,
              title: tr(StringsManager.message),
              onTap: () {}),
          _listTileWidget(
              imgPath: AssetsManager.termsCondition,
              title: tr(StringsManager.termsAndConditions),
              onTap: () {}),
          _listTileWidget(
              imgPath: AssetsManager.privacy,
              title: tr(StringsManager.privacy),
              onTap: () {}),
          _listTileWidget(
              imgPath: AssetsManager.logout,
              title: tr(StringsManager.logout),
              onTap: () async{
                print('logout and remvoe ');
                 await getIt.get<CacheHelper>().removeToken();
                 await getIt.get<CacheHelper>().removeIsInterpreter();
                 Get.offAll(()=> const LoginView());
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
      ),
      title: Text(
        title,
        style: getRegularStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}
