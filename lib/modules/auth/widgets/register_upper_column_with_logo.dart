import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/functions.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';

class RegisterUpperColumnWithLogo extends StatelessWidget {
  const RegisterUpperColumnWithLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // var isDark = context.read<ThemeModeCubit>().state.isDark;
    return Column(
      children: [
        SizedBox(
          height: calcHeight(AppSize.s45, context),
        ),
        AspectRatio(
            aspectRatio: 3,
            child: SvgPicture.asset(
              // isDark
              //     ? AssetsManager.tqneenLogoWithoutTextLight
              //     :
              AssetsManager.helmyLogo,
            )),
        SizedBox(
          height: calcHeight(AppSize.s28, context),
        ),
        Align(
          alignment: AlignmentDirectional.center,
          child: Text(
            StringsManager.createAccount,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: AppSize.s24),
          ),
        ),
        SizedBox(
          height: calcHeight(AppSize.s40, context),
        ),
      ],
    );
  }
}
