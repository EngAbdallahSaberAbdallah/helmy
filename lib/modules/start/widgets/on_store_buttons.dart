import 'package:flutter/material.dart';

import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import 'drawer_custom_button.dart';

class OnStoreButtons extends StatelessWidget {
  const OnStoreButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: AppSize.s20,
        ),
        DrawerCustomButton(
            title: StringsManager.shareApp,
            onTap: () {},
            icon: Icons.share_outlined),
        const SizedBox(
          height: AppSize.s10,
        ),
        DrawerCustomButton(
            title: StringsManager.rateApp,
            onTap: () {},
            icon: Icons.star_border),
        const SizedBox(
          height: AppSize.s32,
        ),
      ],
    );
  }
}