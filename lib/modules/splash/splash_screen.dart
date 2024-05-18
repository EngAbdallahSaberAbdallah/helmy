import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helmy_project/app/components.dart';
import 'package:helmy_project/resources/assets_manager.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import 'package:helmy_project/resources/routes_manager.dart';
import '../../app/constants.dart';
import '../../helpers/cache_helper.dart';
import '../../helpers/services_locator.dart';
import '../../network/network_constants.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: Constants.splashDelay), _goNext);
  }

  _getLang() async {
    NetworkConstants.lang = await getIt<CacheHelper>().getAppLanguage();
  }

  void _getToken() async {
    NetworkConstants.token = await getIt.get<CacheHelper>().getToken() ?? '';
  }

  void _getOnboarding() async {
    NetworkConstants.onboarding =
        await getIt.get<CacheHelper>().getOnBoarding() ?? false;
  }

  void _goNext() async {
    final bool isInterpreter =
        await getIt.get<CacheHelper>().getIsInterpreter() ?? false;
    if (NetworkConstants.onboarding!) {
      NetworkConstants.token.isNotEmpty
          ? isInterpreter
              ? Get.offAllNamed(HelmyRoutes.interpreterStartRoute)
              : Get.offAllNamed(HelmyRoutes.userStartRoute)
          :
          //  Get.offAll(()=> const Registration());
          Get.offAllNamed(HelmyRoutes.userStartRoute);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, HelmyRoutes.onboardingRoute, (route) => false);
    }
  }

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    super.initState();
    _startDelay();
    _getOnboarding();
    _getToken();
    _getLang();
  }

  @override
  Widget build(BuildContext context) {
    return
        //  BlocBuilder<ThemeModeCubit, ThemeModeState>(
        //   builder: (context, state) {
        // return
        StatusBarChangedWidget(
      statusBarColor: ColorsManager.trans,
      widget: Scaffold(
          backgroundColor: ColorsManager.primaryDarkPurple,
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              Lottie.asset(AssetsManager.loadingSplashScreen,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover)
            ],
          )),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
