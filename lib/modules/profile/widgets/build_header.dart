import 'package:flutter/material.dart';

import '../../../app/components.dart';

class BuildHeader extends StatelessWidget {
  final String name;
  final dynamic onTapIcon;
  final IconData iconData;
  const BuildHeader(
      {super.key,
      required this.name,
      required this.onTapIcon,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OptionalText(
            text: name,
            fontSize: 18,
            textColor: Colors.black,
            fontWeight: FontWeight.w700),
        const SizedBox(
          width: 4,
        ),
        IconButton(
          onPressed: onTapIcon,
          icon: Icon(
            iconData,
            color: Colors.black,
            size: 24,
          ),
        )
      ],
    );
  }
}
