import 'package:flutter/material.dart';

import '../../../resources/values_manager.dart';
import 'areas_selection_dropdown.dart';
import 'city_selection_dropdown.dart';

class CityAndAreaRow extends StatelessWidget {
  final String cityName;
  final String areaName;

  final TextEditingController countryIdController;

  const CityAndAreaRow(
      {super.key,
      this.cityName = "",
      this.areaName = "",
      required this.countryIdController});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CitySelection(
          countryName: cityName,
          countryIdController:countryIdController
        ),
      ],
    );
  }
}
