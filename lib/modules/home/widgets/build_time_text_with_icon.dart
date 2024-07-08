import 'package:flutter/material.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/styles_manager.dart';

class BuildTimeTextWithIcon extends StatelessWidget {
  final String time;
  const BuildTimeTextWithIcon({super.key,required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AssetsManager.time,
          width: 18,
          height: 18,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 2.5,
        ),
        Text(
          time,
          // textDirection: TextDirection.ltr,
          style: getRegularStyle(
              color: ColorsManager.greyText,
              fontSize: 12,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}