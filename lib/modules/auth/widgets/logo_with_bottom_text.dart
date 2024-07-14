import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/functions.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/values_manager.dart';

class LogoWithBottomText extends StatelessWidget {
  final String title;

  const LogoWithBottomText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
            aspectRatio: 3,
            child: SvgPicture.asset(
              AssetsManager.helmyLogo,
            )),
        SizedBox(
          height: calcHeight(AppSize.s28, context),
        ),
        Align(
          alignment: AlignmentDirectional.center,
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: AppSize.s24),
          ),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.08,
        ),
      ],
    );
  }
}
