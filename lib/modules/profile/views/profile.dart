import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helmy_project/helpers/cache_helper.dart';
import 'package:helmy_project/helpers/services_locator.dart';
import 'package:helmy_project/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:helmy_project/modules/auth/views/login_view.dart';
import 'package:helmy_project/modules/profile/cubit/profile_cubit.dart';
import 'package:helmy_project/modules/profile/views/edit_profile.dart';
import 'package:helmy_project/modules/profile/widgets/profile_layout.dart';
import 'package:helmy_project/network/network_constants.dart';
import 'package:helmy_project/resources/routes_manager.dart';
import 'package:helmy_project/resources/strings_manager.dart';
import '../../../app/components.dart';
import '../../auth/widgets/build_header_image.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/styles_manager.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ProfileLayout(
      child: Column(
        children: [
          _buildCard(
              title: tr(StringsManager.editProfile),
              icon: Icons.edit_rounded,
              cardBackgroundColor: ColorsManager.buttonDarkColor,
              titleColor: ColorsManager.white,
              hasArrow: true,
              onPressed: () {
                Get.to(() => EditProfileScreen());
              }),
          _buildCard(
              title: tr(StringsManager.logout),
              icon: Icons.logout_rounded,
              cardBackgroundColor: ColorsManager.buttonDarkColor,
              titleColor: ColorsManager.white,
              hasArrow: false,
              onPressed: () async {
                await getIt.get<CacheHelper>().removeToken();
                await getIt.get<CacheHelper>().removeIsInterpreter();
                Get.offAll(() => const LoginView());
              }),
          _buildCard(
              title: tr(StringsManager.deleteAccount),
              icon: Icons.delete_rounded,
              cardBackgroundColor: ColorsManager.white,
              titleColor: ColorsManager.red,
              hasArrow: false,
              onPressed: () {
                context.read<AuthBloc>().add(DeleteAccount(context: context));
              }),
        ],
      ),
    );
  }

  Widget _buildCard(
      {required String title,
      required IconData icon,
      required Color cardBackgroundColor,
      required Color titleColor,
      required bool hasArrow,
      required dynamic onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 48.h,
        margin: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 24.w),
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
        decoration: BoxDecoration(
            color: cardBackgroundColor,
            borderRadius: BorderRadius.circular(10.sp),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10.sp,
                  offset: const Offset(0, 5),
                  spreadRadius: 0.5)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: titleColor, size: 22.sp),
                SizedBox(width: 10.sp),
                Text(title,
                    style: getRegularStyle(
                      color: titleColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ))
              ],
            ),
            if (hasArrow)
              Icon(Icons.arrow_forward_ios,
                  color: ColorsManager.white, size: 20.sp)
          ],
        ),
      ),
    );
  }
}
