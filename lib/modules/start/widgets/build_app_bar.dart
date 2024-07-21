import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../helpers/cache_helper.dart';
import '../../../helpers/services_locator.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../profile/views/profile.dart';
import '../../home/widgets/build_circle_image.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/styles_manager.dart';

class BuildAppBar extends StatefulWidget {
  final String imgAccountPath;
  final String iconPath;
  final dynamic onPressedIcon;
  final String title;
  const BuildAppBar(
      {super.key,
      required this.imgAccountPath,
      required this.iconPath,
      required this.onPressedIcon, 
      required this.title});

  @override
  State<BuildAppBar> createState() => _BuildAppBarState();
}

class _BuildAppBarState extends State<BuildAppBar> {
  // late String? image = '';

  final ProfileController profileController = Get.find();

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
   final image = await getIt.get<CacheHelper>().getAvatar() ?? "";
   profileController.updateProfileImage(image: image);
       setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                  widget.title,
                  
                  style: getRegularStyle(
                      color: ColorsManager.buttonDarkColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                Obx(() => InkWell(
                      onTap: () => Get.to(() => const ProfileScreen()),
                      child: BuildCircleImage(
                          imgPath: profileController.profileImage.value != ''
                              ? profileController.profileImage.value
                              : "",
                          width: 44,
                          height: 44),
                    )),
              ],
            ),
          )
        ],
      );
   
  }
}
