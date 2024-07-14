import 'package:flutter/material.dart';
import 'build_header_text.dart';

import '../../../app/components.dart';

class BuildHeaderWithOptionalData extends StatelessWidget {
  final String title;
  final String optionalTitle;
  final Color optionalTitleColor;
  const BuildHeaderWithOptionalData(
      {super.key,
      required this.title,
      required this.optionalTitle,
      required this.optionalTitleColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BuildHeaderText(text: title, fontSize: 16),
        OptionalText(
          text: optionalTitle,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          textColor: optionalTitleColor,
        ),
      ],
    );
  }
}
