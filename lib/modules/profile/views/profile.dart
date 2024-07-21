import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../helpers/cache_helper.dart';
import '../../../helpers/services_locator.dart';
import '../../auth/blocs/auth_bloc/auth_bloc.dart';
import '../../auth/views/login_view.dart';
import 'edit_profile.dart';
import '../widgets/profile_layout.dart';
import '../../../resources/strings_manager.dart';
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
                Get.to(() => const EditProfileScreen());
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
                _deleteUserAccount();
              }),
        ],
      ),
    );
  }

  void _deleteUserAccount() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(tr(StringsManager.confirmDeleteAccount),style:
                     getRegularStyle(color: ColorsManager.primaryDarkPurple, fontWeight: FontWeight.bold, fontSize: 18),),
            content: Text(tr(StringsManager.areYouSureToDelete),style:
                     getRegularStyle(color: ColorsManager.primaryDarkPurple,fontWeight: FontWeight.w500),),
            actions: <Widget>[
              TextButton(
                child: Text(
                  tr(StringsManager.deleteAccount),
                  style:
                     getRegularStyle(color: ColorsManager.primaryDarkPurple, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(DeleteAccount(context: context));
                },
              ),
              TextButton(
                child: Text(
                  tr(StringsManager.no),
                  style: getRegularStyle(color: ColorsManager.primaryDarkPurple, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
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
