import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../modules/start/cubits/bottom_nav_bar_cubit.dart';
import 'functions.dart';
import '../modules/auth/views/registration.dart';
import '../resources/assets_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:io';

import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';

import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// PUll to refresh screen
class PullToFetchDataScreen extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const PullToFetchDataScreen(
      {super.key, required this.onRefresh, required this.child});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: ColorsManager.primaryDarkPurple,
        onRefresh: onRefresh,
        child: child);
  }
}

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(14))),
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Center(
            child: Container(
              width: 50.w,
              height: 5,
              decoration: BoxDecoration(
                  color: ColorsManager.primaryLightPurple,
                  borderRadius: BorderRadius.circular(12.r)),
            ),
          ),
          const SizedBox(height: 4),
          InkWell(
              onTap: () => _getImage(ImageSource.camera)
                  .then((img) => Navigator.of(context).pop(img)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 24, vertical: 16),
                  child: ImagePickerItem(
                      label: tr('camera'), iconPath: AssetsManager.camera),
                ),
              )),
          const Divider(thickness: 1, height: 0),
          InkWell(
              onTap: () => _getImage(ImageSource.gallery)
                  .then((img) => Navigator.of(context).pop(img)),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 24, vertical: 16),
                    child: ImagePickerItem(
                        label: tr(StringsManager.gallery),
                        iconPath: AssetsManager.gallery),
                  ))),
          const SizedBox(height: 16),
        ],
      ),
      onClosing: () {},
    );
  }

  Future<File?> _getImage(ImageSource source) async {
    final selectedImage = await ImagePicker().pickImage(
        source: source, imageQuality: 20, requestFullMetadata: false);
    if (selectedImage != null) {
      File rotatedImage =
          await FlutterExifRotation.rotateImage(path: selectedImage.path);
      return File(rotatedImage.path);
    }
    // final croppedImage = await ImageCropper().cropImage(
    //     sourcePath: selectedImage.path,
    //     aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
    //
    // if (croppedImage != null) {
    //   return File(croppedImage.path);

    return null;
  }
}

class ImagePickerItem extends StatelessWidget {
  const ImagePickerItem({Key? key, required this.label, required this.iconPath})
      : super(key: key);
  final String label;
  final String iconPath;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: ColorsManager.primaryLightPurple,
          child: Image.asset(iconPath, width: 20),
        ),
        const SizedBox(width: 24),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        )
      ],
    );
  }
}

class BuildDivider extends StatelessWidget {
  final double height;
  const BuildDivider({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: height,
      color: Colors.black,
    );
  }
}

// status bar color & status bar icon brightness
class StatusBarChangedWidget extends StatelessWidget {
  final Widget widget;
  final Color statusBarColor;
  final Brightness statusBarBrightness;

  const StatusBarChangedWidget(
      {super.key,
      required this.widget,
      this.statusBarColor = Colors.transparent,
      this.statusBarBrightness = Brightness.light});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: statusBarColor,
          statusBarIconBrightness: statusBarBrightness),
      child: widget,
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String btnName;
  final dynamic onPressed;
  final Color btnNameColor;
  final Color btnBackgroundColor;

  const CustomElevatedButton(
      {super.key,
      required this.btnName,
      required this.onPressed,
      required this.btnBackgroundColor,
      required this.btnNameColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: btnBackgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      onPressed: onPressed,
      child: Text(
        btnName,
        style: getRegularStyle(
            color: btnNameColor, fontWeight: FontWeight.w700, fontSize: 17),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46.h,
      child:
          // Center(child: Loading(color: AppColors.secondaryColor,))
          Center(
        child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,
          colors: const [
            ColorsManager.primaryDarkPurple,
            Colors.black,
            ColorsManager.primaryLightPurple,
            ColorsManager.cardColor
          ],
          strokeWidth: 2.w,
        ),
      ),
    );
  }
}

class CustomClosedButton extends StatelessWidget {
  const CustomClosedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.back(),
      child: Container(
        width: 26,
        height: 26,
        padding: const EdgeInsets.all(2.5),
        decoration: const BoxDecoration(
          color: ColorsManager.primaryDarkPurple,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.close,
          color: Colors.white,
          size: 19.h,
        ),
      ),
    );
  }
}

// build app bar
defaultAppBar({
  required String appBarTitle,
  required bool hasBackBtn,
}) {
  return AppBar(
    backgroundColor: ColorsManager.primaryDarkPurple,
    title: Text(
      appBarTitle,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    leading: hasBackBtn
        ? IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ))
        : const SizedBox.shrink(),
    flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.teal,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Container()),
  );
}

