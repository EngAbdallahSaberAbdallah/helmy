// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helmy_project/app/components.dart';
import 'package:helmy_project/resources/strings_manager.dart';
import 'package:helmy_project/resources/styles_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:helmy_project/modules/auth/models/cities_response.dart';
import 'package:helmy_project/resources/assets_manager.dart';
import '../modules/onboarding/cubits/onboarding_cubit/onboarding_cubit.dart';

import '../resources/colors_manager.dart';
import '../resources/values_manager.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> buildNextPage(PageController pageController) {
  return pageController.nextPage(
      duration: const Duration(milliseconds: 750),
      curve: Curves.fastLinearToSlowEaseIn);
}

String convertStringDateTimeToReadableDateTime({required String dateTime}) {
  return DateFormat('dd-MM-yyyy   h:mm')
          .format(DateTime.parse(dateTime).toLocal()) +
      DateFormat('a ').format(DateTime.parse(dateTime).toLocal());
}

String getDifferenceDateTime({required String dateTime}) {
  DateTime providedTime = DateTime.parse(dateTime).toLocal();

  // Get the current time
  DateTime currentTime = DateTime.now();

  // Calculate the difference
  Duration difference = currentTime.difference(providedTime);

  return '${difference.inDays > 0 ? "${difference.inDays} ${difference.inDays > 1 ? tr(StringsManager.days) : tr(StringsManager.day)} : " : ""}${difference.inHours > 0 ? "${difference.inDays > 0 ? difference.inHours - (difference.inDays * 24) : difference.inHours} ${difference.inHours > 1 ? tr(StringsManager.hours) : tr(StringsManager.hour)} : " : ""}${difference.inMinutes > 0 ? " ${difference.inHours > 0 ? difference.inMinutes - (difference.inHours * 60) : difference.inMinutes} ${difference.inMinutes > 1 ? tr(StringsManager.minutes) : tr(StringsManager.minute)}" : ""}';
}

showCustomDialog(
    {required String imgPath,
    required String content,
    required String btnName1,
    required String btnName2,
    required dynamic btn1OnPressed,
    required dynamic btn2OnPressed,
    required BuildContext context}) {
  return showDialog(
    context: context,
    builder: (context) => Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorsManager.primaryLightPurple),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imgPath,
            width: 149.w,
            height: 137.h,
            fit: BoxFit.cover,
          ),
          Text(
            content,
            style: getRegularStyle(
              color: ColorsManager.primaryDarkPurple,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                  btnName: btnName1,
                  onPressed: btn1OnPressed,
                  btnBackgroundColor: ColorsManager.primaryDarkPurple,
                  btnNameColor: Colors.white),
              const SizedBox(
                width: 8,
              ),
              CustomElevatedButton(
                  btnName: btnName2,
                  onPressed: btn2OnPressed,
                  btnBackgroundColor: ColorsManager.btnBackgroundColorRed,
                  btnNameColor: Colors.white),
            ],
          )
        ],
      ),
    ),
  );
}

Color appointmentStatusColor({required String status}) {
  switch (status) {
    case 'pending':
      return Colors.transparent;
    case 'accepted':
      return ColorsManager.primaryDarkPurple;
    case 'rejected':
      return ColorsManager.error;
    case 'completed':
      return Colors.white;
    default:
      return Colors.white;
  }
}

/*
  "كل الطلبات",
    "الطلبات الحالية",
    "الطلبات المقبولة",
    "الطلبات المرفوضة",
    "الطلبات المنتهية",
 */
String appointmentStatusText({required String status}) {
  switch (status) {
    case 'pending':
      return "في انتظار المحامي";
    case 'accepted':
      return "انتظار الدفع";
    case 'rejected':
      return "طلب مرفوض";
    case 'completed':
      return "تمت الاستشارة";
    case 'canceled':
      return "تم سحب الاستشارة";
    case "paid":
      return "تم الدفع بنجاح";
    default:
      return "غير محدد";
  }
}

Color chooseColor({required int currentIndex, required checkIndex}) {
  if (currentIndex >= checkIndex) {
    return ColorsManager.primaryDarkPurple;
  } else {
    return ColorsManager.secondaryCardsBg2;
  }
}

Future<dynamic> buildPushReplacement(BuildContext context, Widget page) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

double calcHeight(double inputNumber, BuildContext context) {
  double screenHeight = 797; // Your screen height
  double calculatedHeight =
      MediaQuery.sizeOf(context).height * (inputNumber / screenHeight);
  return calculatedHeight;
}

double calcWidth(double inputNumber, BuildContext context) {
  double screenWidth = 390; // Your screen height
  double calculatedHeight =
      MediaQuery.sizeOf(context).width * (inputNumber / screenWidth);
  return calculatedHeight;
}

Future<void> customDialog(
    {required BuildContext context, required Widget widget}) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s6),
          ),
          elevation: AppSize.s10,
          child: widget,
        );
      });
}

void statusBarDarkLightSwitchFunction(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          // context.read<ThemeModeCubit>().state.isDark
          // ? ColorsManager.primaryDark100
          // :
          Colors.transparent,
      statusBarIconBrightness:
          // context.read<ThemeModeCubit>().state.isDark
          //     ? Brightness.light
          //     :
          Brightness.light));
}

