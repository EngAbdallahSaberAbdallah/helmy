import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'otp_view_body.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../resources/colors_manager.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../resources/values_manager.dart';
import '../cubits/pin_code_cubit/pin_code_cubit.dart';
import '../cubits/pin_code_cubit/pin_code_state.dart';

class PinCodeCustomWidget extends StatefulWidget {
  final TextEditingController controller;
  const PinCodeCustomWidget({
    super.key,
    required this.controller
  });

  @override
  State<PinCodeCustomWidget> createState() => _PinCodeCustomWidgetState();
}

class _PinCodeCustomWidgetState extends State<PinCodeCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PinCodeCubit, PinCodeState>(
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: PinCodeTextField(
            // Existing properties
            onChanged: (value) {
              BlocProvider.of<PinCodeCubit>(context).onPinCodeChanged(value);
            },
            onCompleted: (value) {
              BlocProvider.of<PinCodeCubit>(context).onPinCodeCompleted(value);
              widget.controller.text = value;
              setState(() {
                code = value;
              });
            },
            appContext: context,
            length: 6,
            // Existing properties
            pastedTextStyle: const TextStyle(
              color: ColorsManager.primaryDarkPurple,
              fontWeight: FontWeight.bold,
            ),
            obscureText: false,
            obscuringCharacter: '*',

            // backgroundColor: Colors.transparent,
            animationType: AnimationType.fade,
            validator: (v) {
              if (v!.length < 5) {
                return "*";
              } else {
                return null;
              }
            },
            pinTheme: PinTheme(
                // disabledColor: ColorsManager.trans,
                shape: PinCodeFieldShape.underline,
                fieldWidth: 40.w,
                inactiveColor: ColorsManager.primaryDarkPurple,
                activeColor: ColorsManager.primaryDarkPurple,
                selectedColor: ColorsManager.primaryDarkPurple,
                selectedFillColor: ColorsManager.primaryDarkPurple,
                inactiveFillColor: ColorsManager.trans,
                activeFillColor: ColorsManager.primaryDarkPurple),
            cursorColor: ColorsManager.primaryDarkPurple,
            animationDuration: const Duration(milliseconds: 300),
            textStyle: getBoldStyle(
                color: ColorsManager.primaryDarkPurple, fontSize: 28),
            enableActiveFill: false,
            autoDismissKeyboard: true,
            keyboardAppearance: Brightness.light,
            keyboardType: TextInputType.number,
              autoDisposeControllers : false,
          ),
        );
      },
    );
  }
}
