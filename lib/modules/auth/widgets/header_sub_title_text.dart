import 'package:flutter/material.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import 'package:helmy_project/resources/styles_manager.dart';

class HeaderSubTitleText extends StatelessWidget {
  final String header;
  final String subTitle;
  const HeaderSubTitleText({super.key,required this.header, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: getRegularStyle(
              color: ColorsManager.black,
              fontSize: 25,
              fontWeight: FontWeight.w700),
          textAlign: TextAlign.justify,
        ),
        Text(
         subTitle,
          style: getRegularStyle(
              color: ColorsManager.black,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
