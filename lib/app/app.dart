import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../helpers/getx_controllers.dart';
import '../main.dart';
import '../modules/splash/splash_screen.dart';
import '../resources/bloc_providers_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/themes_manager.dart';

class HelmyApp extends StatefulWidget {
  const HelmyApp({super.key});

  @override
  State<HelmyApp> createState() => _HelmyAppState();
}

class _HelmyAppState extends State<HelmyApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: blocProviderList,
        child: ScreenUtilInit(
          designSize: const Size(390, 892),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light));
            return GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context)
                    ..requestFocus(FocusNode());

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child:
                    //  BlocBuilder<ThemeModeCubit, ThemeModeState>(
                    //   builder: (context, state) {
                    // return
                    Obx(
                  () => GetMaterialApp(
                    navigatorObservers: [MyNavigatorObserver()],
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    debugShowCheckedModeBanner: false,
                    title: 'حلمي Helmy',
                    home: const SplashScreen(),
                    onGenerateRoute: HelmyRouteManager.generateRoute,
                    navigatorKey: navigatorKey,
                    themeMode: ThemeMode.light,
                    theme: lightApplicationTheme(
                        fontSize22:
                            GetXControllers.fontSizeController.fontSize22.value,
                        fontSize20:
                            GetXControllers.fontSizeController.fontSize20.value,
                        fontSize18:
                            GetXControllers.fontSizeController.fontSize18.value,
                        fontSize16:
                            GetXControllers.fontSizeController.fontSize16.value,
                        fontSize15:
                            GetXControllers.fontSizeController.fontSize15.value,
                        fontSize14:
                            GetXControllers.fontSizeController.fontSize14.value,
                        fontSize13:
                            GetXControllers.fontSizeController.fontSize13.value,
                        fontSize12:
                            GetXControllers.fontSizeController.fontSize12.value,
                        fontSize10: GetXControllers
                            .fontSizeController.fontSize10.value),
                  ),
                )
                //   },
                // ),
                );
          },
        ));
  }
}
