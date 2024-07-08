import 'package:flutter/material.dart';

class BuildCountryFlag extends StatelessWidget {
  final String countryCode;

  const BuildCountryFlag({
    super.key,
    required this.countryCode,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      countryCode.toUpperCase().replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) =>
              String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397)),
    );
  }
}
