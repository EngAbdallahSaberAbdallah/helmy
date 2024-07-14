import 'package:flutter/material.dart';

import '../../../app/components.dart';

class BuildHeaderText extends StatelessWidget {
  final String text;
  final double fontSize;
  const BuildHeaderText(
      {super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return OptionalText(
        text: text,
        textColor: Colors.black,
        fontSize: fontSize,
        fontWeight: FontWeight.w400);
  }
}
