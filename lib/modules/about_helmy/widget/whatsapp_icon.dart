import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:helmy_project/app/constants.dart';
import 'package:helmy_project/app/functions.dart';

class WhatsAppIcon extends StatelessWidget {
  const WhatsAppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration:
              BoxDecoration(color: Colors.green[800], shape: BoxShape.circle),
          child: IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.whatsapp,
              color: Colors.white,
            ),
            onPressed: () => openWhatsApp(Constants.whatsAppNumber, context),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'اتصل بنا عبر واتساب',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
