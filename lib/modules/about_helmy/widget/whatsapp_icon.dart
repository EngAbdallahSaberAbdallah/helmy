import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:helmy_project/app/constants.dart';
import 'package:helmy_project/app/functions.dart';
import 'package:helmy_project/resources/strings_manager.dart';

class WhatsAppIcon extends StatelessWidget {
  const WhatsAppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            shape: BoxShape.rectangle,
            color: Colors.green[800],
          ),
          child: IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.whatsapp,
              color: Colors.white,
            ),
            onPressed: () => openWhatsApp(Constants.whatsAppNumber, context),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          tr(StringsManager.contactWithWhatsapp),
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
