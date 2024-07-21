import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/functions.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';


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
          height: calcHeight(45, context),
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
          height: calcHeight(28, context),
        ),
        Align(
          alignment: AlignmentDirectional.center,
          child: Text(
            StringsManager.createAccount,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: 24),
          ),
        ),
        SizedBox(
          height: calcHeight(40, context),
        ),
      ],
    );
  }
}
