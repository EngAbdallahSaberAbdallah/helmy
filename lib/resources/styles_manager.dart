import 'package:flutter/material.dart';
import 'fonts_manager.dart';

TextStyle _getTextStyle(FontWeight fontWeight, double fontSize, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: FontConstance.fontFamily,
      fontWeight: fontWeight,
      height: 1.6,
      color: color);
}

/// Regular Style
TextStyle getRegularStyle(
    {double fontSize = 16, required Color color, FontWeight fontWeight = FontWeightManger.regular}) {
  return _getTextStyle(fontWeight, fontSize, color, );
}

/// Light Style
TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(FontWeightManger.light, fontSize, color);
}

/// SimiBold Style
TextStyle getExtraBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(FontWeightManger.extraBold, fontSize, color);
}

/// Bold Style
TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(FontWeightManger.bold, fontSize, color);
}