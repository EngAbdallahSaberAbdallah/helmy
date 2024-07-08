import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'values_manager.dart';
import 'colors_manager.dart';
import 'fonts_manager.dart';
import 'styles_manager.dart';

ThemeData darkApplicationTheme() {
  return ThemeData(
      scaffoldBackgroundColor: ColorsManager.primaryDark100,
      primaryColorLight: ColorsManager.primaryOffWhite,
      primaryColorDark: ColorsManager.primaryDark,
      cardColor: ColorsManager.primaryOffWhite,
      unselectedWidgetColor: ColorsManager.trans,
      indicatorColor: ColorsManager.trans,
      secondaryHeaderColor: ColorsManager.primaryDark60,
      dividerColor: ColorsManager.primaryDark40,
      primaryColor: ColorsManager.primaryDarkPurple,
      dialogBackgroundColor: ColorsManager.primaryDark60,
      disabledColor: ColorsManager.primaryDark80,
      shadowColor: ColorsManager.primaryOffWhite50,
      focusColor: ColorsManager.primaryDarkPurple,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: ColorsManager.primaryDark80,
              statusBarIconBrightness: Brightness.light),
          color: ColorsManager.primaryDark80,
          elevation: 0.0,
          centerTitle: true,
          titleTextStyle: getBoldStyle(
              color: ColorsManager.primaryOffWhite, fontSize: FontSize.s18)),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: ColorsManager.primaryDark80),
      textTheme: TextTheme(
        /// al head text f login,register,complete form ...etc
        displayLarge: getExtraBoldStyle(
            //offWhite light
            color: ColorsManager.primaryOffWhite,
            fontSize: FontSize.s18),
        headlineLarge: getExtraBoldStyle(
            color: ColorsManager.primaryOffWhite, fontSize: FontSize.s22),
        headlineSmall: getRegularStyle(
            color: ColorsManager.primaryOffWhite, fontSize: FontSize.s13),
        titleLarge: getExtraBoldStyle(
            color: ColorsManager.primaryOffWhite, fontSize: FontSize.s16),
        titleMedium: getRegularStyle(
            color: ColorsManager.primaryOffWhite, fontSize: FontSize.s18),
        titleSmall: getRegularStyle(
            color: ColorsManager.primaryDarkPurple, fontSize: FontSize.s13),
        bodyLarge: getBoldStyle(
            color: ColorsManager.primaryOffWhite, fontSize: FontSize.s18),
        displayMedium: getBoldStyle(
            color: ColorsManager.primaryOffWhite, fontSize: FontSize.s16),
        bodyMedium: getBoldStyle(
            color: ColorsManager.primaryDark80, fontSize: FontSize.s18),
        bodySmall: getRegularStyle(
            color: ColorsManager.primaryDark40, fontSize: AppSize.s10),
      ),
      buttonTheme:
          const ButtonThemeData(buttonColor: ColorsManager.primaryDarkPurple),
      dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.only(
                  right: 0,
                  left: AppSize.s12,
                  top: AppSize.s12,
                  bottom: AppSize.s12),
              hintStyle: getLightStyle(
                color: ColorsManager.primaryTxt1LightGrey,
                fontSize: AppSize.s13,
              ))),

      //input decoration theme(text form field)
      inputDecorationTheme: InputDecorationTheme(
          errorMaxLines: 3,
          errorStyle: getRegularStyle(
              color: ColorsManager.error, fontSize: AppSize.s10.sp),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSize.s16, vertical: AppSize.s15),
          hintStyle: getRegularStyle(
            color: ColorsManager.primaryTxt1LightGrey,
            fontSize: FontSize.s14,
          ).copyWith(
            height: 0.0,
            letterSpacing: 0.3,
          ),
          suffixIconColor: ColorsManager.primaryDarkPurple,
          iconColor: ColorsManager.primaryDarkPurple,
          labelStyle: getRegularStyle(
              color: ColorsManager.primaryTxtDarkGrey, fontSize: FontSize.s14),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorsManager.primaryDarkPurple, width: AppSize.s1),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s6))),
          errorBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorsManager.error, width: AppSize.s1),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s6))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorsManager.secondaryBgDarkOpacity50, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s6))),
          focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorsManager.primaryDarkPurple, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s6)))),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.shifting,
          elevation: 15.0,
          selectedIconTheme: IconThemeData(
              color: ColorsManager.primaryDarkPurple, size: AppSize.s22.h),
          unselectedIconTheme: IconThemeData(
              color: ColorsManager.primaryOffWhite, size: AppSize.s22.h),
          selectedLabelStyle: getExtraBoldStyle(
              color: ColorsManager.primaryDarkPurple, fontSize: AppSize.s11)
            ..copyWith(fontWeight: FontWeight.w800),
          unselectedLabelStyle: getRegularStyle(
              color: ColorsManager.primaryOffWhite, fontSize: AppSize.s11),
          selectedItemColor: ColorsManager.primaryDarkPurple,
          unselectedItemColor: ColorsManager.primaryOffWhite,
          showSelectedLabels: true,
          showUnselectedLabels: true),
      drawerTheme: const DrawerThemeData(
        backgroundColor: ColorsManager.white,
      ));
}