// TextFormField
class CustomTextAreaFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final bool obscureText;
  final TextInputType? textInputType;
  final String? hint;
  final String? errorText;
  final Widget? suffixIcon;
  final bool readOnly;
  // final bool enable;
  final FocusNode? focusNode;
  final int maxLines;
  final bool searchBorder;
  final Widget? suffix;
  final bool? filled;
  final List<TextInputFormatter>? formatter;
  final sufixIconBackground;
  final borderColor;
  final double heightOfTextFormField;
  final bool autofocus;

  const CustomTextAreaFormField(
      {Key? key,
      required this.controller,
      this.validator,
      this.obscureText = false,
      this.textInputType,
      this.suffixIcon,
      required this.hint,
      this.readOnly = false,
      required this.onChanged,
      this.focusNode,
      this.maxLines = 1000,
      this.errorText,
      this.searchBorder = false,
      this.suffix,
      this.filled = false,
      this.autofocus = false,
      this.formatter,
      required this.sufixIconBackground,
      required this.borderColor,
      required this.heightOfTextFormField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      focusNode: focusNode,
      onChanged: onChanged,
      maxLines: maxLines,
      buildCounter: (context,
              {required currentLength, required isFocused, maxLength}) =>
          null,
      cursorColor: ColorsManager.primaryDarkPurple,
      validator: validator,
      controller: controller,
      // enabled: enable,
      keyboardType: textInputType,
      obscureText: obscureText,
      readOnly: readOnly,
      inputFormatters: formatter,
      style: getRegularStyle(
        color: ColorsManager.primaryDarkPurple,
        fontSize: 16,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorsManager.primaryDarkPurple,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: ColorsManager.trans,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
          suffix: suffix ?? null,
          errorText: errorText,
          hintText: hint,
          hintStyle: getRegularStyle(
            color: ColorsManager.borderGrey,
            fontSize: 16,
          ),
          suffixIcon: searchBorder
              ? GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: heightOfTextFormField,
                    width: 58,
                    margin: const EdgeInsets.symmetric(
                        vertical: 0.6, horizontal: 0.5),
                    decoration: const BoxDecoration(
                        // border: Border.all(color: borderColor,width: 0.5),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6))),
                    child: suffixIcon,
                  ),
                )
              : suffixIcon),
    );
  }
}

// TextFormField
class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final bool obscureText;
  final TextInputType? textInputType;
  final String? hint;
  final String? errorText;
  final Widget? suffixIcon;
  final bool readOnly;
  // final bool enable;
  final FocusNode? focusNode;
  final int maxLines;
  final bool searchBorder;
  final Widget? suffix;
  final bool? filled;
  final List<TextInputFormatter>? formatter;
  final sufixIconBackground;
  final borderColor;
  final double heightOfTextFormField;
  final bool autofocus;

  const CustomTextFormField(
      {Key? key,
      required this.controller,
      this.validator,
      this.obscureText = false,
      this.textInputType,
      this.suffixIcon,
      required this.hint,
      this.readOnly = false,
      required this.onChanged,
      this.focusNode,
      this.maxLines = 1000,
      this.errorText,
      this.searchBorder = false,
      this.suffix,
      this.filled = false,
      this.autofocus = false,
      this.formatter,
      required this.sufixIconBackground,
      required this.borderColor,
      required this.heightOfTextFormField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      focusNode: focusNode,
      onChanged: onChanged,
      maxLength: maxLines,
      buildCounter: (context,
              {required currentLength, required isFocused, maxLength}) =>
          null,
      cursorColor: ColorsManager.primaryDarkPurple,
      validator: validator,
      controller: controller,
      // enabled: enable,
      keyboardType: textInputType,
      obscureText: obscureText,
      readOnly: readOnly,
      inputFormatters: formatter,
      style: getRegularStyle(
        color: ColorsManager.primaryDarkPurple,
        fontSize: 16,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorsManager.primaryDarkPurple,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: ColorsManager.trans,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
          suffix: suffix ?? null,
          errorText: errorText,
          hintText: hint,
          hintStyle: getRegularStyle(
            color: ColorsManager.borderGrey,
            fontSize: 16,
          ),
          suffixIcon: searchBorder
              ? GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: heightOfTextFormField,
                    width: 58,
                    margin: const EdgeInsets.symmetric(
                        vertical: 0.6, horizontal: 0.5),
                    decoration: const BoxDecoration(
                        // border: Border.all(color: borderColor,width: 0.5),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6))),
                    child: suffixIcon,
                  ),
                )
              : suffixIcon),
    );
  }
}

