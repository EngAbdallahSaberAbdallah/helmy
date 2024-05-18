import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import 'web_view_page.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Get.to(() => const WebViewPage(
              url: "https://startupdefenders.com/terms-and-conditions.html"));
        },
        child: Center(
            child: Text(
          tr(StringsManager.termsConditions),
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 16,
              color: ColorsManager.primaryDarkPurple,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
              decorationColor: ColorsManager.primaryDarkPurple),
          overflow: TextOverflow.ellipsis,
        )));
  }
}
