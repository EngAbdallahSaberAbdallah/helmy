import 'package:flutter/material.dart';
import '../../../resources/styles_manager.dart';

import '../../../../app/components.dart';
import '../../../../resources/strings_manager.dart';
import '../../../resources/colors_manager.dart';

class RowWithOnTabText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final void Function()? onTab;
  final Color onTabTextColor;
  final Color firstTextColor;

  const RowWithOnTabText({
    super.key,
    required this.firstText ,
    required this.secondText ,
    this.onTab,
    this.onTabTextColor = ColorsManager.primaryDarkPurple,
    this.firstTextColor = ColorsManager.primaryTxtDarkGrey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: getRegularStyle(color: ColorsManager.borderGrey, fontSize: 14),
        ),
        const SizedBox(
          width: 5,
        ),
        OnTabText(
          textColor: onTabTextColor,
          text: secondText,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w700,
          onTab: onTab,
        ),
      ],
    );
  }
}