ThemeData lightApplicationTheme({
  required double fontSize22,
  required double fontSize20,
  required double fontSize18,
  required double fontSize16,
  required double fontSize15,
  required double fontSize14,
  required double fontSize13,
  required double fontSize12,
  required double fontSize10,
}) {
  return ThemeData(
      scaffoldBackgroundColor: ColorsManager.primaryLightPurple,
      primaryColorLight: ColorsManager.primaryDark,
      primaryColorDark: ColorsManager.primaryOffWhite,
      cardColor: ColorsManager.secondaryCardsBg1,
      unselectedWidgetColor: ColorsManager.primaryDarkPurple,
      indicatorColor: ColorsManager.secondaryCardsBg1,
      secondaryHeaderColor: ColorsManager.secondaryOffWhite,
      dividerColor: ColorsManager.secondaryCardsBg1,
      primaryColor: ColorsManager.primaryDark,
      dialogBackgroundColor: ColorsManager.secondaryCardsBg1,
      disabledColor: ColorsManager.white,
      shadowColor: ColorsManager.primaryDark50,
      focusColor: ColorsManager.primaryDarkPurple,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: ColorsManager.white,
              statusBarIconBrightness: Brightness.dark),
          color: ColorsManager.primaryDark80,
          elevation: 0.0,
          centerTitle: true,
          titleTextStyle: getBoldStyle(
              color: ColorsManager.primaryOffWhite, fontSize: FontSize.s18)),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: ColorsManager.primaryDark80),
      textTheme: TextTheme(
        /// al head text f login,register,complete form ...etc
        displayLarge: getExtraBoldStyle(
            //offWhite light
            color: ColorsManager.primaryDarkPurple,
            fontSize: fontSize18),
        headlineLarge: getExtraBoldStyle(
            color: ColorsManager.primaryOffWhite, fontSize: fontSize22),
        // headline1: getExtraBoldStyle(
        //     color: ColorsManager.primaryDarkPurple, fontSize: fontSize20),
        headlineSmall: getRegularStyle(
            color: ColorsManager.primaryDarkPurple, fontSize: fontSize13),
        titleLarge: getExtraBoldStyle(
            color: ColorsManager.primaryDarkPurple, fontSize: fontSize16),
        // used
        titleMedium: getRegularStyle(
            color: ColorsManager.primaryDarkPurple, fontSize: fontSize18),
        titleSmall: getRegularStyle(
            color: ColorsManager.primaryDarkPurple, fontSize: fontSize13),
        bodyLarge: getBoldStyle(
            color: ColorsManager.primaryOffWhite, fontSize: fontSize18),
        // used
        displayMedium: getBoldStyle(
            color: ColorsManager.primaryDarkPurple, fontSize: fontSize16),
        bodyMedium: getBoldStyle(
            color: ColorsManager.primaryDarkPurple, fontSize: fontSize18),
        bodySmall: getRegularStyle(
            color: ColorsManager.primaryDarkPurple, fontSize: fontSize10),
      ),
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: ColorsManager.primaryDarkPurple,
          selectionHandleColor: ColorsManager.primaryDarkPurple,
          selectionColor: ColorsManager.primaryLightPurple),
      buttonTheme:
          const ButtonThemeData(buttonColor: ColorsManager.primaryDarkPurple),
      dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.only(
                  right: 0,
                  left: AppSize.s12,
                  top: AppSize.s15,
                  bottom: AppSize.s15),
              hintStyle: getRegularStyle(
                color: ColorsManager.primaryTxt1LightGrey,
                fontSize: AppSize.s14,
              ))),

      //input decoration theme(text form field)
      inputDecorationTheme: InputDecorationTheme(
          errorMaxLines: 3,
          errorStyle: getRegularStyle(
              color: ColorsManager.error, fontSize: AppSize.s10.sp),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSize.s16, vertical: AppSize.s12),
          hintStyle: getRegularStyle(
            color: ColorsManager.primaryTxt1LightGrey,
            fontSize: FontSize.s14,
          ).copyWith(
            height: 0.0,
            letterSpacing: 0.3,
          ),
          suffixIconColor: ColorsManager.primaryTxtDarkGrey,
          iconColor: ColorsManager.primaryTxtDarkGrey,
          labelStyle: getRegularStyle(
              color: ColorsManager.primaryBgDark, fontSize: FontSize.s14),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorsManager.secondaryBgDarkOpacity50, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s6))),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorsManager.primaryDarkPurple, width: AppSize.s1),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s6))),
          errorBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorsManager.error, width: AppSize.s1),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s6))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorsManager.secondaryBgDarkOpacity50, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s6))),
          focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorsManager.primaryDarkPurple, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s6)))),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ColorsManager.secondaryCardsBg1,
          type: BottomNavigationBarType.shifting,
          elevation: 15.0,
          selectedIconTheme: IconThemeData(
              color: ColorsManager.primaryDarkPurple, size: AppSize.s22.h),
          unselectedIconTheme: IconThemeData(
              color: ColorsManager.primaryText1Sliver, size: AppSize.s22.h),
          selectedLabelStyle: getExtraBoldStyle(
              color: ColorsManager.primaryDarkPurple, fontSize: AppSize.s11)
            ..copyWith(fontWeight: FontWeight.w800),
          unselectedLabelStyle: getRegularStyle(
              color: ColorsManager.primaryText1Sliver, fontSize: AppSize.s11),
          selectedItemColor: ColorsManager.primaryDarkPurple,
          unselectedItemColor: ColorsManager.primaryText1Sliver,
          showSelectedLabels: true,
          showUnselectedLabels: true),
      drawerTheme: const DrawerThemeData(
        backgroundColor: ColorsManager.white,
      ));
}
