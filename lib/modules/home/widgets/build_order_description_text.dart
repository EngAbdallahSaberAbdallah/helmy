import 'package:flutter/material.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/styles_manager.dart';

class BuildOrderDescriptionText extends StatelessWidget {
  final String description;
  const BuildOrderDescriptionText({super.key,required this.description});

  @override
  Widget build(BuildContext context) {
    return  Text(
      description,
      style: getRegularStyle(
          color: ColorsManager.primaryDarkPurple,
          fontWeight: FontWeight.w400,
          fontSize: 15),
    );
  }
}