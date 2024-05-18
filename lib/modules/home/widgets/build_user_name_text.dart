import 'package:flutter/material.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import 'package:helmy_project/resources/styles_manager.dart';

class BuildUserNameText extends StatelessWidget {
  final String userName;
  const BuildUserNameText({super.key,required this.userName});

  @override
  Widget build(BuildContext context) {
    return Text(
      userName,
      style: getRegularStyle(
          color: ColorsManager.primaryDarkPurple,
          fontWeight: FontWeight.w700,
          fontSize: 15),
    );
  }
}