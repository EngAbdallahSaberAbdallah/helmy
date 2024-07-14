import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../home/widgets/build_circle_image.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/colors_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/styles_manager.dart';

class BuildAppBar extends StatelessWidget {
  final String imgAccountPath;
  final String iconPath;
  final dynamic onPressedIcon;
  final String title;
  const BuildAppBar(
      {super.key,
      required this.imgAccountPath,
      required this.iconPath,
      required this.title,
      required this.onPressedIcon});

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
              EdgeInsets.only(left: 24.w, right: 24.w, top: 48.sp, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: onPressedIcon,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 31,
                ),
              ),
              Text(
                title,
                style: getRegularStyle(
                    color: ColorsManager.buttonDarkColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox()
            ],
          ),
        )
      ],
    );
  }
}
