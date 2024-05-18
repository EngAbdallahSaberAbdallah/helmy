import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helmy_project/modules/home/widgets/build_circle_image.dart';
import 'package:helmy_project/resources/assets_manager.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import 'package:helmy_project/resources/strings_manager.dart';
import 'package:helmy_project/resources/styles_manager.dart';

class BuildAppBar extends StatelessWidget {
  final String imgAccountPath;
  final String iconPath;
  final dynamic onPressedIcon;
  const BuildAppBar({super.key, required this.imgAccountPath,required this.iconPath,
   required this.onPressedIcon});

  @override
  Widget build(BuildContext context) {
    return  Stack(
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
                onTap:  onPressedIcon,
                child: SizedBox(
                    height: 44,
                    width: 44,
                    child: CircleAvatar(
                        child: Image.asset(
                      iconPath,
                      fit: BoxFit.cover,
                    ))),
              ),
              Text(
                tr(StringsManager.homePage),
                style: getRegularStyle(
                    color: ColorsManager.buttonDarkColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
               BuildCircleImage(
                  imgPath: imgAccountPath, width: 44, height: 44),
            ],
          ),
        )
      ],
    );
  }
}