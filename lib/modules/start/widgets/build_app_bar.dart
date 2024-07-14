import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:helmy_project/helpers/cache_helper.dart';
import 'package:helmy_project/helpers/services_locator.dart';
import 'package:helmy_project/modules/start/cubits/bottom_nav_bar_cubit.dart';
import '../../profile/views/profile.dart';
import '../../home/widgets/build_circle_image.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';

class BuildAppBar extends StatefulWidget {
  final String imgAccountPath;
  final String iconPath;
  final dynamic onPressedIcon;
  const BuildAppBar(
      {super.key,
      required this.imgAccountPath,
      required this.iconPath,
      required this.onPressedIcon});

  @override
  State<BuildAppBar> createState() => _BuildAppBarState();
}

class _BuildAppBarState extends State<BuildAppBar> {
  late String? image = '';

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    image = await getIt.get<CacheHelper>().getAvatar() ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (navContext, state) {
      BottomNavBarCubit navBarCubit = navContext.read<BottomNavBarCubit>();
      return Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 149.sp,
            child: Image.asset(AssetsManager.homePageImg, fit: BoxFit.fill),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 24, right: 24, top: 48.sp, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: widget.onPressedIcon,
                  child: SizedBox(
                      height: 44,
                      width: 44,
                      child: CircleAvatar(
                          child: Image.asset(
                        widget.iconPath,
                        fit: BoxFit.cover,
                      ))),
                ),
                Text(
                  navBarCubit
                      .titles[navBarCubit.bottomNavigationBarCurrentIndex],
                  style: getRegularStyle(
                      color: ColorsManager.buttonDarkColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                InkWell(
                  onTap: () => Get.to(() => const ProfileScreen()),
                  child: BuildCircleImage(
                      imgPath: image != '' ? image! : "",
                      width: 44,
                      height: 44),
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
