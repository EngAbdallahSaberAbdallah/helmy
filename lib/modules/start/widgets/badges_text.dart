import 'package:flutter/material.dart';

import '../../../../resources/colors_manager.dart';

class BadgesText extends StatelessWidget {
  final String text;

  const BadgesText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: ColorsManager.primaryBgDark),
    );
  }
}