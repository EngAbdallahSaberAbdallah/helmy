import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../helpers/validation.dart';
import '../../../resources/strings_manager.dart';

import 'register_name_column.dart';

class RegisterFillNameRow extends StatelessWidget {
  final TextEditingController? firstController;
  final TextEditingController? lastController;

  const RegisterFillNameRow({
    super.key,
    this.firstController,
    this.lastController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RegisterNameColumn(
          header: tr( StringsManager.firstName),
          hintText: tr(StringsManager.name),
          controller: firstController,
          validation: (value) =>
              ValidationHelper.validateFullName(context, value),
        ),

      ],
    );
  }
}
