import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/components.dart';
import '../../../../app/functions.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/values_manager.dart';
import '../../../helpers/validation.dart';
import '../../../resources/colors_manager.dart';
import 'gender_drop_down_widget.dart';

class PhoneAndGenderRow extends StatelessWidget {
  final TextEditingController? phoneController;
  bool? isReadOnly;
  PhoneAndGenderRow({super.key, this.phoneController, this.isReadOnly = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MandatoryText(
                title: StringsManager.phoneNumber,
                bottomPadding: AppSize.s13,
                topPadding: AppSize.s31,
              ),
              CustomTextFormField(
                  hint: StringsManager.enterPhoneNumber,
                  heightOfTextFormField: 51,
                  controller: phoneController,
                  textInputType: TextInputType.phone,
                  sufixIconBackground: Theme.of(context).dividerColor,
                  borderColor: ColorsManager.borderGrey,
                  readOnly: isReadOnly!,
                  onChanged: (value) {},
                  formatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  validator: (value) {
                    if (phoneController?.text.length == 11) {
                      return ValidationHelper.validatePhone(context, value);
                    } else {
                      return tr('enter_phone_number_length');
                    }
                  }),
            ],
          ),
        ),
        SizedBox(
          width: calcWidth(AppSize.s20, context),
        ),
      ],
    );
  }
}
