import 'package:flutter/material.dart';

import '../../../app/components.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/values_manager.dart';

class RegisterNameColumn extends StatelessWidget {
  final String header;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validation;

  const RegisterNameColumn({
    super.key,
    required this.header,
    required this.hintText,
    this.controller,
    this.validation,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CustomTextFormField(
            controller: controller, heightOfTextFormField: 51,
            // enable: true,
            textInputType: TextInputType.text,
            onChanged: (value) {},
            validator: validation,
            hint: hintText,
            sufixIconBackground: Theme.of(context).dividerColor,
            borderColor: ColorsManager.borderGrey,
          ),
        ],
      ),
    );
  }
}
