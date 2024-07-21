import 'package:flutter/material.dart';

import '../../../../resources/colors_manager.dart';


class EnterSendCodeWithPhone extends StatelessWidget {
  final String text;
  final String mail;

  const EnterSendCodeWithPhone({
    super.key,
    required this.text,
    required this.mail,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontSize: 13),
          text: '$text \n',
          children: [
            TextSpan(
                text:mail,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 16,
                    color: ColorsManager.primaryDarkPurple)),
          ]),
    );
  }
}