// secure TextFormField
class CustomSecureTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final bool obscureText;
  final TextInputType? textInputType;
  final String? hint;
  final String? errorText;
  final Widget? suffixIcon;
  final bool readOnly;
  final bool enable;
  final double? height;
  final FocusNode? focusNode;

  const CustomSecureTextFormField({
    Key? key,
    this.height,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.textInputType,
    this.suffixIcon,
    required this.hint,
    this.readOnly = false,
    this.enable = true,
    this.onChanged,
    this.focusNode,
    this.errorText,
  }) : super(key: key);

  @override
  State<CustomSecureTextFormField> createState() =>
      _CustomSecureTextFormFieldState();
}

class _CustomSecureTextFormFieldState extends State<CustomSecureTextFormField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.start,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      cursorColor: Theme.of(context).primaryColorLight,
      validator: widget.validator,
      controller: widget.controller,
      enabled: widget.enable,
      keyboardType: widget.textInputType,
      obscureText: !showPassword,
      style: getRegularStyle(
        color: ColorsManager.primaryDarkPurple,
        fontSize: 16,
      ),
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
              color: ColorsManager.primaryDarkPurple, width: 0.7),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorsManager.primaryDarkPurple,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorsManager.primaryDarkPurple,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: ColorsManager.trans,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        errorText: widget.errorText,
        hintText: widget.hint,
        hintStyle: getRegularStyle(
          color: ColorsManager.borderGrey,
          fontSize: 16,
        ),
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          splashRadius: 15,
          iconSize: 20,
          onPressed: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
          icon: Icon(
            showPassword == false
                ? Icons.remove_red_eye_outlined
                : Icons.remove_red_eye,
            color: ColorsManager.primaryDarkPurple,
          ),
        ),
      ),
    );
  }
}

// onTap text
class OnTabText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color textColor;
  final void Function()? onTab;
  final FontWeight fontWeight;

  const OnTabText({
    super.key,
    required this.text,
    required this.textAlign,
    this.textColor = ColorsManager.primaryDarkPurple,
    this.onTab,
    this.fontWeight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: getRegularStyle(color: ColorsManager.primaryDarkPurple).copyWith(
          fontSize: 14,
          // color: textColor,
          fontWeight: fontWeight,
          shadows: [Shadow(color: textColor, offset: Offset(0, -5))],
          color: Colors.transparent,
          decoration: TextDecoration.underline,
          decorationColor: textColor,
        ),
      ),
    );
  }
}

/// Reusable button with icon and without with primary color
class DefaultPrimaryButtonWithIcon extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color color;
  final Color textColor;
  final Color iconColor;
  final IconData icon;

  const DefaultPrimaryButtonWithIcon({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w700,
    required this.color,
    required this.textColor,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: color,
        disabledColor: ColorsManager.borderGrey,
        height: calcHeight(48, context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // maxLines: 2,
              // overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              buttonText,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: fontWeight,
                    color: textColor,
                    fontSize: fontSize,
                  ),
            ),
            const SizedBox(
              width: 9.5,
            ),
            Icon(
              icon,
              color: iconColor,
              size: 29,
            )
          ],
        ));
  }
}

class LoginFirst extends StatelessWidget {
  const LoginFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (navContext, state) {
      BottomNavBarCubit navBarCubit = navContext.read<BottomNavBarCubit>();
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            tr(StringsManager.youMustLoginFirst),
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: ColorsManager.primaryDarkPurple,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 20,
          ),
          DefaultPrimaryButton(
            textColor: Theme.of(context).primaryColorDark,
            buttonText: tr(StringsManager.registerNow),
            onPressed: () {
              navBarCubit.bottomNavigationBarCurrentIndex = 0;
              Get.offAll(() => const Registration());
            },
            showArrow: false,
            color: ColorsManager.primaryDarkPurple,
          )
        ],
      );
    });
  }
}

/// Reusable button with arrow and without with primary color
class DefaultPrimaryButton extends StatelessWidget {
  final String buttonText;
  final bool showArrow;
  final void Function()? onPressed;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color color;
  final Color textColor;
  final Color iconColor;