void statusBarWithoutTheme() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
}

void pushNavigator({required BuildContext context, required Widget widget}) {
  Navigator.push<void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => widget,
    ),
  );
}

void pushNavigatorReplacement(
    {required BuildContext context, required Widget widget}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => widget,
    ),
  );
}

double calculateResponsiveTextSize(BuildContext context, double baseSize) {
  final screenWidth = MediaQuery.of(context).size.width;
  final scaleFactor = screenWidth / 390.0; // 375.0 is a reference width
  return baseSize * scaleFactor;
}

void pushWithRemoveAllRoutes(
    {required BuildContext context, required Widget widget}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    // Replace with the new route you want to navigate to
    (route) => false, // This predicate removes all routes from the stack
  );
}

String chooseStatus({required String status}) {
  if (status == 'pending') {
    return tr('waiting_for_lawyer_approval');
  } else if (status == 'accepted') {
    return tr('your_consultation_request_has_been_successfully_accepted');
  } else {
    return tr('sorry_your_consultation_request_was_rejected');
  }
}

Color chooseCurrentAppointmentsColor({required String status}) {
  if (status == 'pending') {
    return ColorsManager.primaryDark;
  } else if (status == 'accepted') {
    return ColorsManager.primaryDarkPurple;
  } else {
    return ColorsManager.error;
  }
}

IconData chooseIcon({required String status}) {
  if (status == 'pending') {
    return Icons.timer;
  } else if (status == 'accepted') {
    return Icons.check_circle_outline;
  } else {
    return Icons.cancel_outlined;
  }
}

void Function()? getFunctionBasedOnStatus(String status) {
  switch (status) {
    case 'pending':
      return () {};
    case 'accepted':
      return () {
        debugPrint("This is the accepted function.");
      };
    case 'rejected':
      return () {
        debugPrint("This is the rejected function.");
      };
    default:
      return () {};
  }
}

class DefaultLoading extends StatelessWidget {
  const DefaultLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        type: MaterialType.canvas,
        color: Colors.white.withOpacity(0.4),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            width: calcWidth(AppSize.s90, context),
            height: calcHeight(AppSize.s90, context),
            padding: const EdgeInsets.all(0),
            child: Lottie.asset(
              AssetsManager.loadingLottie,
              width: calcWidth(AppSize.s80, context),
              height: calcHeight(AppSize.s80, context),
            ),
          ),
        ),
      ),
    );
  }
}

void openWhatsApp(String phoneNumber, BuildContext context) async {
  final link = WhatsAppUnilink(
    phoneNumber: phoneNumber, //'+001-(555)1234567'
    text: "",
  );
  await launch('$link');
}

Future loading(dialogContext) {
  return showDialog(
    context: dialogContext,
    builder: (context) => const Center(
        child: CircularProgressIndicator(
      color: ColorsManager.primaryDarkPurple,
    )),
    barrierDismissible: false,
  );
}

// bool isVibrating = false; // Flag to track vibration state

// void playRingtoneWithVibration() {
//   FlutterRingtonePlayer().play(
//     android: AndroidSounds.ringtone,
//     ios: IosSounds.glass,
//     looping: true,
//     volume: 1.0,
//   );

//   if (!isVibrating) {
//     isVibrating = true;
//     _vibrateLoop();
//   }
// }

// void stopRingtoneWithVibration() {
//   FlutterRingtonePlayer().stop();
//   isVibrating = false;
//   Vibration.cancel();
// }

// void _vibrateLoop() {
//   if (isVibrating) {
//     Vibration.vibrate(
//       pattern: [500, 1000, 500, 1000],
//       intensities: [1, 255],
//     ).then((_) {
//       // Delay between vibration pattern repetitions (e.g., 2 seconds)
//       Future.delayed(const Duration(seconds: 2), () {
//         _vibrateLoop(); // Recursive call for continuous vibration pattern
//       });
//     });
//   }
// }

Future<Uint8List> compressFile(File file) async {
  var result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    minWidth: 2300,
    minHeight: 1500,
    quality: 94,
    rotate: 90,
  );
  print(file.lengthSync());
  print(result!.length);
  return result;
}

List<String> buildAreaItems({
  required String? selectedCity,
  required List<Countries> citiesData,
}) {
  debugPrint('Selected City: $selectedCity');
  debugPrint(
      'Cities Data: ${citiesData.map((city) => city.name!.ar).toList()}');

  if (selectedCity == null) return [];

  final citiesList = citiesData.firstWhere(
    (city) => city.name!.ar.toString() == selectedCity,
    orElse: () => Countries(), // Provide a default CitiesData instance
  );

  debugPrint('Selected City Data: $citiesList');

  // if (citiesList != null && citiesList.areas != null) {
  //   return citiesList.areas!.map((area) => area.name!.ar.toString()).toList();
  // }

  return [];
}

int findAreaIdByName(List<Countries> data, String targetName) {
  for (var item in data) {
    if (item.name!.ar == targetName) {
      return item.id!;
    }
  }
  return -1; // Area not found
}
