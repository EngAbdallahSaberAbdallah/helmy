import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import 'about_app_buttons.dart';
import 'drawer_custom_button.dart';
import 'drawer_first_buttons.dart';
import 'drawer_with_logo.dart';
import 'on_store_buttons.dart';

class DrawerButtonsListView extends StatelessWidget {
  const DrawerButtonsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSize.s16, vertical: AppSize.s20),
        children: [
          const DrawerFirstButtons(),
          const SizedBox(
            height: AppSize.s20,
          ),
          Text(
            'عن تقنين',
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: AppSize.s24),
          ),
          const AboutAppButtons(),
          Text(
            'على المتجر',
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: AppSize.s24),
          ),
          const OnStoreButtons(),
          const SizedBox(
            height: AppSize.s20,
          ),
          Text(
            'نسخة التطبيق 1.0.0',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: AppSize.s13),
          ),
          const SizedBox(
            height: AppSize.s16,
          ),
          const DrawerWithLogo()
        ],
      ),
    );
  }
}
