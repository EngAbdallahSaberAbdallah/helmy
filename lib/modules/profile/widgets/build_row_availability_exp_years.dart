import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:helmy_project/modules/auth/models/auth_response.dart';

import '../../../app/components.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';

class BuildAvailabilityAndExpYears extends StatelessWidget {
  final User user;
  const BuildAvailabilityAndExpYears({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        // _buildColumnForAEL(
        //   fColor: user.status == "active"
        //       ? ColorsManager.primaryDarkPurple
        //       : Colors.black,
        //   lColor: Colors.black,
        //   hasIcon: true,
        //   iconData: user.status == "active"
        //       ? Icons.done
        //       : user.status == "not active"
        //           ? Icons.close
        //           : Icons.call,
        //   title: user.status == "active"
        //       ? tr(StringsManager.available)
        //       : user.status == "not active"
        //           ? tr(StringsManager.unAvailable)
        //           : tr(StringsManager.inConversation),
        //   subTitle: tr(StringsManager.lawyerStatus),
        // ),
        Container(
          color: Colors.black,
          height: 51,
          width: 1,
        ),
        _buildColumnForAEL(
            fColor: ColorsManager.primaryDarkPurple,
            lColor: Colors.black,
            hasIcon: false,
            iconData: Icons.done,
            title: '${user} ${tr(StringsManager.years)}',
            subTitle: tr(StringsManager.experienceYears)),
      ],
    );
  }

  Widget _buildColumnForAEL(
      {required Color fColor,
      required Color lColor,
      required bool hasIcon,
      required String title,
      required IconData iconData,
      required String subTitle}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            hasIcon
                ? _buildIconInsideContainer(color: fColor, iconData: iconData)
                : const SizedBox(),
            const SizedBox(
              width: 2,
            ),
            OptionalText(
                text: title,
                fontSize: 16,
                textColor: hasIcon ? fColor : lColor,
                fontWeight: FontWeight.w700),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        OptionalText(
            text: subTitle,
            fontSize: 16,
            textColor: Colors.black,
            fontWeight: FontWeight.w400)
      ],
    );
  }

  Widget _buildIconInsideContainer(
      {required IconData iconData, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1.5, color: color),
      ),
      child: Icon(
        iconData,
        color: color,
        size: 12,
      ),
    );
  }
}