  const DefaultPrimaryButton({
    super.key,
    required this.buttonText,
    this.showArrow = true,
    required this.onPressed,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w700,
    required this.color,
    required this.textColor,
    this.iconColor = ColorsManager.white,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: color,
        disabledColor: ColorsManager.borderGrey,
        height: calcHeight(48, context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showArrow
                ? Icon(
                    Icons.arrow_back,
                    color: iconColor,
                    size: 20,
                  )
                : const SizedBox(),
            showArrow
                ? SizedBox(
                    width: 5.w,
                  )
                : const SizedBox(),
            Flexible(
                child: AutoSizeText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              buttonText,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: fontWeight,
                    color: textColor,
                    fontSize: fontSize,
                  ),
              maxFontSize: 12,
              minFontSize: 12,
              presetFontSizes: showArrow
                  ? [
                      14,
                      13,
                      12,
                      10,
                    ]
                  : const [
                      18,
                      16,
                      14,
                      12,
                      10,
                    ],
            )),
          ],
        ));
  }
}

// Widget Text
class OptionalText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  const OptionalText(
      {super.key,
      required this.text,
      required this.textColor,
      required this.fontSize,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: fontSize, color: textColor, fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class OptionalTextWithHint extends StatelessWidget {
  final String title;
  final double bottomPadding;
  final double topPadding;

  const OptionalTextWithHint({
    super.key,
    required this.title,
    this.bottomPadding = 16,
    this.topPadding = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: RichText(
        text: TextSpan(
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 16),
            text: '$title \t',
            children: [
              TextSpan(
                  text: tr(StringsManager.optional),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 13, color: ColorsManager.primaryTxt1LightGrey)),
            ]),
      ),
    );
  }
}

class CenterEmptyHelm extends StatelessWidget {
  final String title;
  const CenterEmptyHelm({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AssetsManager.sky,
            height: 200.h,
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: ColorsManager.primaryDarkPurple,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class MandatoryText extends StatelessWidget {
  final String title;
  final double bottomPadding;
  final double topPadding;

  const MandatoryText({
    super.key,
    required this.title,
    this.bottomPadding = 16,
    this.topPadding = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: RichText(
        text: TextSpan(
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 16),
            text: '$title \t',
            children: [
              TextSpan(
                  text: '*',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 16, color: Theme.of(context).focusColor)),
            ]),
      ),
    );
  }
}

class CustomDropdownButtonFormFiled extends StatelessWidget {
  final String? value;
  final String hintText;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final GlobalKey<FormFieldState<String>> dropDownKey;

  const CustomDropdownButtonFormFiled(
      {super.key,
      this.value,
      this.items,
      required this.hintText,
      this.onChanged,
      this.validator,
      required this.dropDownKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: DropdownButtonFormField2<String>(
          key: dropDownKey,
          validator: validator,
          isExpanded: true,
          hint: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(hintText,
                textAlign: TextAlign.start,
                style: getRegularStyle(
                  color: ColorsManager.borderGrey,
                  fontSize: 16,
                )),
          ),
          iconStyleData: const IconStyleData(
              icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorsManager.primaryDarkPurple,
          )),
          dropdownStyleData: DropdownStyleData(
            maxHeight: calcHeight(172, context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color:
                  // isDark ? ColorsManager.secondaryBgDark :
                  ColorsManager.primaryOffWhite,
            ),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
          decoration: InputDecoration(
            suffixIconColor: ColorsManager.borderGrey,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                  color: ColorsManager.primaryDarkPurple, width: 0.7),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.primaryDarkPurple,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(
              color: ColorsManager.trans,
            )),
            contentPadding: EdgeInsets.only(left: 12, top: 12, bottom: 12),
          ),
          value: value,
          onChanged: onChanged,
          items: items,
        ),
      ),
    );
  }
}

class CustomCircleProgressIndicator extends StatelessWidget {
  const CustomCircleProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: calcHeight(50, context), child: const Center(child: Loading()));
  }
}

class AuthTextFiledLabelText extends StatelessWidget {
  final String text;

  const AuthTextFiledLabelText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16),
    );
  }
}

class CustomBackIcon extends StatelessWidget {
  const CustomBackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      width: 46.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(
            AssetsManager.back,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final dynamic onTapBackBtn;
  final String title;
  final Widget widget;
  const CustomAppBar(
      {super.key,
      required this.onTapBackBtn,
      required this.title,
      required this.widget});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 149.sp,
          child: Image.asset(AssetsManager.homePageImg, fit: BoxFit.fill),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24, right: 24, top: 48.sp, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(onTap: onTapBackBtn, child: const CustomBackIcon()),
              Text(
                title,
                style: getRegularStyle(
                    color: ColorsManager.buttonDarkColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              widget
            ],
          ),
        )
      ],
    );
  }
}
