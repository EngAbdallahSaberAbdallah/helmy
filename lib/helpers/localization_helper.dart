import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationHelper {
  /// get the text direction either LTR or RTL
  static TextDirection getDirection(BuildContext context) =>
      context.deviceLocale.languageCode == 'en'
          ? TextDirection.LTR
          : TextDirection.RTL;

  static Future<void> changeLanguage(BuildContext context) => context
      .setLocale(Locale(context.locale.languageCode == 'en' ? 'ar' : 'en'));

  /// get the text direction either LTR or RTL
  static String getLanguageCode(BuildContext context) =>
      context.deviceLocale.languageCode;
}