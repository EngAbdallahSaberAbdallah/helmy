import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../app/components.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';

class BuildLawyerBio extends StatelessWidget {
  final TextEditingController descriptionOfConsultationController;
  const BuildLawyerBio(
      {super.key, required this.descriptionOfConsultationController});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
              color: ColorsManager.secondaryCardsBg1,
              borderRadius: BorderRadius.circular(6)),
          child: Row(
            children: [
              _buildIconForHeaders(iconData: Icons.info_outline),
              const SizedBox(
                width: 10,
              ),
              OptionalText(
                  text: tr(StringsManager.aboutLawyer),
                  fontSize: 18,
                  textColor: Colors.black,
                  fontWeight: FontWeight.w400),
            ],
          )),
      const SizedBox(
        height: 10,
      ),
      TextFormField(
        controller: descriptionOfConsultationController,
        readOnly: true,
        maxLines: 5, // Adjust the number of lines as needed
        // validator: validation,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 13, color: Colors.black, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          hintText: tr(StringsManager.hintOfDescriptionOfJob),
        ),
      ),
    ]);
  }

  Widget _buildIconForHeaders({required IconData iconData}) {
    return Icon(iconData, color: Colors.black, size: 23);
  }
}
