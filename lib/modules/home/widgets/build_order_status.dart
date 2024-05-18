import 'package:flutter/material.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import 'package:helmy_project/resources/styles_manager.dart';

class BuildOrderStatus extends StatelessWidget {
  final String status;
  const BuildOrderStatus({super.key,required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: ColorsManager.secondaryBtnBg,
          borderRadius: BorderRadius.circular(3)),
      child: Text(
        status,
        style: getRegularStyle(
            color: ColorsManager.black,
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}