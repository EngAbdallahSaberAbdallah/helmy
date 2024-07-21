import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import '../widget/layout.dart';
import '../widget/whatsapp_icon.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WhatsAppIcon(),
            const SizedBox(height: 40),
            _buildGmail(context: context),
          ],
        ),
        appBarTitle: tr(StringsManager.message));
  }

  Widget _buildGmail({required BuildContext context}) {
    return GestureDetector(
      onTap: () => _launchGmail(context),
      child: Column(
        children: [
          SvgPicture.asset(
            AssetsManager.gmail, // Add your Gmail icon in the assets folder
            width: 60,
            height: 60,
          ),
          const SizedBox(height: 8),
          Text(
            tr(StringsManager.contactWithGmail),
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

// Method to launch Gmail
  void _launchGmail(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'helmyappeg@gmail.com', // Replace with your email
      query: encodeQueryParameters(<String, String>{
        'subject': 'اتصل بنا',
      }),
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا يمكن فتح Gmail')),
      );
    }
  }

// Helper method to encode query parameters
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
