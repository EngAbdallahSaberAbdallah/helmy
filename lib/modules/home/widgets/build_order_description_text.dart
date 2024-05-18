import 'package:flutter/material.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import 'package:helmy_project/resources/styles_manager.dart';

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