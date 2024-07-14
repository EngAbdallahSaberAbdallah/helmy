import 'package:flutter/material.dart';

import '../../../app/components.dart';
import '../../../resources/colors_manager.dart';

class BuildRowTextFieldWithHeader extends StatelessWidget {
  final String header;
  final String hintText;
  final String descriptionTitle;
  final TextEditingController controller;
  final String? Function(String?)? validation;
  final TextInputType textInputType;
  const BuildRowTextFieldWithHeader(
      {super.key,
      required this.header,
      required this.hintText,
      required this.descriptionTitle,
      required this.controller,
      required this.validation,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            OptionalText(
              text: header,
              fontWeight: FontWeight.w400,
              textColor: Colors.black,
              fontSize: 16,
            ),
            const OptionalText(
              text: ' * ',
              fontWeight: FontWeight.w400,
              textColor: ColorsManager.primaryDarkPurple,
              fontSize: 16,
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: controller,
                maxLines: 1, // Adjust the number of lines as needed
                validator: validation, keyboardType: textInputType,
                toolbarOptions: ToolbarOptions(
                    copy: false, paste: false, cut: false, selectAll: false
                    //by default all are disabled 'false'
                    ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorsManager.borderGrey, width: 0.5)),
                  hintText: hintText,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            OptionalText(
              text: descriptionTitle,
              fontWeight: FontWeight.w700,
              textColor: Colors.black,
              fontSize: 16,
            ),
          ],
        ),
      ],
    );
  }
}
