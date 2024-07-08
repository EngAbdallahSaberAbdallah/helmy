import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helmy_project/modules/about_helmy/widget/layout.dart';
import 'package:helmy_project/modules/about_helmy/widget/whatsapp_icon.dart';
import 'package:helmy_project/resources/assets_manager.dart';
import 'package:helmy_project/resources/strings_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            WhatsAppIcon(),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () => _launchGmail(context),
              child: Column(
                children: [
                  SvgPicture.asset(
                    AssetsManager
                        .gmail, // Add your Gmail icon in the assets folder
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'اتصل بنا عبر Gmail',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
        appBarTitle: tr(StringsManager.message));
  }

  // Method to launch WhatsApp
  // void _launchWhatsApp(BuildContext context) async {
  //   const phoneNumber = "+1234567890"; // Replace with your phone number
  //   final whatsappUrl = "https://wa.me/$phoneNumber";
  //   if (await canLaunch(whatsappUrl)) {
  //     await launch(whatsappUrl);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('لا يمكن فتح واتساب')),
  //     );
  //   }
  // }

  // Method to launch Gmail
  void _launchGmail(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'helmyappeg@gmail.com', // Replace with your email
      queryParameters: {
        'subject': 'اتصل بنا',
      },
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا يمكن فتح Gmail')),
      );
    }
  }
}
